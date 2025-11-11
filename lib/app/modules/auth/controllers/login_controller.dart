import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

enum LoginMode { email, phone }

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final countryCodeController = TextEditingController(text: '+33');
  final otpControllers = List.generate(6, (_) => TextEditingController());

  final RxBool obscurePassword = true.obs;
  final Rx<LoginMode> loginMode = LoginMode.email.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    countryCodeController.dispose();
    for (final controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void setMode(LoginMode mode) {
    if (loginMode.value == mode) {
      return;
    }
    loginMode.value = mode;
    switch (mode) {
      case LoginMode.email:
        if (Get.currentRoute != Routes.loginEmail) {
          Get.offNamed(Routes.loginEmail);
        }
        break;
      case LoginMode.phone:
        if (Get.currentRoute != Routes.loginPhone) {
          Get.offNamed(Routes.loginPhone);
        }
        break;
    }
  }

  void submitEmailLogin() {
    // TODO: Hook into auth service.
    Get.snackbar('Connexion', 'Email login triggered');
  }

  void submitPhoneLogin() {
    // TODO: Hook into auth service & OTP verification.
    Get.snackbar('Connexion', 'Phone login triggered');
  }

  void resetPassword() {
    Get.toNamed(Routes.forgotPasswordRequest);
  }

  void contactSupport() {
    Get.snackbar('Support', 'Nous vous répondrons rapidement');
  }

  void createAccount() {
    // TODO: Navigate to registration flow.
    Get.snackbar('Nouveau compte', 'Redirection vers inscription');
  }
}
