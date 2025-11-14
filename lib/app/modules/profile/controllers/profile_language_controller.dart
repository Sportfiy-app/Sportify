import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileLanguageController extends GetxController {
  final RxString currentLanguageCode = 'fr'.obs;
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final List<LanguageOption> recommendedLanguages = const [
    LanguageOption(code: 'fr', name: 'Français', region: 'Europe', speakersLabel: '274 M', flag: '🇫🇷'),
    LanguageOption(code: 'en', name: 'Anglais', region: 'International', speakersLabel: '1.4 B', flag: '🇬🇧'),
    LanguageOption(code: 'ar', name: 'Arabe', region: 'Moyen-Orient', speakersLabel: '420 M', flag: '🇸🇦'),
  ];

  final List<LanguageOption> recentLanguages = [
    const LanguageOption(code: 'es', name: 'Espagnol', region: 'Europe & LATAM', speakersLabel: '548 M', flag: '🇪🇸'),
    const LanguageOption(code: 'de', name: 'Allemand', region: 'Europe', speakersLabel: '135 M', flag: '🇩🇪'),
    const LanguageOption(code: 'it', name: 'Italien', region: 'Europe', speakersLabel: '85 M', flag: '🇮🇹'),
  ];

  late final Map<String, List<LanguageOption>> groupedLanguages = {
    'Populaire': [
      const LanguageOption(code: 'fr', name: 'Français', region: 'Europe', speakersLabel: '274 M', flag: '🇫🇷'),
      const LanguageOption(code: 'en', name: 'Anglais', region: 'International', speakersLabel: '1.4 B', flag: '🇬🇧'),
      const LanguageOption(code: 'ar', name: 'Arabe', region: 'Moyen-Orient', speakersLabel: '420 M', flag: '🇸🇦'),
      const LanguageOption(code: 'es', name: 'Espagnol', region: 'Europe & LATAM', speakersLabel: '548 M', flag: '🇪🇸'),
      const LanguageOption(code: 'de', name: 'Allemand', region: 'Europe', speakersLabel: '135 M', flag: '🇩🇪'),
    ],
    'Europe': [
      const LanguageOption(code: 'it', name: 'Italien', region: 'Europe', speakersLabel: '85 M', flag: '🇮🇹'),
      const LanguageOption(code: 'pt', name: 'Portugais', region: 'Europe & LATAM', speakersLabel: '260 M', flag: '🇵🇹'),
      const LanguageOption(code: 'nl', name: 'Néerlandais', region: 'Europe', speakersLabel: '30 M', flag: '🇳🇱'),
      const LanguageOption(code: 'pl', name: 'Polonais', region: 'Europe', speakersLabel: '45 M', flag: '🇵🇱'),
    ],
    'Afrique & Moyen-Orient': [
      const LanguageOption(code: 'sw', name: 'Swahili', region: 'Afrique', speakersLabel: '200 M', flag: '🇰🇪'),
      const LanguageOption(code: 'he', name: 'Hébreu', region: 'Moyen-Orient', speakersLabel: '9 M', flag: '🇮🇱'),
      const LanguageOption(code: 'am', name: 'Amharique', region: 'Afrique', speakersLabel: '32 M', flag: '🇪🇹'),
    ],
    'Asie & Pacifique': [
      const LanguageOption(code: 'zh', name: 'Mandarin', region: 'Asie', speakersLabel: '1.1 B', flag: '🇨🇳'),
      const LanguageOption(code: 'ja', name: 'Japonais', region: 'Asie', speakersLabel: '126 M', flag: '🇯🇵'),
      const LanguageOption(code: 'ko', name: 'Coréen', region: 'Asie', speakersLabel: '82 M', flag: '🇰🇷'),
      const LanguageOption(code: 'hi', name: 'Hindi', region: 'Asie', speakersLabel: '600 M', flag: '🇮🇳'),
    ],
    'Amériques': [
      const LanguageOption(code: 'en-US', name: 'Anglais (US)', region: 'USA & Canada', speakersLabel: '330 M', flag: '🇺🇸'),
      const LanguageOption(code: 'fr-CA', name: 'Français (Canada)', region: 'Canada', speakersLabel: '7.2 M', flag: '🇨🇦'),
      const LanguageOption(code: 'es-MX', name: 'Espagnol (Mexique)', region: 'LATAM', speakersLabel: '130 M', flag: '🇲🇽'),
      const LanguageOption(code: 'pt-BR', name: 'Portugais (Brésil)', region: 'LATAM', speakersLabel: '214 M', flag: '🇧🇷'),
    ],
  };

  List<LanguageOption> get allLanguages => groupedLanguages.values.expand((list) => list).toList();

  List<LanguageOption> get filteredLanguages {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) {
      return allLanguages;
    }
    return allLanguages
        .where(
          (lang) =>
              lang.name.toLowerCase().contains(query) ||
              lang.region.toLowerCase().contains(query) ||
              lang.code.toLowerCase().contains(query),
        )
        .toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  void selectLanguage(LanguageOption option) {
    currentLanguageCode.value = option.code;
    if (!recentLanguages.any((lang) => lang.code == option.code)) {
      recentLanguages.insert(0, option);
      if (recentLanguages.length > 5) {
        recentLanguages.removeLast();
      }
    }
  }

  bool isSelected(LanguageOption option) => currentLanguageCode.value == option.code;

  void openLanguageDetails(LanguageOption option) {
    Get.snackbar(option.name, 'Région : ${option.region} • Locuteurs : ${option.speakersLabel}');
  }

  void openHelpCenter() {
    Get.toNamed(Routes.profileTermsPrivacy);
  }

  void goBack() {
    Get.back(result: currentLanguageCode.value);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class LanguageOption {
  const LanguageOption({
    required this.code,
    required this.name,
    required this.region,
    required this.speakersLabel,
    required this.flag,
  });

  final String code;
  final String name;
  final String region;
  final String speakersLabel;
  final String flag;
}

