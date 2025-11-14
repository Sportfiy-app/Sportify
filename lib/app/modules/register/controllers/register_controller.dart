import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/api/api_exception.dart';
import '../../../data/auth/auth_repository.dart';
import '../../../data/auth/auth_session.dart';
import '../../../data/auth/verification_repository.dart';
import '../../../data/users/users_repository.dart';
import '../../../data/users/user_sports_repository.dart';
import '../../../data/subscriptions/subscriptions_repository.dart';
import '../../../routes/app_routes.dart';
import '../widgets/modern_birth_date_picker.dart';

class RegisterController extends GetxController {
  RegisterController(this._authRepository, this._authSession);

  final AuthRepository _authRepository;
  final AuthSession _authSession;
  final VerificationRepository _verificationRepository = Get.find<VerificationRepository>();
  final UserSportsRepository _userSportsRepository = Get.find<UserSportsRepository>();
  final UsersRepository _usersRepository = Get.find<UsersRepository>();
  final SubscriptionsRepository _subscriptionsRepository = Get.find<SubscriptionsRepository>();
  final ImagePicker _imagePicker = ImagePicker();

  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final List<TextEditingController> smsCodeControllers =
      List.generate(6, (_) => TextEditingController());

  final Rx<DateTime?> selectedBirthDate = Rx<DateTime?>(null);
  final RxString gender = ''.obs;
  final RxBool acceptsTerms = false.obs;
  
  String get formattedBirthDate {
    final date = selectedBirthDate.value;
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
  
  Future<void> pickBirthDate(BuildContext context) async {
    final initialDate = selectedBirthDate.value ?? DateTime.now().subtract(const Duration(days: 365 * 25));
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => ModernBirthDatePicker(
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        locale: const Locale('fr', 'FR'),
      ),
    );
    if (picked != null) {
      selectedBirthDate.value = picked;
      birthDateController.text = formattedBirthDate;
    }
  }

  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxInt resendSeconds = 60.obs;
  final RxInt smsFilledCount = 0.obs;
  final RxBool isSubmitting = false.obs;
  
  // Country code selection
  final RxString selectedCountryCode = '+33'.obs;
  final RxString selectedCountryFlag = '🇫🇷'.obs;
  final RxString selectedCountryName = 'France'.obs;

  Timer? _resendTimer;
  final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  void selectGender(String value) {
    gender.value = value;
  }

  void toggleTerms(bool? value) {
    acceptsTerms.value = value ?? false;
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> continueRegistration() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty) {
      Get.snackbar('Email requis', 'Veuillez saisir votre adresse email.');
      return;
    }
    if (!_emailRegex.hasMatch(email)) {
      Get.snackbar('Email invalide', 'Merci de vérifier le format de votre adresse email.');
      return;
    }
    if (password.length < 8) {
      Get.snackbar('Mot de passe trop court', 'Le mot de passe doit contenir au moins 8 caractères.');
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar('Confirmation requise', 'Les mots de passe ne correspondent pas.');
      return;
    }
    if (!acceptsTerms.value) {
      Get.snackbar('Conditions requises', 'Veuillez accepter les conditions avant de continuer.');
      return;
    }

    // First, register the user
    final firstName = _trimOrNull(firstNameController.text);
    final lastName = _trimOrNull(lastNameController.text);
    final phoneInput = phoneController.text.trim();
    if (phoneInput.isEmpty) {
      Get.snackbar('Téléphone requis', 'Veuillez saisir votre numéro de téléphone.');
      return;
    }
    final phone = _normalizePhone(phoneInput);
    if (phone == null) {
      Get.snackbar('Téléphone invalide', 'Veuillez saisir un numéro de téléphone valide.');
      return;
    }
    final city = _trimOrNull(cityController.text);
    final genderValue = gender.value.isEmpty ? null : gender.value;
    
    String? dateOfBirth;
    if (selectedBirthDate.value != null) {
      dateOfBirth = DateTime.utc(
        selectedBirthDate.value!.year,
        selectedBirthDate.value!.month,
        selectedBirthDate.value!.day,
      ).toIso8601String();
    }

    try {
      _showLoading();
      final tokens = await _authRepository.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        dateOfBirth: dateOfBirth,
        gender: genderValue,
        city: city,
      );

      if (!tokens.hasTokens) {
        throw ApiException(500, 'Réponse inattendue du serveur.');
      }

      await _authSession.saveTokens(tokens);
      _hideLoading();

      // Send SMS code after registration
      try {
        if (kDebugMode) {
          debugPrint('Sending SMS code to phone: $phone');
        }
        final result = await _verificationRepository.sendSmsCode(phone);
        startResendTimer();
        
        // In development, show the code in a snackbar
        if (kDebugMode && result.containsKey('code')) {
          Get.snackbar(
            'Code SMS (Mode Dev)',
            'Votre code: ${result['code']}\nNuméro: $phone',
            duration: const Duration(seconds: 15),
            backgroundColor: const Color(0xFF176BFF),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(16),
            isDismissible: true,
          );
        } else if (kDebugMode) {
          debugPrint('SMS code sent but not returned in response. Check backend logs.');
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error sending SMS code: $e');
        }
        Get.snackbar(
          'Erreur',
          'Impossible d\'envoyer le code SMS. Vous pouvez le renvoyer.',
          duration: const Duration(seconds: 5),
        );
        // Continue anyway - user can resend
      }

      Get.toNamed(Routes.registerSmsValidation);
    } on ApiException catch (error) {
      _hideLoading();
      Get.snackbar('Inscription impossible', error.message);
    } catch (e) {
      _hideLoading();
      Get.snackbar('Erreur', 'Une erreur inattendue est survenue. Merci de réessayer.');
      if (kDebugMode) {
        debugPrint('Registration error: $e');
      }
    }
  }

  Future<void> submitSmsCode() async {
    final code = smsCodeControllers.map((controller) => controller.text.trim()).join();
    if (code.length < smsCodeControllers.length) {
      Get.snackbar('Code incomplet', 'Veuillez saisir les 6 chiffres du code.');
      return;
    }
    
    final phoneInput = phoneController.text.trim();
    if (phoneInput.isEmpty) {
      Get.snackbar('Téléphone requis', 'Veuillez saisir votre numéro de téléphone.');
      return;
    }
    
    // Normalize phone number with country code (same as when sending)
    final phone = _normalizePhone(phoneInput);
    if (phone == null) {
      Get.snackbar('Téléphone invalide', 'Veuillez saisir un numéro de téléphone valide.');
      return;
    }
    
    try {
      if (kDebugMode) {
        debugPrint('Verifying SMS code for phone: $phone');
      }
      await _verificationRepository.verifySmsCode(phone, code);
      
      // Send email verification after SMS is verified
      try {
        final email = emailController.text.trim();
        if (email.isNotEmpty) {
          await _verificationRepository.sendEmailVerification(email);
          if (kDebugMode) {
            debugPrint('Email verification sent to: $email');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error sending email verification: $e');
        }
        // Continue anyway - user can resend email
      }
      
      Get.toNamed(Routes.registerEmailVerification);
    } on ApiException catch (e) {
      Get.snackbar('Erreur', e.message);
    } catch (e) {
      Get.snackbar('Erreur', 'Une erreur est survenue lors de la vérification.');
      if (kDebugMode) {
        debugPrint('Error verifying SMS code: $e');
      }
    }
  }

  void startResendTimer() {
    resendSeconds.value = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> resendSmsCode() async {
    final phoneInput = phoneController.text.trim();
    if (phoneInput.isEmpty) {
      Get.snackbar('Téléphone requis', 'Veuillez saisir votre numéro de téléphone.');
      return;
    }
    
    if (resendSeconds.value > 0) {
      Get.snackbar('Attendez', 'Veuillez attendre ${resendSeconds.value} secondes avant de renvoyer le code.');
      return;
    }
    
    // Normalize phone number with country code
    final phone = _normalizePhone(phoneInput);
    if (phone == null) {
      Get.snackbar('Erreur', 'Numéro de téléphone invalide.');
      return;
    }
    
    try {
      if (kDebugMode) {
        debugPrint('Resending SMS code to phone: $phone');
      }
      final result = await _verificationRepository.sendSmsCode(phone);
      startResendTimer();
      
      // In development, show the code in a snackbar
      if (kDebugMode && result.containsKey('code')) {
        Get.snackbar(
          'Code SMS renvoyé (Mode Dev)',
          'Votre nouveau code: ${result['code']}\nNuméro: $phone',
          duration: const Duration(seconds: 15),
          backgroundColor: const Color(0xFF176BFF),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          isDismissible: true,
        );
      } else {
        Get.snackbar('Code renvoyé', 'Un nouveau code de validation vient d\'être envoyé.');
      }
    } on ApiException catch (e) {
      Get.snackbar('Erreur', e.message);
      if (kDebugMode) {
        debugPrint('API error resending SMS code: ${e.message}');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de renvoyer le code.');
      if (kDebugMode) {
        debugPrint('Error resending SMS code: $e');
      }
    }
  }

  void onSmsDigitChanged() {
    smsFilledCount.value = smsCodeControllers
        .where((controller) => controller.text.trim().isNotEmpty)
        .length;
  }

  bool get isSmsCodeComplete => smsFilledCount.value == smsCodeControllers.length;

  Future<void> resendVerificationEmail() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Email requis', 'Veuillez saisir votre adresse email.');
      return;
    }
    
    try {
      await _verificationRepository.sendEmailVerification(email);
      Get.snackbar('Email envoyé', 'Un nouvel email de vérification vient d\'être envoyé.');
    } on ApiException catch (e) {
      Get.snackbar('Erreur', e.message);
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible d\'envoyer l\'email de vérification.');
    }
  }

  void changeEmailAddress() {
    Get.back();
  }

  void continueAfterEmailVerification() {
    Get.toNamed(Routes.registerAddPhotos);
  }

  Future<void> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        if (selectedPhotos.length >= 6) {
          Get.snackbar('Limite atteinte', 'Vous pouvez ajouter jusqu\'à 6 photos.');
          return;
        }
        selectedPhotos.add(image);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error picking image: $e');
      }
      Get.snackbar('Erreur', 'Impossible de sélectionner l\'image.');
    }
  }

  void removePhoto(int index) {
    if (index >= 0 && index < selectedPhotos.length) {
      selectedPhotos.removeAt(index);
      if (primaryPhotoIndex.value >= selectedPhotos.length) {
        primaryPhotoIndex.value = selectedPhotos.isNotEmpty ? selectedPhotos.length - 1 : 0;
      }
    }
  }

  void setPrimaryPhoto(int index) {
    if (index >= 0 && index < selectedPhotos.length) {
      primaryPhotoIndex.value = index;
    }
  }

  Future<void> uploadPhotos() async {
    if (selectedPhotos.isEmpty) {
      Get.toNamed(Routes.registerSelectSports);
      return;
    }

    isUploadingPhoto.value = true;
    try {
      // Upload primary photo as avatar
      if (selectedPhotos.isNotEmpty) {
        // In production, upload to cloud storage (S3, Cloudinary, etc.) and get URL
        // For now, we'll use a placeholder URL
        final imageUrl = 'https://via.placeholder.com/400'; // Replace with actual upload
        
        if (_authSession.isAuthenticated) {
          await _usersRepository.uploadAvatar(imageUrl);
        }
      }
      
      // TODO: Upload other photos to a photos gallery endpoint
      
      Get.toNamed(Routes.registerSelectSports);
    } catch (e) {
      if (e is ApiException) {
        Get.snackbar('Erreur', e.message);
      } else {
        Get.snackbar('Erreur', 'Impossible d\'uploader les photos.');
      }
      if (kDebugMode) {
        debugPrint('Error uploading photos: $e');
      }
    } finally {
      isUploadingPhoto.value = false;
    }
  }

  void skipAddPhotos() {
    Get.snackbar('Photos ignorées', 'Vous pourrez ajouter des photos plus tard.');
    Get.toNamed(Routes.registerSelectSports);
  }

  Future<void> submitAddPhotos() async {
    await uploadPhotos();
  }
  
  int get photoCount => selectedPhotos.length;

  final RxString selectedSportName = ''.obs;
  final RxString selectedLevel = ''.obs;
  final TextEditingController rankingInputController = TextEditingController();
  final RxList<SportSelection> selectedSports = <SportSelection>[].obs;
  final RxString selectedPremiumPlan = 'monthly'.obs;
  
  // Profile photos
  final RxList<XFile> selectedPhotos = <XFile>[].obs;
  final RxInt primaryPhotoIndex = 0.obs;
  final RxBool isUploadingPhoto = false.obs;

  final List<String> availableSports = const [
    'Football',
    'Basketball',
    'Tennis',
    'Padel',
    'Running',
    'Cyclisme',
    'Natation',
    'Yoga',
  ];

  final List<String> levels = const [
    'Débutant',
    'Intermédiaire',
    'Confirmé',
    'Expert',
  ];

  void selectSport(String? value) {
    if (value != null) {
      selectedSportName.value = value;
    }
  }

  void selectLevel(String? value) {
    if (value != null) {
      selectedLevel.value = value;
    }
  }

  void quickSelectSport(String sport) {
    selectedSportName.value = sport;
  }

  Future<void> addSelectedSport() async {
    final name = selectedSportName.value.trim();
    if (name.isEmpty) {
      Get.snackbar('Sélection requise', 'Choisissez un sport avant de l\'ajouter.');
      return;
    }
    if (selectedSports.length >= 5) {
      Get.snackbar('Limite atteinte', 'Vous pouvez ajouter jusqu\'à 5 sports.');
      return;
    }
    if (selectedSports.any((sport) => sport.name == name)) {
      Get.snackbar('Déjà ajouté', 'Ce sport est déjà présent dans votre liste.');
      return;
    }
    
    // Add to local list first for immediate UI update
    final sportSelection = SportSelection(
      name: name,
      level: selectedLevel.value.isEmpty ? null : selectedLevel.value,
      ranking: rankingInputController.text.trim().isEmpty
          ? null
          : rankingInputController.text.trim(),
    );
    selectedSports.add(sportSelection);
    
    // If user is authenticated, save to backend
    if (_authSession.isAuthenticated) {
      try {
        await _userSportsRepository.addSport(
          sport: name,
          level: selectedLevel.value.isEmpty ? null : selectedLevel.value,
          ranking: rankingInputController.text.trim().isEmpty ? null : rankingInputController.text.trim(),
        );
      } catch (e) {
        // Remove from local list if backend save fails
        selectedSports.remove(sportSelection);
        if (e is ApiException) {
          Get.snackbar('Erreur', e.message);
        } else {
          Get.snackbar('Erreur', 'Impossible d\'ajouter le sport.');
        }
        return;
      }
    }
    
    selectedSportName.value = '';
    selectedLevel.value = '';
    rankingInputController.clear();
  }

  Future<void> removeSport(SportSelection sport) async {
    selectedSports.remove(sport);
    
    // If user is authenticated and sport has an ID, remove from backend
    // Note: SportSelection doesn't have ID yet, so this is for future enhancement
    // For now, we just remove from local list
  }

  bool get canFinishRegistration => selectedSports.isNotEmpty;

  void continueFromSelectSports() {
    if (!canFinishRegistration) {
      Get.snackbar('Ajoutez un sport', 'Ajoutez au moins un sport pour continuer.');
      return;
    }
    Get.toNamed(Routes.registerPushNotifications);
  }

  void skipSelectSports() {
    Get.snackbar('Sports ignorés', 'Vous pourrez ajouter des sports plus tard dans votre profil.');
    Get.toNamed(Routes.registerPushNotifications);
  }

  void openPremiumOffer() {
    Get.toNamed(Routes.registerPremiumOffer);
  }

  void openSubscriptionChoice() {
    Get.toNamed(Routes.registerSubscriptionChoice);
  }

  void skipNotificationsSetup() {
    if (isSubmitting.value) return;
    unawaited(finishRegistration());
  }

  void selectPremiumPlan(String plan) {
    selectedPremiumPlan.value = plan;
  }

  Future<void> subscribePremium() async {
    if (isSubmitting.value) return;
    
    if (selectedPremiumPlan.value.isEmpty) {
      Get.snackbar('Plan requis', 'Veuillez sélectionner un plan d\'abonnement.');
      return;
    }
    
    isSubmitting.value = true;
    _showLoading();
    
    try {
      await _subscriptionsRepository.createSubscription(
        plan: selectedPremiumPlan.value,
      );
      _hideLoading();
      Get.snackbar('Abonnement créé', 'Votre abonnement Premium est en cours d\'activation.');
      unawaited(finishRegistration());
    } on ApiException catch (e) {
      _hideLoading();
      Get.snackbar('Erreur', e.message);
    } catch (e) {
      _hideLoading();
      Get.snackbar('Erreur', 'Impossible de créer l\'abonnement.');
      if (kDebugMode) {
        debugPrint('Error creating subscription: $e');
      }
    } finally {
      isSubmitting.value = false;
    }
  }

  void restorePremiumSubscription() {
    Get.snackbar('Restaurer', 'Recherche d\'un abonnement existant...');
  }

  void skipPremiumOffer() {
    if (isSubmitting.value) return;
    unawaited(finishRegistration());
  }

  Future<void> finishRegistration() async {
    if (isSubmitting.value) return;

    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty || !_emailRegex.hasMatch(email)) {
      Get.snackbar('Email invalide', 'Un email valide est requis pour terminer votre inscription.');
      return;
    }
    if (password.length < 8) {
      Get.snackbar('Mot de passe trop court', 'Le mot de passe doit contenir au moins 8 caractères.');
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar('Confirmation requise', 'Les mots de passe ne correspondent pas.');
      return;
    }

    isSubmitting.value = true;
    Get.focusScope?.unfocus();
    _showLoading();

    final firstName = _trimOrNull(firstNameController.text);
    final lastName = _trimOrNull(lastNameController.text);
    final phone = _normalizePhone(phoneController.text);
    final city = _trimOrNull(cityController.text);
    final genderValue = gender.value.isEmpty ? null : gender.value;
    
    // Format dateOfBirth for backend
    String? dateOfBirth;
    if (selectedBirthDate.value != null) {
      dateOfBirth = DateTime.utc(
        selectedBirthDate.value!.year,
        selectedBirthDate.value!.month,
        selectedBirthDate.value!.day,
      ).toIso8601String();
    }

    try {
      final tokens = await _authRepository.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        dateOfBirth: dateOfBirth,
        gender: genderValue,
        city: city,
      );

      if (!tokens.hasTokens) {
        throw ApiException(500, 'Réponse inattendue du serveur.');
      }

      await _authSession.saveTokens(tokens);
      
      // Save user sports if any were selected
      if (selectedSports.isNotEmpty) {
        try {
          for (final sport in selectedSports) {
            await _userSportsRepository.addSport(
              sport: sport.name,
              level: sport.level,
              ranking: sport.ranking,
            );
          }
        } catch (e) {
          // Log error but don't block registration completion
          if (kDebugMode) {
            debugPrint('Error saving sports: $e');
          }
        }
      }
      
      _hideLoading();
      Get.offAllNamed(Routes.home);
      Get.snackbar('Bienvenue', 'Votre inscription est terminée.');
    } on ApiException catch (error) {
      _hideLoading();
      Get.snackbar('Inscription impossible', error.message);
    } catch (_) {
      _hideLoading();
      Get.snackbar('Erreur', 'Une erreur inattendue est survenue. Merci de réessayer.');
    } finally {
      isSubmitting.value = false;
    }
  }

  void _showLoading() {
    if (Get.isDialogOpen ?? false) return;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void _hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  String? _trimOrNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String? _normalizePhone(String value) {
    final trimmed = value.replaceAll(RegExp(r'[\s-]'), '').trim();
    if (trimmed.isEmpty) return null;
    // Add country code if not already present
    if (!trimmed.startsWith('+')) {
      // Remove leading 0 if present (common in French numbers)
      final cleaned = trimmed.startsWith('0') ? trimmed.substring(1) : trimmed;
      return '${selectedCountryCode.value}$cleaned';
    }
    return trimmed;
  }

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  @override
  void onClose() {
    lastNameController.dispose();
    firstNameController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    cityController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    rankingInputController.dispose();
    for (final controller in smsCodeControllers) {
      controller.dispose();
    }
    _resendTimer?.cancel();
    super.onClose();
  }
}

class SportSelection {
  SportSelection({required this.name, this.level, this.ranking});

  final String name;
  final String? level;
  final String? ranking;
}
