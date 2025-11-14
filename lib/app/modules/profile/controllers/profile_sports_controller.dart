import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSportsController extends GetxController {
  final sports = <ProfileSportEntry>[].obs;

  final RxString selectedSport = ''.obs;
  final levelController = TextEditingController();
  final rankingController = TextEditingController();

  final RxBool isSaving = false.obs;

  final List<ProfileSportOption> availableSports = const [
    ProfileSportOption(name: 'Football', color: Color(0xFFFFB800)),
    ProfileSportOption(name: 'Basketball', color: Color(0xFFF97316)),
    ProfileSportOption(name: 'Tennis', color: Color(0xFF16A34A)),
    ProfileSportOption(name: 'Padel', color: Color(0xFFEF4444)),
    ProfileSportOption(name: 'Running', color: Color(0xFF3B82F6)),
    ProfileSportOption(name: 'Danse', color: Color(0xFFC084FC)),
    ProfileSportOption(name: 'Natation', color: Color(0xFF0EA5E9)),
    ProfileSportOption(name: 'Yoga', color: Color(0xFF8B5CF6)),
    ProfileSportOption(name: 'Cyclisme', color: Color(0xFF22C55E)),
    ProfileSportOption(name: 'Fitness', color: Color(0xFFEC4899)),
  ];

  List<String> get sportNames => availableSports.map((sport) => sport.name).toList();

  void selectSport(String? value) {
    if (value == null) return;
    selectedSport.value = value;
  }

  void quickSelectSport(String sport) {
    selectedSport.value = sport;
  }

  void addSport() {
    final sportName = selectedSport.value.trim();
    if (sportName.isEmpty) {
      Get.snackbar('Sélection requise', 'Choisissez un sport avant de l’ajouter.');
      return;
    }
    if (sports.any((entry) => entry.name == sportName)) {
      Get.snackbar('Déjà ajouté', 'Ce sport est déjà présent dans votre liste.');
      return;
    }

    final option = availableSports.firstWhereOrNull((element) => element.name == sportName) ??
        ProfileSportOption(name: sportName, color: _randomColor());

    sports.add(
      ProfileSportEntry(
        name: sportName,
        color: option.color,
        level: levelController.text.trim().isEmpty ? null : levelController.text.trim(),
        ranking: rankingController.text.trim().isEmpty ? null : rankingController.text.trim(),
      ),
    );

    levelController.clear();
    rankingController.clear();
    selectedSport.value = '';

    Get.snackbar('Sport ajouté', '$sportName a été ajouté à votre liste.');
  }

  void removeSport(ProfileSportEntry entry) {
    sports.remove(entry);
    Get.snackbar('Sport supprimé', '${entry.name} a été retiré de votre liste.');
  }

  void reorderSports(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final entry = sports.removeAt(oldIndex);
    sports.insert(newIndex, entry);
  }

  Future<void> saveSports() async {
    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isSaving.value = false;
    Get.back(result: sports.toList());
    Get.snackbar('Mes sports', 'Vos sports ont été sauvegardés.');
  }

  Color _randomColor() {
    final rnd = Random();
    return Color.fromARGB(255, 100 + rnd.nextInt(155), 120 + rnd.nextInt(135), 140 + rnd.nextInt(115));
  }

  @override
  void onClose() {
    levelController.dispose();
    rankingController.dispose();
    super.onClose();
  }
}

class ProfileSportOption {
  const ProfileSportOption({required this.name, required this.color});

  final String name;
  final Color color;
}

class ProfileSportEntry {
  ProfileSportEntry({
    required this.name,
    required this.color,
    this.level,
    this.ranking,
  });

  final String name;
  final Color color;
  final String? level;
  final String? ranking;
}

