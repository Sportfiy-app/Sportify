import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/cancel_reservation_controller.dart';

class CancelReservationView extends GetView<CancelReservationController> {
  const CancelReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.88, 1.1);
          return SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Header(scale: scale),
                        SizedBox(height: 16 * scale),
                        _ProgressIndicator(scale: scale),
                        SizedBox(height: 20 * scale),
                        _ReservationCard(scale: scale),
                        SizedBox(height: 18 * scale),
                        _WarningCard(scale: scale),
                        SizedBox(height: 18 * scale),
                        _FormSection(scale: scale),
                        SizedBox(height: 28 * scale),
                        _FooterActions(scale: scale),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          scale: scale,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: Get.back,
        ),
        const Spacer(),
        Text(
          'Annuler ma réservation',
          style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        _CircleButton(
          scale: scale,
          icon: Icons.info_outline_rounded,
          onTap: () => Get.snackbar('Aide', 'Contactez le support si vous avez besoin d’assistance.'),
        ),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
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
              Text('Étape 1 sur 2', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
              const Spacer(),
              Text('50%', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 12 * scale),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.5,
              minHeight: 8 * scale,
              backgroundColor: const Color(0xFFE2E8F0),
              color: const Color(0xFF176BFF),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  const _ReservationCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8 * scale, offset: Offset(0, 4 * scale)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            child: Icon(Icons.sports_tennis_rounded, color: const Color(0xFF176BFF), size: 26 * scale),
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terrain de Tennis - Court Central',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8 * scale),
                _InfoRow(scale: scale, icon: Icons.event_rounded, label: 'Samedi 2 Novembre, 14h00 - 16h00'),
                SizedBox(height: 4 * scale),
                _InfoRow(scale: scale, icon: Icons.location_on_outlined, label: 'Tennis Club de Paris 16ᵉ'),
                SizedBox(height: 4 * scale),
                _InfoRow(scale: scale, icon: Icons.euro_rounded, label: '45,00 €'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningCard extends StatelessWidget {
  const _WarningCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: const Color(0x19F59E0B),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0x4CF59E0B)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.5),
                children: [
                  const TextSpan(text: 'Attention\n', style: TextStyle(fontWeight: FontWeight.w600)),
                  const TextSpan(text: 'L’annulation moins de 24h avant le créneau peut entraîner des frais. Consultez nos '),
                  TextSpan(
                    text: 'conditions générales',
                    style: const TextStyle(color: Color(0xFF176BFF), decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = () => Get.snackbar('Conditions', 'Ouverture des CGV prochainement.'),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormSection extends GetView<CancelReservationController> {
  const _FormSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vous rencontrez un problème ? Signalez-le nous maintenant.',
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale),
        ),
        SizedBox(height: 16 * scale),
        _Label(scale: scale, text: 'Motif d’annulation', required: true),
        SizedBox(height: 8 * scale),
        Obx(
          () => DropdownButtonFormField<String>(
            value: controller.selectedMotif.value.isEmpty ? null : controller.selectedMotif.value,
            items: controller.motifs
                .map(
                  (motif) => DropdownMenuItem(
                    value: motif,
                    child: Text(motif, style: GoogleFonts.inter(fontSize: 14 * scale, color: const Color(0xFF0B1220))),
                  ),
                )
                .toList(),
            onChanged: controller.isSubmitting.value ? null : controller.selectMotif,
            decoration: _inputDecoration(scale: scale, hint: 'Choisir un motif'),
            icon: Icon(Icons.expand_more_rounded, size: 22 * scale, color: const Color(0xFF475569)),
          ),
        ),
        SizedBox(height: 16 * scale),
        _Label(scale: scale, text: 'Précisez', required: true),
        SizedBox(height: 8 * scale),
        TextField(
          controller: controller.detailsController,
          maxLines: 6,
          maxLength: 500,
          onChanged: controller.onDetailsChanged,
          decoration: _inputDecoration(scale: scale, hint: 'Écrivez ici...').copyWith(counterText: ''),
        ),
        SizedBox(height: 16 * scale),
        Text('Ajouter un fichier (optionnel)', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
        SizedBox(height: 8 * scale),
        _AttachmentPicker(scale: scale),
        SizedBox(height: 8 * scale),
        Text('* Les champs marqués sont obligatoires', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
        Obx(
          () => controller.errorMessage.value.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(top: 8 * scale),
                  child: Text(controller.errorMessage.value, style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12.5 * scale)),
                ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({required double scale, required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 14 * scale),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14 * scale),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14 * scale),
        borderSide: const BorderSide(color: Color(0xFF176BFF)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
    );
  }
}

class _AttachmentPicker extends GetView<CancelReservationController> {
  const _AttachmentPicker({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: controller.pickAttachment,
          child: Container(
            width: double.infinity,
            height: 152 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56 * scale,
                  height: 56 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0x1916A34A),
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                  child: Icon(Icons.cloud_upload_rounded, color: const Color(0xFF16A34A), size: 28 * scale),
                ),
                SizedBox(height: 12 * scale),
                Text('Appuyez pour choisir un fichier', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14.5 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Text('ou glissez-déposez ici', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                SizedBox(height: 6 * scale),
                Text('PNG, JPG, PDF jusqu’à 5MB', style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
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
                            width: 40 * scale,
                            height: 40 * scale,
                            decoration: BoxDecoration(
                              color: const Color(0x19176BFF),
                              borderRadius: BorderRadius.circular(12 * scale),
                            ),
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
                                if (attachment.status == AttachmentStatus.uploading) ...[
                                  SizedBox(height: 6 * scale),
                                  LinearProgressIndicator(
                                    value: controller.uploadProgress.value,
                                    minHeight: 6 * scale,
                                    backgroundColor: const Color(0xFFE2E8F0),
                                    color: const Color(0xFF16A34A),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(width: 12 * scale),
                          if (attachment.status == AttachmentStatus.uploading)
                            SizedBox(width: 20 * scale, height: 20 * scale, child: const CircularProgressIndicator(strokeWidth: 2))
                          else
                            IconButton(
                              icon: Icon(Icons.close_rounded, size: 18 * scale, color: const Color(0xFF475569)),
                              onPressed: () => controller.removeAttachment(attachment),
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

class _FooterActions extends GetView<CancelReservationController> {
  const _FooterActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.canSubmit ? controller.submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
                disabledBackgroundColor: const Color(0xFFD1D5DB),
              ),
              child: controller.isSubmitting.value
                  ? SizedBox(width: 20 * scale, height: 20 * scale, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text('Confirmer l’annulation', style: GoogleFonts.poppins(fontSize: 16 * scale, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SecondaryChip(scale: scale, icon: Icons.save_alt_rounded, label: 'Sauvegarder le brouillon'),
            SizedBox(width: 12 * scale),
            _SecondaryChip(
              scale: scale,
              icon: Icons.support_agent_rounded,
              label: 'Contacter le support',
              onTap: () => Get.toNamed(Routes.reportProblem),
            ),
          ],
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.scale, required this.text, this.required = false});

  final double scale;
  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
        if (required)
          Text(' *', style: GoogleFonts.poppins(color: const Color(0xFFEF4444), fontSize: 14 * scale, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _SecondaryChip extends StatelessWidget {
  const _SecondaryChip({required this.scale, required this.icon, required this.label, this.onTap});

  final double scale;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16 * scale, color: const Color(0xFF475569)),
            SizedBox(width: 8 * scale),
            Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF475569), size: 16 * scale),
        SizedBox(width: 8 * scale),
        Expanded(child: Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale))),
      ],
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
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10 * scale, offset: Offset(0, 4 * scale)),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}

