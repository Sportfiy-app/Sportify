import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDeleteAccountController extends GetxController {
  ProfileDeleteAccountController() {
    confirmController.addListener(_evaluateSubmitState);
    passwordController.addListener(_evaluateSubmitState);
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final RxString selectedReason = ''.obs;
  final List<String> reasons = const [
    'Je n’utilise plus l’application',
    'Préoccupations de confidentialité',
    'Manque de fonctionnalités',
    'J’utilise une autre application',
    'Autre raison',
  ];

  final RxList<bool> acknowledgements = <bool>[false, false, false].obs;
  final List<String> acknowledgementTexts = const [
    'Je comprends que cette action est irréversible et que toutes mes données seront définitivement supprimées après 30 jours.',
    'J’ai téléchargé mes données importantes ou je renonce à les récupérer.',
    'Je confirme n’avoir aucune réservation en cours ou litige à résoudre.',
  ];

  final RxBool isDeletionInProgress = false.obs;
  final RxBool canSubmit = false.obs;

   final DeleteAccountSummary summary = const DeleteAccountSummary(
    name: 'Marie Dubois',
    memberSince: 'Membre depuis mars 2023',
    levelLabel: 'Niveau Avancé',
    matchesLabel: '128 matchs',
    avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
  );

  final List<DeleteAccountStat> stats = const [
    DeleteAccountStat(value: '47', label: 'Réservations'),
    DeleteAccountStat(value: '23', label: 'Amis sportifs'),
    DeleteAccountStat(value: '8', label: 'Sports pratiqués'),
    DeleteAccountStat(value: '€287', label: 'Dépenses totales'),
  ];

  final List<DeleteAccountActivity> recentActivities = const [
    DeleteAccountActivity(title: 'Match de tennis', timeAgo: 'Il y a 2 jours'),
    DeleteAccountActivity(title: 'Nouveau partenaire ajouté', timeAgo: 'Il y a 5 jours'),
  ];

  final List<DeleteImpactItem> impactItems = const [
    DeleteImpactItem(
      title: 'Profil personnel',
      description: 'Photo, informations personnelles, préférences sportives',
    ),
    DeleteImpactItem(
      title: 'Historique des réservations',
      description: 'Toutes vos réservations passées et futures',
    ),
    DeleteImpactItem(
      title: 'Messages et conversations',
      description: 'Tous vos échanges avec d’autres sportifs',
    ),
    DeleteImpactItem(
      title: 'Statistiques et badges',
      description: 'Votre progression, niveaux et récompenses',
    ),
    DeleteImpactItem(
      title: 'Informations de paiement',
      description: 'Cartes enregistrées et historique des transactions',
    ),
  ];

  final List<DeleteAlternative> alternatives = const [
    DeleteAlternative(
      title: 'Désactiver temporairement',
      description: 'Masquez votre profil sans perdre vos données.',
      actionLabel: 'En savoir plus',
      colors: [Color(0xFFEFF6FF), Color(0xFFBFDBFE)],
    ),
    DeleteAlternative(
      title: 'Télécharger vos données',
      description: 'Exportez votre historique avant suppression.',
      actionLabel: 'Télécharger',
      colors: [Color(0xFFF0FDF4), Color(0xFFBBF7D0)],
    ),
    DeleteAlternative(
      title: 'Modifier les paramètres',
      description: 'Ajustez votre confidentialité et notifications.',
      actionLabel: 'Paramètres',
      colors: [Color(0xFFFEFCE8), Color(0xFFFEF08A)],
    ),
  ];

  final List<SupportOption> supportOptions = const [
    SupportOption(icon: Icons.chat_bubble_outline_rounded, label: 'Chat en direct', highlight: true),
    SupportOption(icon: Icons.email_outlined, label: 'Email', highlight: false),
  ];

  void selectReason(String reason) => selectedReason.value = reason;

  void toggleAcknowledgement(int index, bool value) {
    acknowledgements[index] = value;
    _evaluateSubmitState();
  }

  void _evaluateSubmitState() {
    final hasConfirmedText = confirmController.text.trim() == 'SUPPRIMER';
    final allAcknowledged = acknowledgements.every((ack) => ack);
    final hasPassword = passwordController.text.trim().isNotEmpty;
    canSubmit.value = hasConfirmedText && allAcknowledged && hasPassword;
  }

  void submitDeletion() {
    if (!canSubmit.value || isDeletionInProgress.value) {
      return;
    }
    isDeletionInProgress.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isDeletionInProgress.value = false;
      Get.snackbar(
        'Suppression programmée',
        'Votre compte sera définitivement supprimé après 30 jours.',
      );
      Get.back();
    });
  }

  void cancelDeletion() {
    Get.back();
  }

  @override
  void onClose() {
    passwordController
      ..removeListener(_evaluateSubmitState)
      ..dispose();
    commentsController.dispose();
    confirmController
      ..removeListener(_evaluateSubmitState)
      ..dispose();
    super.onClose();
  }
}

class DeleteAccountSummary {
  const DeleteAccountSummary({
    required this.name,
    required this.memberSince,
    required this.levelLabel,
    required this.matchesLabel,
    required this.avatarUrl,
  });

  final String name;
  final String memberSince;
  final String levelLabel;
  final String matchesLabel;
  final String avatarUrl;
}

class DeleteAccountStat {
  const DeleteAccountStat({required this.value, required this.label});

  final String value;
  final String label;
}

class DeleteAccountActivity {
  const DeleteAccountActivity({required this.title, required this.timeAgo});

  final String title;
  final String timeAgo;
}

class DeleteImpactItem {
  const DeleteImpactItem({required this.title, required this.description});

  final String title;
  final String description;
}

class DeleteAlternative {
  const DeleteAlternative({
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.colors,
  });

  final String title;
  final String description;
  final String actionLabel;
  final List<Color> colors;
}

class SupportOption {
  const SupportOption({required this.icon, required this.label, required this.highlight});

  final IconData icon;
  final String label;
  final bool highlight;
}

