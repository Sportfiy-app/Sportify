import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

enum ForgotPasswordStep { email, verify, done }

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final codeControllers = List.generate(6, (_) => TextEditingController());
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final Rx<ForgotPasswordStep> currentStep = ForgotPasswordStep.email.obs;
  final RxBool obscureNewPassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxInt resendSeconds = 120.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    for (final controller in codeControllers) {
      controller.dispose();
    }
    _resendTimer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    resendSeconds.value = 120;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void goToVerify() {
    currentStep.value = ForgotPasswordStep.verify;
    Get.toNamed(Routes.forgotPasswordVerify);
    _startTimer();
  }

  void goToEmail() {
    currentStep.value = ForgotPasswordStep.email;
    Get.offNamedUntil(Routes.forgotPasswordRequest, (route) => route.isFirst);
  }

  void goToConfirmation() {
    currentStep.value = ForgotPasswordStep.done;
    Get.toNamed(Routes.forgotPasswordEmailSent);
  }

  void resendCode() {
    _startTimer();
    Get.snackbar(
      'Code envoyé',
      'Un nouveau code de vérification vient d\'être envoyé.',
    );
  }

  void verifyCode() {
    Get.snackbar('Succès', 'Code vérifié avec succès !');
    goToConfirmation();
  }

  void contactSupport() {
    Get.snackbar('Support', 'Nous vous aiderons sous peu.');
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }
}
