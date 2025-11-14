import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';

class ProfileSecurityPhoneController extends GetxController {
  ProfileSecurityPhoneController() {
    phoneController.text = '6 12 34 56 78';
  }

  final Rx<CountryOption> selectedCountry = CountryOption(flag: '🇫🇷', name: 'France', dialCode: '+33').obs;
  final TextEditingController phoneController = TextEditingController();
  final RxString phoneError = ''.obs;
  final RxString currentPhone = '+33 6 12 34 56 78'.obs;

  final List<CountryOption> countries = const [
    CountryOption(flag: '🇫🇷', name: 'France', dialCode: '+33'),
    CountryOption(flag: '🇧🇪', name: 'Belgique', dialCode: '+32'),
    CountryOption(flag: '🇨🇭', name: 'Suisse', dialCode: '+41'),
    CountryOption(flag: '🇨🇦', name: 'Canada', dialCode: '+1'),
    CountryOption(flag: '🇺🇸', name: 'États-Unis', dialCode: '+1'),
    CountryOption(flag: '🇬🇧', name: 'Royaume-Uni', dialCode: '+44'),
    CountryOption(flag: '🇪🇸', name: 'Espagne', dialCode: '+34'),
    CountryOption(flag: '🇩🇪', name: 'Allemagne', dialCode: '+49'),
  ];

  void openCountryPicker() {
    Get.bottomSheet<void>(
      Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Sélectionner un pays',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    leading: Text(country.flag, style: const TextStyle(fontSize: 20)),
                    title: Text('${country.name} (${country.dialCode})', style: GoogleFonts.inter(fontSize: 16)),
                    onTap: () {
                      selectedCountry.value = country;
                      Get.back();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );
  }

  Future<void> submit() async {
    phoneError.value = '';
    final digits = phoneController.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 6) {
      phoneError.value = 'Entrez un numéro valide';
      return;
    }

    final formatted = _formatNumber(digits);
    final fullNumber = '${selectedCountry.value.dialCode} $formatted';

    Get.focusScope?.unfocus();
    final result = await Get.toNamed<bool>(
      Routes.profileSecurityPhoneVerify,
      arguments: {'phone': fullNumber},
    );
    if (result == true) {
      currentPhone.value = fullNumber;
      Get.back();
      Get.snackbar('Numéro vérifié', 'Votre numéro a été mis à jour avec succès.');
    }
  }

  String _formatNumber(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if ((i % 2 == 1) && i != digits.length - 1) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}

class CountryOption {
  const CountryOption({required this.flag, required this.name, required this.dialCode});

  final String flag;
  final String name;
  final String dialCode;
}

