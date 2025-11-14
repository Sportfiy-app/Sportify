import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../support/controllers/report_confirmation_controller.dart';

class CancelReservationController extends GetxController {
  final TextEditingController detailsController = TextEditingController();
  final RxString selectedMotif = ''.obs;
  final RxList<CancelAttachment> attachments = <CancelAttachment>[].obs;

  final RxBool isUploading = false.obs;
  final RxDouble uploadProgress = 0.0.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool requireConfirmation = true.obs;

  final RxString errorMessage = ''.obs;

  final List<String> motifs = const [
    'Empêchement personnel',
    'Prestataire indisponible',
    'Réservation en doublon',
    'Problème technique',
    'Autre',
  ];

  Timer? _progressTimer;

  bool get canSubmit =>
      selectedMotif.value.isNotEmpty &&
      detailsController.text.trim().isNotEmpty &&
      !isUploading.value &&
      !isSubmitting.value;

  void selectMotif(String? value) {
    if (value == null) return;
    selectedMotif.value = value;
    errorMessage.value = '';
  }

  void onDetailsChanged(String value) {
    errorMessage.value = '';
  }

  Future<void> pickAttachment() async {
    if (isUploading.value) return;
    isUploading.value = true;
    uploadProgress.value = 0.0;
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    attachments.add(
      CancelAttachment(
        id: id,
        name: 'justificatif_$id.pdf',
        sizeLabel: '860 KB',
        status: AttachmentStatus.uploading,
      ),
    );

    _progressTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
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
    final index = attachments.indexWhere((attachment) => attachment.id == id);
    if (index != -1) {
      attachments[index] = attachments[index].copyWith(status: AttachmentStatus.completed);
    }
  }

  void removeAttachment(CancelAttachment attachment) {
    attachments.removeWhere((item) => item.id == attachment.id);
  }

  Future<void> submit() async {
    if (!canSubmit) {
      errorMessage.value = 'Veuillez compléter les champs obligatoires.';
      return;
    }

    final shouldProceed = requireConfirmation.value
        ? await Get.dialog<bool>(
              AlertDialog(
                title: const Text('Confirmer l’annulation'),
                content: const Text('Êtes-vous sûr de vouloir annuler cette réservation ?'),
                actions: [
                  TextButton(onPressed: () => Get.back(result: false), child: const Text('Non')),
                  FilledButton(onPressed: () => Get.back(result: true), child: const Text('Oui, annuler')),
                ],
              ),
            ) ??
            false
        : true;

    if (!shouldProceed) return;

    isSubmitting.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    isSubmitting.value = false;
    final now = DateTime.now();
    final reference = '#AN-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch.toString().substring(8)}';

    Get.toNamed(
      Routes.reportConfirmation,
      arguments: ReportConfirmationArgs(
        title: 'Annulation envoyée',
        message: 'Votre annulation a bien été prise en compte.',
        reference: reference,
        emailNotice: 'Un email de confirmation vous a été envoyé.',
        steps: const [
          ConfirmationStep(
            icon: Icons.check_circle_rounded,
            title: 'Annulation enregistrée',
            subtitle: 'Immédiatement',
            color: Color(0xFF16A34A),
          ),
          ConfirmationStep(
            icon: Icons.schedule_rounded,
            title: 'Notification au prestataire',
            subtitle: 'Sous 24h',
            color: Color(0xFFF59E0B),
          ),
          ConfirmationStep(
            icon: Icons.attach_money_rounded,
            title: 'Remboursement (si applicable)',
            subtitle: 'Sous 3-5 jours ouvrés',
            color: Color(0xFF0EA5E9),
          ),
        ],
        actions: const [
          ConfirmationAction(
            icon: Icons.history_rounded,
            title: 'Voir mes réservations',
            subtitle: 'Consultez vos réservations à venir et passées',
            route: Routes.profileBookings,
          ),
          ConfirmationAction(
            icon: Icons.support_agent_rounded,
            title: 'Contacter le support',
            subtitle: 'Notre équipe est disponible pour vous aider',
            route: Routes.reportProblem,
          ),
        ],
        countdownSeconds: 5,
        enableCountdown: true,
        redirectRoute: Routes.profileBookings,
      ),
    );
    _reset();
  }

  void _reset() {
    selectedMotif.value = '';
    detailsController.clear();
    attachments.clear();
    uploadProgress.value = 0;
    errorMessage.value = '';
  }

  @override
  void onClose() {
    detailsController.dispose();
    _progressTimer?.cancel();
    super.onClose();
  }
}

class CancelAttachment {
  const CancelAttachment({
    required this.id,
    required this.name,
    required this.sizeLabel,
    required this.status,
  });

  final String id;
  final String name;
  final String sizeLabel;
  final AttachmentStatus status;

  CancelAttachment copyWith({AttachmentStatus? status}) {
    return CancelAttachment(
      id: id,
      name: name,
      sizeLabel: sizeLabel,
      status: status ?? this.status,
    );
  }
}

enum AttachmentStatus { uploading, completed, failed }

