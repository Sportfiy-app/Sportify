import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api/api_exception.dart';
import '../../../data/auth/auth_repository.dart';
import '../../../data/auth/auth_session.dart';
import '../../../routes/app_routes.dart';

enum LoginMode { email, phone }

class LoginController extends GetxController {
  LoginController(this._authRepository, this._authSession);

  final AuthRepository _authRepository;
  final AuthSession _authSession;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final countryCodeController = TextEditingController(text: '+33');
  final otpControllers = List.generate(6, (_) => TextEditingController());

  final RxBool obscurePassword = true.obs;
  final Rx<LoginMode> loginMode = LoginMode.email.obs;
  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is LoginMode) {
      loginMode.value = arg;
    } else if (Get.currentRoute == Routes.loginPhone) {
      loginMode.value = LoginMode.phone;
    } else {
      loginMode.value = LoginMode.email;
    }
  }

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
  }

  Future<void> submitEmailLogin() async {
    if (isSubmitting.value) return;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      Get.snackbar('Email requis', 'Veuillez saisir votre adresse email.');
      return;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar('Email invalide', 'Merci de vérifier le format de votre adresse email.');
      return;
    }
    if (password.isEmpty) {
      Get.snackbar('Mot de passe requis', 'Veuillez saisir votre mot de passe.');
      return;
    }

    isSubmitting.value = true;
    Get.focusScope?.unfocus();

    try {
      final tokens = await _authRepository.loginWithEmail(email: email, password: password);
      if (!tokens.hasTokens) {
        throw ApiException(500, 'Réponse inattendue du serveur.');
      }
      await _authSession.saveTokens(tokens);
      Get.offAllNamed(Routes.home);
      Get.snackbar('Bienvenue', 'Connexion réussie sur Sportify.');
    } on ApiException catch (error) {
      Get.snackbar('Connexion impossible', error.message);
    } catch (error) {
      Get.snackbar('Erreur', 'Une erreur inattendue est survenue. Merci de réessayer.');
    } finally {
      isSubmitting.value = false;
    }
  }

  void submitPhoneLogin() {
    Get.snackbar('Connexion par téléphone', 'La connexion SMS sera disponible prochainement.');
  }

  void resetPassword() {
    Get.toNamed(Routes.forgotPasswordRequest);
  }

  void contactSupport() {
    Get.snackbar('Support', 'Nous vous répondrons rapidement');
  }

  void createAccount() {
    Get.toNamed(Routes.registerPersonalInformation);
  }
}
