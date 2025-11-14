import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileEditController extends GetxController {
  ProfileEditController() {
    essentials = [
      ProfileEditSection(
        id: 'profile_info',
        title: 'Informations profil',
        subtitle: 'Nom, prénom, email, téléphone',
        icon: Icons.badge_outlined,
        iconTint: const Color(0xFF176BFF),
        iconBackground: const Color(0x19176BFF),
        route: Routes.profileInfo,
      ),
      ProfileEditSection(
        id: 'profile_photos',
        title: 'Photos de profil',
        subtitle: 'Gérer vos photos et avatar',
        icon: Icons.photo_camera_front_outlined,
        iconTint: const Color(0xFFFFB800),
        iconBackground: const Color(0x19FFB800),
        statuses: const [
          ProfileEditStatus(label: '3 photos', background: Color(0x33FFB800), textColor: Color(0xFFFFB800)),
        ],
      ),
      ProfileEditSection(
        id: 'profile_payments',
        title: 'Moyens de paiement',
        subtitle: 'Carte bancaire, Apple Pay, Google Pay',
        icon: Icons.credit_card,
        iconTint: const Color(0xFF0EA5E9),
        iconBackground: const Color(0x190EA5E9),
        statuses: const [
          ProfileEditStatus(label: 'Visa •••• 4256', background: Color(0x33C084FC), textColor: Color(0xFF6366F1)),
        ],
        route: Routes.profilePaymentCard,
      ),
      ProfileEditSection(
        id: 'profile_security',
        title: 'Sécurité',
        subtitle: 'Email, mot de passe, téléphone',
        icon: Icons.shield_outlined,
        iconTint: const Color(0xFF16A34A),
        iconBackground: const Color(0x1916A34A),
        route: Routes.profileSecurity,
      ),
      ProfileEditSection(
        id: 'profile_sports',
        title: 'Mes sports',
        subtitle: 'Tennis, Football, Basketball',
        icon: Icons.sports_tennis_outlined,
        iconTint: const Color(0xFF16A34A),
        iconBackground: const Color(0x1916A34A),
        statuses: const [
          ProfileEditStatus(label: 'Football', background: Color(0xFF176BFF), textColor: Colors.white),
          ProfileEditStatus(label: 'Tennis', background: Color(0xFF16A34A), textColor: Colors.white),
          ProfileEditStatus(label: '+2', background: Color(0xFFF59E0B), textColor: Colors.white),
        ],
        route: Routes.profileSports,
      ),
      ProfileEditSection(
        id: 'profile_blocked',
        title: 'Utilisateurs bloqués',
        subtitle: 'Gérer la liste des utilisateurs bloqués',
        icon: Icons.block_outlined,
        iconTint: const Color(0xFFEF4444),
        iconBackground: const Color(0x19EF4444),
        statuses: const [
          ProfileEditStatus(label: '2', background: Color(0x33EF4444), textColor: Color(0xFFEF4444)),
        ],
        route: Routes.profileBlockedUsers,
      ),
    ];

    personalization = [
      ProfileEditSection(
        id: 'profile_bio',
        title: 'Biographie',
        subtitle: 'À propos de moi, description personnelle',
        icon: Icons.edit_note_rounded,
        iconTint: const Color(0xFF0EA5E9),
        iconBackground: const Color(0x190EA5E9),
      ),
      ProfileEditSection(
        id: 'profile_badges',
        title: 'Badges & Récompenses',
        subtitle: 'Trophées, certifications, statuts',
        icon: Icons.emoji_events_outlined,
        iconTint: const Color(0xFFFFB800),
        iconBackground: const Color(0x19FFB800),
        statuses: const [
          ProfileEditStatus(label: 'Trophée 2024', background: Color(0xFFFFB800), textColor: Colors.white),
          ProfileEditStatus(label: 'Sportif certifié', background: Color(0xFF176BFF), textColor: Colors.white),
          ProfileEditStatus(label: '+5', background: Color(0xFF16A34A), textColor: Colors.white),
        ],
      ),
      ProfileEditSection(
        id: 'profile_notifications',
        title: 'Notifications',
        subtitle: 'Push, email, SMS, rappels de match',
        icon: Icons.notifications_active_outlined,
        iconTint: const Color(0xFF16A34A),
        iconBackground: const Color(0x1916A34A),
        hasToggle: true,
      ),
    ];

    account = [
      ProfileEditSection(
        id: 'profile_confidentiality',
        title: 'Confidentialité',
        subtitle: 'Paramètres de confidentialité et sécurité',
        icon: Icons.shield_outlined,
        iconTint: const Color(0xFF475569),
        iconBackground: const Color(0x19475569),
      ),
      ProfileEditSection(
        id: 'profile_password',
        title: 'Changer le mot de passe',
        subtitle: 'Sécurité du compte et authentification',
        icon: Icons.lock_reset_rounded,
        iconTint: const Color(0xFFF59E0B),
        iconBackground: const Color(0x19F59E0B),
      ),
      ProfileEditSection(
        id: 'profile_export',
        title: 'Exporter mes données',
        subtitle: 'Télécharger l’historique et statistiques',
        icon: Icons.file_download_outlined,
        iconTint: const Color(0xFF0EA5E9),
        iconBackground: const Color(0x190EA5E9),
      ),
    ];

    danger = [
      ProfileEditSection(
        id: 'profile_pause',
        title: 'Désactiver le compte',
        subtitle: 'Suspension temporaire du profil',
        icon: Icons.pause_circle_outline_rounded,
        iconTint: const Color(0xFFEF4444),
        iconBackground: const Color(0x19EF4444),
        isDanger: true,
      ),
      ProfileEditSection(
        id: 'profile_delete',
        title: 'Supprimer mon compte',
        subtitle: 'Suppression définitive - RGPD',
        icon: Icons.delete_sweep_outlined,
        iconTint: const Color(0xFFEF4444),
        iconBackground: const Color(0x19EF4444),
        isDanger: true,
      ),
    ];
  }

  final ProfileEditSummary summary = const ProfileEditSummary(
    name: 'Alexandre Martin',
    username: '@alex_tennis_pro',
    levelLabel: 'Gold',
    levelAccent: Color(0xFFFFB800),
    rating: 4.8,
    matches: 127,
    streakHours: 4,
    weeklyWins: 8,
  );

  late final List<ProfileEditSection> essentials;
  late final List<ProfileEditSection> personalization;
  late final List<ProfileEditSection> account;
  late final List<ProfileEditSection> danger;

  final RxSet<String> updatedSections = <String>{}.obs;
  final RxBool notificationsEnabled = true.obs;
  final RxString biography = 'Sportif passionné, toujours partant pour un match et pour rencontrer de nouveaux partenaires !'.obs;
  final RxBool hasPremium = true.obs;
  final RxString premiumLabel = 'Membre Gold'.obs;
  final Rx<DateTime> premiumExpires = DateTime(2024, 12, 15).obs;

  void openSection(ProfileEditSection section) {
    if (section.hasToggle) return;
    if (section.route != null) {
      Get.toNamed(section.route!)?.then((value) {
        if (value != null) {
          markSectionUpdated(section.id);
        }
      });
      return;
    }

    switch (section.id) {
      case 'profile_bio':
        _openBiographyEditor();
        break;
      case 'profile_pause':
        _confirmPauseAccount();
        break;
      case 'profile_delete':
        _confirmDeleteAccount();
        break;
      case 'profile_export':
        _startExport();
        break;
      default:
        Get.snackbar(section.title, 'Fonctionnalité en cours de conception.');
    }
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
    markSectionUpdated('profile_notifications');
    Get.snackbar(
      'Notifications',
      value ? 'Vous recevrez à nouveau les alertes prioritaires.' : 'Les alertes push sont désactivées pour le moment.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void markSectionUpdated(String id) {
    updatedSections.add(id);
  }

  void resetChanges() {
    updatedSections.clear();
    notificationsEnabled.value = true;
  }

  void saveChanges() {
    Get.back();
    Get.snackbar('Profil mis à jour', 'Vos préférences ont été enregistrées avec succès.');
  }

  void openPremiumManagement() {
    Get.snackbar('Abonnement Premium', 'Gestion de votre offre Premium à venir.');
  }

  void _openBiographyEditor() {
    final controller = TextEditingController(text: biography.value);
    Get.dialog(
      AlertDialog(
        title: const Text('Modifier la biographie'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Décrivez votre style de jeu, vos objectifs, vos sports favoris...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () {
              biography.value = controller.text.trim();
              markSectionUpdated('profile_bio');
              Get.back();
              Get.snackbar('Biographie mise à jour', 'Votre biographie reflète vos nouvelles informations.');
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _confirmPauseAccount() {
    Get.dialog(
      AlertDialog(
        title: const Text('Mettre le compte en pause ?'),
        content: const Text(
          'Votre profil sera masqué temporairement. Vous pourrez le réactiver à tout moment depuis vos paramètres.',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Annuler')),
          FilledButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Compte en pause', 'Votre compte sera désactivé dans quelques minutes.');
            },
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFF59E0B)),
            child: const Text('Mettre en pause'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    Get.dialog(
      AlertDialog(
        title: const Text('Supprimer définitivement ?'),
        content: const Text(
          'Cette action est irréversible. Vos données seront supprimées sous 30 jours conformément au RGPD.',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Annuler')),
          FilledButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Demande enregistrée', 'Nous vous guiderons par email pour finaliser la suppression.');
            },
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _startExport() {
    markSectionUpdated('profile_export');
    Get.snackbar('Export en préparation', 'Vous recevrez un email avec vos données dans les prochaines heures.');
  }
}

class ProfileEditSummary {
  const ProfileEditSummary({
    required this.name,
    required this.username,
    required this.levelLabel,
    required this.levelAccent,
    required this.rating,
    required this.matches,
    required this.streakHours,
    required this.weeklyWins,
  });

  final String name;
  final String username;
  final String levelLabel;
  final Color levelAccent;
  final double rating;
  final int matches;
  final int streakHours;
  final int weeklyWins;
}

class ProfileEditSection {
  const ProfileEditSection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconTint,
    required this.iconBackground,
    this.route,
    this.statuses = const [],
    this.hasToggle = false,
    this.isDanger = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconTint;
  final Color iconBackground;
  final String? route;
  final List<ProfileEditStatus> statuses;
  final bool hasToggle;
  final bool isDanger;
}

class ProfileEditStatus {
  const ProfileEditStatus({
    required this.label,
    required this.background,
    required this.textColor,
    this.icon,
  });

  final String label;
  final Color background;
  final Color textColor;
  final IconData? icon;
}

