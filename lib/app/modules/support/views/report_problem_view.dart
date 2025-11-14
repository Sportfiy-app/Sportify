import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/report_problem_controller.dart';

class ReportProblemView extends GetView<ReportProblemController> {
  const ReportProblemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.88, 1.08);

          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(scale: scale),
                  SizedBox(height: 18 * scale),
                  _ProgressHeader(scale: scale),
                  SizedBox(height: 20 * scale),
                  _IntroSection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _IssueSelectionSection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _ContextSection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _AttachmentSection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _DetailsSection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _UrgencySection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _UserSection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _HistorySection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _EmergencySection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _PrivacySection(scale: scale),
                  SizedBox(height: 24 * scale),
                  _FooterSection(scale: scale),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(scale: scale, icon: Icons.arrow_back_ios_new_rounded, onTap: Get.back),
        Expanded(
          child: Center(
            child: Text(
              'Signaler un problème',
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        _CircleButton(
          scale: scale,
          icon: Icons.close_rounded,
          onTap: Get.back,
        ),
      ],
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Étape 1 sur 3', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
              const Spacer(),
              Text('33%', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 10 * scale),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 8 * scale,
              child: LinearProgressIndicator(
                value: 0.33,
                backgroundColor: const Color(0xFFE2E8F0),
                color: const Color(0xFF176BFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroSection extends StatelessWidget {
  const _IntroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quel est le problème ?', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 10 * scale),
        Text(
          'Sélectionnez la raison qui correspond le mieux à votre signalement.',
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.5),
        ),
      ],
    );
  }
}

class _IssueSelectionSection extends GetView<ReportProblemController> {
  const _IssueSelectionSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ...controller.categories.map(
            (category) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: _SelectionCard(
                scale: scale,
                title: category.title,
                description: category.description,
                icon: category.icon,
                selected: controller.selectedCategoryId.value == category.id,
                onTap: () => controller.selectCategory(category.id),
              ),
            ),
          ),
          if (controller.showCategoryError)
            Padding(
              padding: EdgeInsets.only(top: 6 * scale),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Veuillez choisir un motif.',
                  style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12 * scale),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ContextSection extends GetView<ReportProblemController> {
  const _ContextSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contexte du signalement', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 6 * scale),
        Text(
          'Ces informations nous aident à mieux comprendre la situation.',
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.45),
        ),
        SizedBox(height: 18 * scale),
        _DropdownField(
          scale: scale,
          label: 'Où s’est produit le problème ?',
          hint: 'Sélectionnez un endroit',
          items: controller.locationOptions,
          selectedId: controller.selectedLocationId,
          showError: controller.showLocationError,
          onChanged: controller.selectLocation,
        ),
        SizedBox(height: 16 * scale),
        _DropdownField(
          scale: scale,
          label: 'Quand cela s’est-il produit ?',
          hint: 'Sélectionnez une période',
          items: controller.timeframeOptions,
          selectedId: controller.selectedTimeframeId,
          showError: controller.showTimeframeError,
          onChanged: controller.selectTimeframe,
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.scale,
    required this.label,
    required this.hint,
    required this.items,
    required this.selectedId,
    required this.showError,
    required this.onChanged,
  });

  final double scale;
  final String label;
  final String hint;
  final List<ReportFormOption> items;
  final RxString selectedId;
  final bool showError;
  final void Function(String id) onChanged;

  @override
  Widget build(BuildContext context) {
    final borderColor = showError ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
        SizedBox(height: 10 * scale),
        Obx(
          () => DropdownButtonFormField<String>(
            value: selectedId.value.isEmpty ? null : selectedId.value,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14 * scale),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: BorderSide(color: borderColor, width: 1.4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14 * scale),
                borderSide: BorderSide(color: showError ? const Color(0xFFEF4444) : const Color(0xFF176BFF), width: 1.6),
              ),
            ),
            icon: Icon(Icons.expand_more_rounded, size: 22 * scale, color: const Color(0xFF475569)),
            items: items
                .map(
                  (option) => DropdownMenuItem(
                    value: option.id,
                    child: Text(option.label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
          ),
        ),
        if (showError)
          Padding(
            padding: EdgeInsets.only(top: 6 * scale),
            child: Text(
              'Ce champ est requis.',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12 * scale),
            ),
          ),
      ],
    );
  }
}

class _AttachmentSection extends GetView<ReportProblemController> {
  const _AttachmentSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preuves (optionnel)', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 6 * scale),
        Text(
          'Ajoutez des captures d’écran ou d’autres preuves pour étayer votre signalement.',
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.45),
        ),
        SizedBox(height: 18 * scale),
        GestureDetector(
          onTap: controller.pickAttachment,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 28 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56 * scale,
                  height: 56 * scale,
                  decoration: BoxDecoration(color: const Color(0x19176BFF), borderRadius: BorderRadius.circular(16 * scale)),
                  alignment: Alignment.center,
                  child: Icon(Icons.cloud_upload_rounded, color: const Color(0xFF176BFF), size: 26 * scale),
                ),
                SizedBox(height: 14 * scale),
                Text('Ajouter des fichiers', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Text('PNG, JPG, PDF jusqu’à 10 MB', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
              ],
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        Obx(
          () {
            if (controller.attachments.isEmpty) {
              return Text('Aucun fichier ajouté.', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12.5 * scale));
            }
            return Column(
              children: controller.attachments
                  .map(
                    (attachment) => Container(
                      margin: EdgeInsets.only(bottom: 10 * scale),
                      padding: EdgeInsets.all(12 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14 * scale),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42 * scale,
                            height: 42 * scale,
                            decoration: BoxDecoration(color: const Color(0x19176BFF), borderRadius: BorderRadius.circular(12 * scale)),
                            alignment: Alignment.center,
                            child: Icon(Icons.insert_drive_file_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
                          ),
                          SizedBox(width: 12 * scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(attachment.name, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale, fontWeight: FontWeight.w600)),
                                SizedBox(height: 2 * scale),
                                Text(attachment.sizeLabel, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12 * scale)),
                                if (attachment.status == AttachmentStatus.uploading)
                                  Padding(
                                    padding: EdgeInsets.only(top: 8 * scale),
                                    child: Obx(
                                      () => LinearProgressIndicator(
                                        value: controller.uploadProgress.value,
                                        backgroundColor: const Color(0xFFE2E8F0),
                                        color: const Color(0xFF16A34A),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.removeAttachment(attachment),
                            icon: Icon(Icons.close_rounded, color: const Color(0xFF475569), size: 18 * scale),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _DetailsSection extends GetView<ReportProblemController> {
  const _DetailsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final borderColor = controller.showDescriptionError ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Détails supplémentaires', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 6 * scale),
        Text(
          'Décrivez la situation en détail. Plus vous nous donnerez d’informations, mieux nous pourrons traiter votre signalement.',
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.45),
        ),
        SizedBox(height: 16 * scale),
        Obx(
          () => TextField(
            controller: controller.detailsController,
            maxLength: controller.descriptionMax,
            maxLines: 6,
            onChanged: controller.onDetailsChanged,
            decoration: InputDecoration(
              hintText: 'Décrivez la situation…',
              hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
              filled: true,
              fillColor: Colors.white,
              counterText: '${controller.descriptionLength}/${controller.descriptionMax}',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16 * scale),
                borderSide: BorderSide(color: borderColor, width: 1.4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16 * scale),
                borderSide: BorderSide(color: controller.showDescriptionError ? const Color(0xFFEF4444) : const Color(0xFF176BFF), width: 1.6),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 18 * scale),
            ),
          ),
        ),
        SizedBox(height: 6 * scale),
        Row(
          children: [
            Text('Minimum 20 caractères', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
            const Spacer(),
            Obx(
              () => Text(
                '${controller.descriptionLength}/${controller.descriptionMax}',
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
              ),
            ),
          ],
        ),
        if (controller.showDescriptionError)
          Padding(
            padding: EdgeInsets.only(top: 6 * scale),
            child: Text('Ajoutez au moins 20 caractères.', style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12 * scale)),
          ),
      ],
    );
  }
}

class _UrgencySection extends GetView<ReportProblemController> {
  const _UrgencySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Niveau d’urgence', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 6 * scale),
        Text('Évaluez la gravité de la situation.', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale)),
        SizedBox(height: 16 * scale),
        Obx(
          () => Row(
            children: controller.urgencyLevels
                .map(
                  (level) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: level == controller.urgencyLevels.last ? 0 : 12 * scale),
                      child: GestureDetector(
                        onTap: () => controller.selectUrgency(level.id),
                        child: Container(
                          padding: EdgeInsets.all(16 * scale),
                          decoration: BoxDecoration(
                            color: controller.selectedUrgencyId.value == level.id ? level.color.withValues(alpha: 0.12) : Colors.white,
                            borderRadius: BorderRadius.circular(16 * scale),
                            border: Border.all(
                              color: controller.selectedUrgencyId.value == level.id ? level.color : const Color(0xFFE2E8F0),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 20 * scale,
                                height: 20 * scale,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: controller.selectedUrgencyId.value == level.id ? level.color : const Color(0xFFCBD5F5), width: 2),
                                  color: controller.selectedUrgencyId.value == level.id ? level.color : Colors.transparent,
                                ),
                              ),
                              SizedBox(height: 10 * scale),
                              Text(level.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                              SizedBox(height: 6 * scale),
                              Text(level.description,
                                  textAlign: TextAlign.center, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, height: 1.35)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        if (controller.showUrgencyError)
          Padding(
            padding: EdgeInsets.only(top: 6 * scale),
            child: Text('Sélectionnez un niveau d’urgence.', style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12 * scale)),
          ),
      ],
    );
  }
}

class _UserSection extends GetView<ReportProblemController> {
  const _UserSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Utilisateur concerné', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 6 * scale),
        Text('Informations sur la personne ou le contenu signalé.', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale)),
        SizedBox(height: 18 * scale),
        Container(
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48 * scale,
                    height: 48 * scale,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Marc Dubois', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4 * scale),
                        Text('@marc.dubois.tennis', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                    decoration: BoxDecoration(color: const Color(0x1916A34A), borderRadius: BorderRadius.circular(999)),
                    child: Row(
                      children: [
                        Icon(Icons.verified_rounded, color: const Color(0xFF16A34A), size: 16 * scale),
                        SizedBox(width: 6 * scale),
                        Text('Vérifié', style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16 * scale),
              _InfoRow(scale: scale, label: 'Membre depuis', value: 'Mars 2023'),
              _InfoRow(scale: scale, label: 'Matchs joués', value: '47'),
            ],
          ),
        ),
        SizedBox(height: 16 * scale),
        _CheckboxRow(
          scale: scale,
          label: 'Bloquer cet utilisateur après le signalement',
          value: controller.blockUser,
          onChanged: controller.toggleBlockUser,
        ),
        SizedBox(height: 10 * scale),
        _CheckboxRow(
          scale: scale,
          label: 'Recevoir des mises à jour sur ce signalement',
          value: controller.receiveUpdates,
          onChanged: controller.toggleReceiveUpdates,
        ),
      ],
    );
  }
}

class _HistorySection extends GetView<ReportProblemController> {
  const _HistorySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Signalements précédents', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 6 * scale),
        Text('Vos signalements récents.', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale)),
        SizedBox(height: 16 * scale),
        ...controller.previousReports.map(
          (report) => Container(
            margin: EdgeInsets.only(bottom: 12 * scale),
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(report.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                    ),
                    _StatusChip(scale: scale, status: report.status),
                  ],
                ),
                SizedBox(height: 8 * scale),
                Text(report.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EmergencySection extends GetView<ReportProblemController> {
  const _EmergencySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Besoin d’aide immédiate ?', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 6 * scale),
        Text('Ressources et contacts d’urgence.', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale)),
        SizedBox(height: 16 * scale),
        Row(
          children: controller.emergencyResources
              .map(
                (resource) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: resource == controller.emergencyResources.last ? 0 : 12 * scale),
                    padding: EdgeInsets.all(16 * scale),
                    decoration: BoxDecoration(
                      color: resource.background,
                      borderRadius: BorderRadius.circular(16 * scale),
                      border: Border.all(color: resource.color),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(resource.icon, color: resource.color, size: 28 * scale),
                        SizedBox(height: 12 * scale),
                        Text(resource.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(color: resource.color, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 6 * scale),
                        Text(resource.subtitle,
                            textAlign: TextAlign.center, style: GoogleFonts.inter(color: resource.color.withValues(alpha: 0.85), fontSize: 12 * scale)),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, color: const Color(0xFF475569), size: 20 * scale),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Confidentialité et sécurité', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 6 * scale),
                Text(
                  'Votre signalement est traité de manière confidentielle. Nous prenons tous les signalements au sérieux et enquêtons rapidement.',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45),
                ),
                SizedBox(height: 10 * scale),
                Row(
                  children: [
                    Icon(Icons.verified_user_outlined, color: const Color(0xFF475569), size: 16 * scale),
                    SizedBox(width: 8 * scale),
                    Text('Données chiffrées et protégées', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterSection extends GetView<ReportProblemController> {
  const _FooterSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => controller.errorMessage.value.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 12 * scale),
                  padding: EdgeInsets.all(14 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0x19EF4444),
                    borderRadius: BorderRadius.circular(14 * scale),
                    border: Border.all(color: const Color(0xFFEF4444)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline_rounded, color: const Color(0xFFEF4444), size: 18 * scale),
                      SizedBox(width: 10 * scale),
                      Expanded(
                        child: Text(
                          controller.errorMessage.value,
                          style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12.5 * scale),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Obx(
          () => SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.canSubmit ? controller.submit : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                backgroundColor: const Color(0xFF176BFF),
                disabledBackgroundColor: const Color(0xFFD1D5DB),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              icon: controller.isSubmitting.value
                  ? SizedBox(width: 20 * scale, height: 20 * scale, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Icon(Icons.send_rounded, color: Colors.white, size: 18 * scale),
              label: controller.isSubmitting.value
                  ? Text('Envoi en cours...', style: GoogleFonts.poppins(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600))
                  : Text('Envoyer le signalement', style: GoogleFonts.poppins(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: controller.saveDraft,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              side: const BorderSide(color: Color(0xFFE2E8F0), width: 2),
            ),
            icon: Icon(Icons.bookmark_add_outlined, color: const Color(0xFF0B1220), size: 18 * scale),
            label: Text('Sauvegarder en brouillon', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 16 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer_outlined, size: 14 * scale, color: const Color(0xFF94A3B8)),
            SizedBox(width: 6 * scale),
            Text('Temps de traitement moyen : 24-48 heures', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
          ],
        ),
      ],
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({
    required this.scale,
    required this.title,
    required this.description,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final double scale;
  final String title;
  final String description;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(18 * scale),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF176BFF).withValues(alpha: 0.06) : Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: selected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0), width: selected ? 2 : 1.2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20 * scale,
              height: 20 * scale,
              margin: EdgeInsets.only(top: 4 * scale),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected ? const Color(0xFF176BFF) : const Color(0xFFCBD5F5), width: 2),
                color: selected ? const Color(0xFF176BFF) : Colors.white,
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: const Color(0xFF176BFF), size: 20 * scale),
                      SizedBox(width: 8 * scale),
                      Expanded(
                        child: Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  SizedBox(height: 6 * scale),
                  Text(description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.scale, required this.status});

  final double scale;
  final ReportHistoryStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status == ReportHistoryStatus.resolved ? const Color(0xFF16A34A) : const Color(0xFFF59E0B);
    final label = status == ReportHistoryStatus.resolved ? 'Résolu' : 'En cours';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status == ReportHistoryStatus.resolved ? Icons.check_circle_outline : Icons.schedule_rounded, color: color, size: 14 * scale),
          SizedBox(width: 6 * scale),
          Text(label, style: GoogleFonts.inter(color: color, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _CheckboxRow extends StatelessWidget {
  const _CheckboxRow({required this.scale, required this.label, required this.value, required this.onChanged});

  final double scale;
  final String label;
  final RxBool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () => onChanged(!value.value),
        child: Row(
          children: [
            Container(
              width: 22 * scale,
              height: 22 * scale,
              decoration: BoxDecoration(
                color: value.value ? const Color(0xFF176BFF) : Colors.white,
                borderRadius: BorderRadius.circular(6 * scale),
                border: Border.all(color: value.value ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0), width: 1.6),
              ),
              child: value.value ? Icon(Icons.check_rounded, color: Colors.white, size: 16 * scale) : null,
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale)),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.scale, required this.label, required this.value});

  final double scale;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8 * scale),
      child: Row(
        children: [
          Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
          const Spacer(),
          Text(value, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8 * scale, offset: Offset(0, 4 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}
