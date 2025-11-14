import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import 'report_confirmation_controller.dart';

class ReportProblemController extends GetxController {
  ReportProblemController() {
    _descriptionLength.value = detailsController.text.length;
  }

  final TextEditingController detailsController = TextEditingController();

  final RxString selectedCategoryId = ''.obs;
  final RxString selectedLocationId = ''.obs;
  final RxString selectedTimeframeId = ''.obs;
  final RxString selectedUrgencyId = ''.obs;

  final RxBool blockUser = false.obs;
  final RxBool receiveUpdates = true.obs;

  final RxList<ReportAttachment> attachments = <ReportAttachment>[].obs;
  final RxBool isUploading = false.obs;
  final RxDouble uploadProgress = 0.0.obs;
  final RxBool isSubmitting = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool attemptedSubmit = false.obs;

  final RxInt _descriptionLength = 0.obs;

  int get descriptionLength => _descriptionLength.value;
  int get descriptionMax => 500;

  final List<ReportIssueCategory> categories = const [
    ReportIssueCategory(
      id: 'harassment',
      title: 'Harcèlement ou intimidation',
      description: 'Comportement abusif, menaces ou intimidation.',
      icon: Icons.gavel_rounded,
    ),
    ReportIssueCategory(
      id: 'inappropriate_content',
      title: 'Contenu inapproprié',
      description: 'Images, messages ou comportements déplacés.',
      icon: Icons.no_adult_content_rounded,
    ),
    ReportIssueCategory(
      id: 'spam',
      title: 'Spam ou contenu indésirable',
      description: 'Messages répétitifs, publicités non sollicitées.',
      icon: Icons.mark_email_unread_rounded,
    ),
    ReportIssueCategory(
      id: 'fake_profile',
      title: 'Faux profil',
      description: 'Profil suspect, usurpation d’identité.',
      icon: Icons.verified_user_outlined,
    ),
    ReportIssueCategory(
      id: 'fraud',
      title: 'Arnaque ou fraude',
      description: 'Tentative d’escroquerie ou demande d’argent.',
      icon: Icons.gpp_maybe_rounded,
    ),
    ReportIssueCategory(
      id: 'violence',
      title: 'Violence ou menaces',
      description: 'Violence verbale ou physique, menaces.',
      icon: Icons.warning_amber_rounded,
    ),
    ReportIssueCategory(
      id: 'technical',
      title: 'Problème technique',
      description: 'Erreur de paiement, bug ou dysfonctionnement.',
      icon: Icons.bug_report_outlined,
    ),
    ReportIssueCategory(
      id: 'other',
      title: 'Autre',
      description: 'Un autre problème non listé ici.',
      icon: Icons.help_outline_rounded,
    ),
  ];

  final List<ReportFormOption> locationOptions = const [
    ReportFormOption(id: 'chat', label: 'Dans la messagerie'),
    ReportFormOption(id: 'match', label: 'Pendant un match'),
    ReportFormOption(id: 'feed', label: 'Dans le fil d’actualité'),
    ReportFormOption(id: 'venue', label: 'Sur un terrain'),
    ReportFormOption(id: 'group', label: 'Dans un groupe'),
    ReportFormOption(id: 'other', label: 'Autre situation'),
  ];

  final List<ReportFormOption> timeframeOptions = const [
    ReportFormOption(id: 'today', label: 'Aujourd’hui'),
    ReportFormOption(id: 'last24h', label: 'Dernières 24h'),
    ReportFormOption(id: 'week', label: 'Cette semaine'),
    ReportFormOption(id: 'month', label: 'Ce mois-ci'),
    ReportFormOption(id: 'unknown', label: 'Je ne sais pas'),
  ];

  final List<UrgencyLevel> urgencyLevels = const [
    UrgencyLevel(
      id: 'low',
      title: 'Faible',
      description: 'Gêne mineure',
      color: Color(0xFF16A34A),
    ),
    UrgencyLevel(
      id: 'medium',
      title: 'Moyen',
      description: 'Problème sérieux',
      color: Color(0xFFF59E0B),
    ),
    UrgencyLevel(
      id: 'high',
      title: 'Urgent',
      description: 'Danger immédiat',
      color: Color(0xFFEF4444),
    ),
  ];

  final List<ReportHistoryItem> previousReports = const [
    ReportHistoryItem(
      title: 'Spam dans un groupe',
      subtitle: 'Il y a 5 jours • Groupe Tennis Parc',
      status: ReportHistoryStatus.resolved,
    ),
    ReportHistoryItem(
      title: 'Comportement inapproprié',
      subtitle: 'Il y a 2 semaines • Match de football',
      status: ReportHistoryStatus.inProgress,
    ),
  ];

  final List<ReportContextTag> contextTags = const [
    ReportContextTag(icon: Icons.person_outline_rounded, label: 'Profil concerné : @marc.dubois.tennis'),
    ReportContextTag(icon: Icons.sports_soccer_rounded, label: 'Évènement : Match amical - 29 oct. 20h'),
    ReportContextTag(icon: Icons.location_on_outlined, label: 'Lieu : Stade Municipal de Courbevoie'),
    ReportContextTag(icon: Icons.confirmation_number_outlined, label: 'Réservation : #SP-2024-11-29-003'),
  ];

  final List<EmergencyResource> emergencyResources = const [
    EmergencyResource(
      title: 'Urgence',
      subtitle: '15 / 17 / 18',
      color: Color(0xFFEF4444),
      background: Color(0x19EF4444),
      icon: Icons.local_police_rounded,
    ),
    EmergencyResource(
      title: 'Chat support',
      subtitle: '24h/24',
      color: Color(0xFF0EA5E9),
      background: Color(0x190EA5E9),
      icon: Icons.support_agent_rounded,
    ),
  ];

  Timer? _progressTimer;

  bool get descriptionValid => detailsController.text.trim().length >= 20;
  bool get categoryValid => selectedCategoryId.value.isNotEmpty;
  bool get locationValid => selectedLocationId.value.isNotEmpty;
  bool get timeframeValid => selectedTimeframeId.value.isNotEmpty;
  bool get urgencyValid => selectedUrgencyId.value.isNotEmpty;

  bool get canSubmit =>
      categoryValid &&
      locationValid &&
      timeframeValid &&
      urgencyValid &&
      descriptionValid &&
      !isUploading.value &&
      !isSubmitting.value;

  void selectCategory(String id) {
    if (selectedCategoryId.value == id) return;
    selectedCategoryId.value = id;
    attemptedSubmit.value = false;
    errorMessage.value = '';
  }

  void selectLocation(String id) {
    selectedLocationId.value = id;
    attemptedSubmit.value = false;
    errorMessage.value = '';
  }

  void selectTimeframe(String id) {
    selectedTimeframeId.value = id;
    attemptedSubmit.value = false;
    errorMessage.value = '';
  }

  void selectUrgency(String id) {
    selectedUrgencyId.value = id;
    attemptedSubmit.value = false;
    errorMessage.value = '';
  }

  Future<void> pickAttachment() async {
    if (isUploading.value) return;

    isUploading.value = true;
    uploadProgress.value = 0;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final attachment = ReportAttachment(
      id: id,
      name: 'capture_$id.png',
      sizeLabel: '1.2 MB',
      status: AttachmentStatus.uploading,
    );
    attachments.add(attachment);

    _progressTimer = Timer.periodic(const Duration(milliseconds: 220), (timer) {
      if (uploadProgress.value >= 1) {
        timer.cancel();
        _finishUpload(id);
      } else {
        uploadProgress.value = (uploadProgress.value + 0.15).clamp(0, 1);
      }
    });
  }

  void _finishUpload(String id) {
    isUploading.value = false;
    uploadProgress.value = 1;
    final index = attachments.indexWhere((element) => element.id == id);
    if (index != -1) {
      attachments[index] = attachments[index].copyWith(status: AttachmentStatus.completed);
    }
  }

  void removeAttachment(ReportAttachment attachment) {
    attachments.removeWhere((item) => item.id == attachment.id);
  }

  void toggleBlockUser(bool value) {
    blockUser.value = value;
  }

  void toggleReceiveUpdates(bool value) {
    receiveUpdates.value = value;
  }

  void onDetailsChanged(String value) {
    _descriptionLength.value = value.length;
    attemptedSubmit.value = false;
    if (errorMessage.value.isNotEmpty) {
      errorMessage.value = '';
    }
  }

  void saveDraft() {
    Get.snackbar('Brouillon enregistré', 'Retrouvez-le plus tard dans vos signalements.');
  }

  Future<void> submit() async {
    attemptedSubmit.value = true;
    if (!canSubmit) {
      errorMessage.value = 'Veuillez compléter les champs obligatoires.';
      return;
    }

    errorMessage.value = '';
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSubmitting.value = false;
    attemptedSubmit.value = false;

    final now = DateTime.now();
    final reference =
        '#SIG-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch.toString().substring(7)}';

    Get.toNamed(
      Routes.reportConfirmation,
      arguments: ReportConfirmationArgs(
        title: 'Signalement envoyé',
        message: 'Merci, notre équipe examinera votre signalement rapidement.',
        reference: reference,
        emailNotice: receiveUpdates.value
            ? 'Vous recevrez des mises à jour par email.'
            : 'Vous pourrez suivre l’avancement dans l’application.',
        steps: const [
          ConfirmationStep(
            icon: Icons.inbox_outlined,
            title: 'Signalement reçu',
            subtitle: 'Immédiatement',
            color: Color(0xFF176BFF),
          ),
          ConfirmationStep(
            icon: Icons.search_rounded,
            title: 'Analyse par l’équipe support',
            subtitle: 'Sous 24h',
            color: Color(0xFFF59E0B),
          ),
          ConfirmationStep(
            icon: Icons.update_rounded,
            title: 'Retour vers vous',
            subtitle: 'Sous 48h ouvrées',
            color: Color(0xFF16A34A),
          ),
        ],
        actions: const [
          ConfirmationAction(
            icon: Icons.rule_folder_rounded,
            title: 'Consulter les règles',
            subtitle: 'Prenez connaissance des bonnes pratiques Sportify',
            route: Routes.reportProblem,
          ),
          ConfirmationAction(
            icon: Icons.chat_bubble_outline_rounded,
            title: 'Ouvrir le support',
            subtitle: 'Discutez avec un conseiller Sportify',
          ),
        ],
        enableCountdown: false,
        countdownSeconds: 6,
        redirectRoute: Routes.profileBookings,
      ),
    );

    clearForm();
  }

  void clearForm() {
    selectedCategoryId.value = '';
    selectedLocationId.value = '';
    selectedTimeframeId.value = '';
    selectedUrgencyId.value = '';
    detailsController.clear();
    _descriptionLength.value = 0;
    attachments.clear();
    blockUser.value = false;
    receiveUpdates.value = true;
    errorMessage.value = '';
    attemptedSubmit.value = false;
  }

  bool get showCategoryError => attemptedSubmit.value && !categoryValid;
  bool get showLocationError => attemptedSubmit.value && !locationValid;
  bool get showTimeframeError => attemptedSubmit.value && !timeframeValid;
  bool get showUrgencyError => attemptedSubmit.value && !urgencyValid;
  bool get showDescriptionError => attemptedSubmit.value && !descriptionValid;

  @override
  void onClose() {
    detailsController.dispose();
    _progressTimer?.cancel();
    super.onClose();
  }
}

class ReportIssueCategory {
  const ReportIssueCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
}

class ReportFormOption {
  const ReportFormOption({required this.id, required this.label});

  final String id;
  final String label;
}

class UrgencyLevel {
  const UrgencyLevel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  final String id;
  final String title;
  final String description;
  final Color color;
}

class ReportHistoryItem {
  const ReportHistoryItem({
    required this.title,
    required this.subtitle,
    required this.status,
  });

  final String title;
  final String subtitle;
  final ReportHistoryStatus status;
}

enum ReportHistoryStatus { resolved, inProgress }

class EmergencyResource {
  const EmergencyResource({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.background,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final Color color;
  final Color background;
  final IconData icon;
}

class ReportAttachment {
  const ReportAttachment({
    required this.id,
    required this.name,
    required this.sizeLabel,
    required this.status,
  });

  final String id;
  final String name;
  final String sizeLabel;
  final AttachmentStatus status;

  ReportAttachment copyWith({AttachmentStatus? status}) {
    return ReportAttachment(
      id: id,
      name: name,
      sizeLabel: sizeLabel,
      status: status ?? this.status,
    );
  }
}

enum AttachmentStatus { uploading, completed, failed }

class ReportContextTag {
  const ReportContextTag({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

