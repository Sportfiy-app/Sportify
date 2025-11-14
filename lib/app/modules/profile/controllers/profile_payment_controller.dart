import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_edit_controller.dart';

class ProfilePaymentController extends GetxController {
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final postalCodeController = TextEditingController();

  final RxString selectedCountry = 'France'.obs;
  final RxBool shouldSaveCard = true.obs;
  final RxBool isProcessing = false.obs;

  final List<String> availableCountries = const [
    'France',
    'Belgique',
    'Suisse',
    'Luxembourg',
    'Canada',
  ];

  String get formattedAmount => '16,99 €';

  void closeSheet() {
    Get.back();
  }

  Future<void> submitPayment() async {
    final number = cardNumberController.text.replaceAll(' ', '');
    final expiry = expiryController.text;
    final cvc = cvcController.text;

    if (!_isCardNumberValid(number)) {
      Get.snackbar('Numéro invalide', 'Vérifiez le numéro de carte.');
      return;
    }
    if (!_isExpiryValid(expiry)) {
      Get.snackbar('Expiration invalide', 'Utilisez le format MM/AA.');
      return;
    }
    if (cvc.length < 3) {
      Get.snackbar('CVC invalide', 'Vérifiez le code de sécurité.');
      return;
    }

    isProcessing.value = true;
    await Future.delayed(const Duration(milliseconds: 900));
    isProcessing.value = false;

    Get.back(result: true);
    Get.snackbar(
      'Paiement confirmé',
      'Le paiement de $formattedAmount a été validé.',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.find<ProfileEditController>().markSectionUpdated('profile_payments');
  }

  bool _isCardNumberValid(String number) {
    if (number.length < 12) return false;
    return _luhnCheck(number);
  }

  bool _isExpiryValid(String expiry) {
    final sanitized = expiry.replaceAll(RegExp(r'[^0-9]'), '');
    if (sanitized.length != 4) return false;
    final month = int.tryParse(sanitized.substring(0, 2)) ?? 0;
    final year = int.tryParse(sanitized.substring(2)) ?? 0;
    if (month < 1 || month > 12) return false;
    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;
    if (year < currentYear) return false;
    if (year == currentYear && month < currentMonth) return false;
    return true;
  }

  bool _luhnCheck(String cardNumber) {
    var sum = 0;
    var shouldDouble = false;
    for (var i = cardNumber.length - 1; i >= 0; i--) {
      var digit = int.tryParse(cardNumber[i]) ?? 0;
      if (shouldDouble) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      shouldDouble = !shouldDouble;
    }
    return sum % 10 == 0;
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }
}

