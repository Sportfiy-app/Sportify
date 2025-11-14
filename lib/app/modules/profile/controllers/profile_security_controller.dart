import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileSecurityController extends GetxController {
  final RxString email = 'david.doe@gmail.com'.obs;
  final RxString passwordUpdatedLabel = 'Modifié le 15 oct. 2024'.obs;
  final RxString phoneNumber = '+33 6 70 00 00 00'.obs;

  final RxDouble securityScore = 0.85.obs;
  final RxInt recommendedActionsCount = 3.obs;

  final RxBool isTwoFactorEnabled = true.obs;
  final RxBool isBiometricEnabled = true.obs;
  final RxBool alertsEnabled = true.obs;
  final RxBool shareLocation = true.obs;
  final RxBool showStatus = false.obs;
  final RxBool analyticsEnabled = true.obs;

  final RxString profileVisibility = 'Amis'.obs;

  final List<ConnectedDevice> connectedDevices = [
    const ConnectedDevice(
      name: 'iPhone 14 Pro',
      location: 'Paris, France • Maintenant',
      platform: 'iOS 17.1.2 • Safari',
      statusLabel: 'Actuel',
      statusColor: Color(0xFF16A34A),
      isCurrent: true,
      icon: Icons.phone_iphone_rounded,
      accentColor: Color(0xFF176BFF),
    ),
    const ConnectedDevice(
      name: 'MacBook Pro',
      location: 'Paris, France • Hier 21:14',
      platform: 'macOS 14 • Chrome',
      statusLabel: 'Desktop',
      statusColor: Color(0xFF2563EB),
      isCurrent: false,
      icon: Icons.laptop_mac_rounded,
      accentColor: Color(0xFF2563EB),
    ),
    const ConnectedDevice(
      name: 'iPad Air',
      location: 'Lyon, France • 12 oct.',
      platform: 'iPadOS 17 • Safari',
      statusLabel: 'Tablette',
      statusColor: Color(0xFFF97316),
      isCurrent: false,
      icon: Icons.tablet_mac_rounded,
      accentColor: Color(0xFFF97316),
    ),
  ];

  final List<SessionLog> recentSessions = const [
    SessionLog(
      device: 'Pixel 8',
      location: 'Bordeaux, France',
      timestamp: '8 oct. • 18:22',
      platform: 'Android 14 • Chrome',
      statusLabel: 'Déconnecté',
      statusColor: Color(0xFFEF4444),
    ),
    SessionLog(
      device: 'iPhone 12',
      location: 'Marseille, France',
      timestamp: '2 oct. • 09:05',
      platform: 'iOS 16 • App',
      statusLabel: 'Expiré',
      statusColor: Color(0xFF475569),
    ),
  ];

  List<SecurityRecommendation> get recommendations => [
        SecurityRecommendation(
          title: 'Changez votre mot de passe',
          description: 'Votre mot de passe n’a pas été mis à jour depuis 2 mois.',
          accentColor: const Color(0xFFF59E0B),
          actionLabel: 'Modifier maintenant',
          onTap: openChangePassword,
        ),
        SecurityRecommendation(
          title: 'Vérifiez votre email',
          description: 'Votre email de secours n’a pas encore été confirmé.',
          accentColor: const Color(0xFF0EA5E9),
          actionLabel: 'Vérifier l’email',
          onTap: () => Get.snackbar('Vérification', 'Email de secours envoyé.'),
        ),
        SecurityRecommendation(
          title: 'Sauvegardez vos codes 2FA',
          description: 'Téléchargez vos codes de récupération pour les situations d’urgence.',
          accentColor: const Color(0xFF16A34A),
          actionLabel: 'Télécharger',
          onTap: downloadRecoveryCodes,
        ),
      ];

  final List<String> securityTips = const [
    'Utilisez un mot de passe unique et complexe.',
    'Activez l’authentification à deux facteurs.',
    'Vérifiez régulièrement vos appareils connectés.',
    'Ne partagez jamais vos informations de connexion.',
  ];

  void openEditEmail() {
    Get.toNamed(Routes.profileSecurityEmail);
  }

  void openChangePassword() {
    Get.toNamed(
      Routes.profileSecurityPassword,
      arguments: {'email': email.value},
    );
  }

  void openEditPhone() {
    Get.toNamed(Routes.profileSecurityPhone);
  }

  void toggleTwoFactor(bool value) {
    isTwoFactorEnabled.value = value;
    Get.snackbar('Authentification 2FA', value ? '2FA activée.' : '2FA désactivée.');
  }

  void toggleBiometric(bool value) {
    isBiometricEnabled.value = value;
    Get.snackbar('Biométrie', value ? 'Connexion biométrique activée.' : 'Connexion biométrique désactivée.');
  }

  void toggleAlerts(bool value) {
    alertsEnabled.value = value;
    Get.snackbar('Alertes de connexion', value ? 'Vous recevrez désormais les alertes.' : 'Alertes de connexion désactivées.');
  }

  void toggleShareLocation(bool value) {
    shareLocation.value = value;
    Get.snackbar('Localisation', value ? 'Partage de localisation activé.' : 'Partage de localisation désactivé.');
  }

  void toggleShowStatus(bool value) {
    showStatus.value = value;
    Get.snackbar('Statut', value ? 'Vos contacts voient votre statut.' : 'Votre statut est masqué.');
  }

  void toggleAnalytics(bool value) {
    analyticsEnabled.value = value;
    Get.snackbar('Analyses', value ? 'Partage des données analytiques activé.' : 'Analyses désactivées.');
  }

  void manageSessions() {
    Get.snackbar('Sessions actives', 'Historique des connexions bientôt disponible.');
  }

  void openConnectionAlerts() {
    Get.snackbar('Alertes de connexion', 'Configuration prochaine.');
  }

  void openNotificationsHelp() {
    Get.snackbar('Support', 'Notre équipe de sécurité est à votre écoute.');
  }

  void openBlockedUsers() {
    Get.toNamed(Routes.profileBlockedUsers);
  }

  void openReportHistory() {
    Get.snackbar('Historique des signalements', 'Consultation disponible prochainement.');
  }

  void openLoginHistory() {
    Get.snackbar('Historique de connexion', 'Fonctionnalité en préparation.');
  }

  void downloadData() {
    Get.snackbar('Téléchargement', 'Votre export sera préparé.');
  }

  void downloadRecoveryCodes() {
    Get.snackbar('Codes de secours', 'Téléchargement des codes 2FA en cours.');
  }

  void chooseVisibility() {
    Get.snackbar('Visibilité du profil', 'Gestion des niveaux de visibilité à venir.');
  }

  void disconnectAllDevices() {
    Get.snackbar('Déconnexion', 'Tous les appareils ont été déconnectés.');
  }

  void freezeAccount() {
    Get.snackbar('Compte gelé', 'Votre compte sera temporairement suspendu.');
  }

  void deleteAccount() {
    Get.snackbar('Suppression du compte', 'Procédure de suppression en cours.');
  }
}

class ConnectedDevice {
  const ConnectedDevice({
    required this.name,
    required this.location,
    required this.platform,
    required this.statusLabel,
    required this.statusColor,
    required this.isCurrent,
    required this.icon,
    required this.accentColor,
  });

  final String name;
  final String location;
  final String platform;
  final String statusLabel;
  final Color statusColor;
  final bool isCurrent;
  final IconData icon;
  final Color accentColor;
}

class SessionLog {
  const SessionLog({
    required this.device,
    required this.location,
    required this.timestamp,
    required this.platform,
    required this.statusLabel,
    required this.statusColor,
  });

  final String device;
  final String location;
  final String timestamp;
  final String platform;
  final String statusLabel;
  final Color statusColor;
}

class SecurityRecommendation {
  const SecurityRecommendation({
    required this.title,
    required this.description,
    required this.accentColor,
    required this.actionLabel,
    required this.onTap,
  });

  final String title;
  final String description;
  final Color accentColor;
  final String actionLabel;
  final VoidCallback onTap;
}

