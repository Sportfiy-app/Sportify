import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_security_phone_controller.dart';

class ProfileSecurityPhoneVerifyController extends GetxController {
  ProfileSecurityPhoneVerifyController()
      : codeControllers = List.generate(_codeLength, (_) => TextEditingController()),
        focusNodes = List.generate(_codeLength, (_) => FocusNode());

  static const int _codeLength = 4;

  final List<TextEditingController> codeControllers;
  final List<FocusNode> focusNodes;

  final RxInt secondsLeft = 120.obs;
  final RxBool canResend = false.obs;
  final RxString errorMessage = ''.obs;
  late final String phoneDisplay;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    phoneDisplay = (Get.arguments?['phone'] as String?) ?? '';
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    secondsLeft.value = 120;
    canResend.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        timer.cancel();
        canResend.value = true;
      }
    });
  }

  void onDigitChanged(int index, String value) {
    errorMessage.value = '';
    if (value.length > 1) {
      codeControllers[index].text = value.substring(value.length - 1);
    }
    if (value.isNotEmpty && index < _codeLength - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void resendCode() {
    if (!canResend.value) return;
    Get.snackbar('Code renvoyé', 'Un nouveau code a été envoyé à $phoneDisplay.');
    _startCountdown();
  }

  Future<void> validateCode() async {
    final code = codeControllers.map((c) => c.text.trim()).join();
    if (code.length != _codeLength) {
      errorMessage.value = 'Saisissez les $_codeLength chiffres reçus par SMS.';
      return;
    }

    if (secondsLeft.value <= 0) {
      errorMessage.value = 'Code expiré. Demandez un nouveau code.';
      return;
    }

    // Simulate verification success.
    final phoneController = Get.find<ProfileSecurityPhoneController>();
    phoneController.currentPhone.value = phoneDisplay;
    Get.back<bool>(result: true);
    Get.snackbar('Numéro vérifié', 'Votre numéro a été confirmé.');
  }

  String get maskedPhone {
    if (phoneDisplay.isEmpty) return '';
    final parts = phoneDisplay.split(' ');
    if (parts.length < 2) return phoneDisplay;
    final dial = parts.first;
    final rest = parts.sublist(1).join(' ');
    if (rest.length < 4) return phoneDisplay;
    final masked = rest.replaceRange(2, rest.length - 2, '•• •• ••');
    return '$dial $masked';
  }

  String get formattedTimer {
    final minutes = secondsLeft.value ~/ 60;
    final seconds = secondsLeft.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final controller in codeControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}

