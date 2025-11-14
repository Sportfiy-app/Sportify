import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/users/users_repository.dart';
import '../../../data/api/api_exception.dart';
import 'profile_controller.dart';

class ProfileInfoController extends GetxController {
  final UsersRepository _usersRepository = Get.find<UsersRepository>();
  
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final countryCodeController = TextEditingController(text: '+33');

  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedGender = 'Femme'.obs;
  final RxString timezone = DateTime.now().timeZoneName.obs;

  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxBool showSuccessBanner = false.obs;
  final RxSet<String> touchedFields = <String>{}.obs;

  final List<String> genders = const [
    'Femme',
    'Homme',
    'Non-binaire',
    'Préfère ne pas dire',
    'Autre',
  ];

  final List<String> _cityCatalog = const [
    'Paris',
    'Marseille',
    'Lyon',
    'Toulouse',
    'Nice',
    'Nantes',
    'Strasbourg',
    'Montpellier',
    'Bordeaux',
    'Lille',
  ];

  List<String> getCitySuggestions(String pattern) {
    final query = pattern.trim().toLowerCase();
    if (query.isEmpty) {
      return _cityCatalog.take(5).toList();
    }
    return _cityCatalog.where((city) => city.toLowerCase().contains(query)).take(8).toList();
  }

  String get formattedDate {
    final date = selectedDate.value;
    if (date == null) return 'JJ/MM/AAAA';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  bool get isFormValid {
    return lastNameController.text.trim().isNotEmpty &&
        firstNameController.text.trim().isNotEmpty &&
        selectedGender.value.isNotEmpty;
  }

  Future<void> pickDate(BuildContext context) async {
    final initialDate = selectedDate.value ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Sélectionnez votre date de naissance',
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null) {
      selectedDate.value = picked;
      touchedFields.add('date');
    }
  }

  void onGenderChanged(String? value) {
    if (value == null) return;
    selectedGender.value = value;
    touchedFields.add('gender');
  }

  void onCitySelected(String value) {
    cityController.text = value;
    touchedFields.add('city');
  }

  void onTimezoneTapped() {
    Get.snackbar('Fuseau horaire', 'Détection automatique : ${timezone.value}');
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    try {
      final user = await _usersRepository.getCurrentUser();
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      emailController.text = user.email;
      phoneController.text = user.phone ?? '';
      // Note: city, date of birth, gender are not in backend yet
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading profile: $e');
      }
      Get.snackbar('Erreur', 'Impossible de charger le profil');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProfile() async {
    if (!isFormValid) {
      Get.snackbar('Champs requis', 'Veuillez compléter les champs obligatoires.');
      return;
    }

    isSaving.value = true;
    try {
      await _usersRepository.updateProfile(
        firstName: firstNameController.text.trim().isNotEmpty ? firstNameController.text.trim() : null,
        lastName: lastNameController.text.trim().isNotEmpty ? lastNameController.text.trim() : null,
        phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
      );

      showSuccessBanner.value = true;
      Future.delayed(const Duration(milliseconds: 1600), () {
        showSuccessBanner.value = false;
      });

      // Refresh profile in ProfileController if it exists
      try {
        final profileController = Get.find<ProfileController>();
        await profileController.refreshProfile();
      } catch (_) {
        // ProfileController not found, ignore
      }

      Get.back(result: true);
      Get.snackbar('Profil mis à jour', 'Vos informations ont été enregistrées.');
    } catch (e) {
      if (e is ApiException) {
        Get.snackbar('Erreur', e.message);
      } else {
        Get.snackbar('Erreur', 'Impossible de mettre à jour le profil');
      }
      if (kDebugMode) {
        debugPrint('Error saving profile: $e');
      }
    } finally {
      isSaving.value = false;
    }
  }

  void cancel() {
    Get.back();
  }

  @override
  void onClose() {
    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    countryCodeController.dispose();
    super.onClose();
  }
}

