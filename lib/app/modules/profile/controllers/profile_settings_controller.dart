import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileSettingsController extends GetxController {
  final RxString userName = 'Alexandre Martin'.obs;
  final RxString membership = 'Membre Premium'.obs;
  final RxString level = 'Niveau Expert'.obs;
  final RxString location = 'Paris, France'.obs;

  final RxInt reservationCount = 23.obs;
  final RxInt partnerCount = 89.obs;
  final RxInt trophiesCount = 12.obs;

  final RxBool notificationsEnabled = true.obs;
  final RxBool darkModeEnabled = false.obs;
  final RxBool autoInviteEnabled = false.obs;
  final RxBool profilePublic = true.obs;
  final RxBool shareLocation = true.obs;
  final RxBool rewardsEnabled = false.obs;
  final RxBool messageNotifications = true.obs;
  final RxBool matchReminders = true.obs;
  final RxBool invitationAlerts = true.obs;

  final RxList<FavoriteSport> favoriteSports = <FavoriteSport>[
    const FavoriteSport(name: 'Football', color: Color(0xFF176BFF)),
    const FavoriteSport(name: 'Basketball', color: Color(0xFF16A34A)),
    const FavoriteSport(name: 'Tennis', color: Color(0xFFFFB800)),
  ].obs;

  final RxString language = 'Français'.obs;
  final RxString dataExportStatus = 'Exporter, supprimer'.obs;

  String get versionLabel => 'Version 1.0.0';

  void openPersonalInfo() {
    Get.toNamed(Routes.profileInfo);
  }

  void openSecurity() {
    Get.toNamed(Routes.profileSecurity);
  }

  void openSubscription() {
    Get.snackbar('Abonnement', 'Gestion de l’abonnement à venir.');
  }

  void openPaymentMethods() {
    Get.toNamed(Routes.profilePaymentCard);
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
  }

  void toggleAutoInvite(bool value) {
    autoInviteEnabled.value = value;
  }

  void toggleProfilePublic(bool value) {
    profilePublic.value = value;
  }

  void toggleLocation(bool value) {
    shareLocation.value = value;
  }

  void toggleRewards(bool value) {
    rewardsEnabled.value = value;
  }

  void toggleMessageNotifications(bool value) {
    messageNotifications.value = value;
  }

  void toggleMatchReminders(bool value) {
    matchReminders.value = value;
  }

  void toggleInvitationAlerts(bool value) {
    invitationAlerts.value = value;
  }

  void openNotificationsSettings() {
    Get.snackbar('Notifications', 'Paramétrage détaillé bientôt disponible.');
  }

  void openLanguagePicker() {
    Get.toNamed(Routes.profileLanguage);
  }

  void openLocationSettings() {
    Get.snackbar('Localisation', 'Paramètres de localisation à venir.');
  }

  void openBlockedUsers() {
    Get.toNamed(Routes.profileBlockedUsers);
  }

  void addSport() {
    Get.snackbar('Ajouter un sport', 'Gestion des sports favoris prochainement.');
  }

  void openHelpCenter() {
    Get.toNamed(Routes.profileHelp);
  }

  void contactSupport() {
    Get.snackbar('Support', 'Chat direct avec le support à venir.');
  }

  void reportIssue() {
    Get.toNamed(Routes.reportProblem);
  }

  void rateApp() {
    Get.snackbar('Merci !', 'Merci pour votre évaluation 💙');
  }

  void viewTerms() {
    Get.toNamed(Routes.profileTermsPrivacy);
  }

  void viewPrivacyPolicy() {
    Get.toNamed(Routes.profileTermsPrivacy);
  }

  void downloadData() {
    Get.snackbar('Téléchargement', 'Vos données seront prêtes sous peu.');
  }

  void logoutAllDevices() {
    Get.snackbar('Déconnexion', 'Tous les appareils ont été déconnectés.');
  }

  void deleteAccount() {
    Get.toNamed(Routes.profileDeleteAccount);
  }
}

class FavoriteSport {
  const FavoriteSport({required this.name, required this.color});

  final String name;
  final Color color;
}

