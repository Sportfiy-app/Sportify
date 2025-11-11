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

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    for (final controller in codeControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void goToVerify() {
    currentStep.value = ForgotPasswordStep.verify;
    Get.toNamed(Routes.forgotPasswordVerify);
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
    Get.snackbar(
      'Code envoyé',
      'Un nouveau code de vérification vient d\'être envoyé.',
    );
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
