import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_delete_account_controller.dart';

class ProfileDeleteAccountView extends GetView<ProfileDeleteAccountController> {
  const ProfileDeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const designWidth = 375.0;
            final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.of(context).size.width;
            final scale = (width / designWidth).clamp(0.9, 1.1);

            return Column(
              children: [
                _Header(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 20 * scale),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: designWidth * scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _DangerHero(scale: scale),
                          SizedBox(height: 20 * scale),
                          _AccountSummaryCard(scale: scale),
                          SizedBox(height: 20 * scale),
                          _ImpactSection(scale: scale),
                          SizedBox(height: 20 * scale),
                          _AlternativesSection(scale: scale),
                          SizedBox(height: 20 * scale),
                          _FeedbackSection(scale: scale),
                          SizedBox(height: 20 * scale),
                          _SecuritySection(scale: scale),
                          SizedBox(height: 20 * scale),
                          _FinalConfirmationSection(scale: scale),
                          SizedBox(height: 20 * scale),
                          _SupportSection(scale: scale),
                          SizedBox(height: 120 * scale),
                        ],
                      ),
                    ),
                  ),
                ),
                _BottomActions(scale: scale),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              padding: EdgeInsets.all(10 * scale),
              shape: const CircleBorder(),
            ),
          ),
          Expanded(
            child: Text(
              'Supprimer le compte',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 19 * scale, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 44 * scale),
        ],
      ),
    );
  }
}

class _DangerHero extends StatelessWidget {
  const _DangerHero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFFECACA)),
        boxShadow: [BoxShadow(color: const Color(0x4CEF4444), blurRadius: 24 * scale, offset: Offset(0, 12 * scale))],
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52 * scale,
            height: 52 * scale,
            decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(Icons.warning_amber_rounded, color: Colors.white, size: 26 * scale),
          ),
          SizedBox(width: 18 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Action irréversible', style: GoogleFonts.poppins(color: const Color(0xFFEF4444), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 10 * scale),
                Text(
                  'La suppression de votre compte est définitive. Toutes vos données, réservations, et connexions seront perdues à jamais.',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountSummaryCard extends GetView<ProfileDeleteAccountController> {
  const _AccountSummaryCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    final stats = controller.stats;
    final activities = controller.recentActivities;
    return _Card(
      scale: scale,
      title: 'Récapitulatif de votre compte',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32 * scale,
                backgroundImage: NetworkImage(summary.avatarUrl),
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(summary.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4 * scale),
                    Text(summary.memberSince, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
                    SizedBox(height: 12 * scale),
                    Wrap(
                      spacing: 10 * scale,
                      runSpacing: 8 * scale,
                      children: [
                        _InfoChip(scale: scale, label: summary.levelLabel, color: const Color(0xFF16A34A)),
                        _InfoChip(scale: scale, label: summary.matchesLabel, color: const Color(0xFF176BFF)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: stats.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12 * scale,
              mainAxisSpacing: 12 * scale,
              childAspectRatio: 3.1,
            ),
            itemBuilder: (context, index) {
              final stat = stats[index];
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(stat.value, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
                    SizedBox(height: 6 * scale),
                    Text(stat.label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 24 * scale),
          Text('Activités récentes', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 14 * scale),
          ...activities.map(
            (activity) => Padding(
              padding: EdgeInsets.only(bottom: 12 * scale),
              child: Row(
                children: [
                  Container(
                    width: 36 * scale,
                    height: 36 * scale,
                    decoration: BoxDecoration(color: const Color(0x19176BFF), shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Icon(Icons.sports_soccer_rounded, color: const Color(0xFF176BFF), size: 18 * scale),
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activity.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 2 * scale),
                        Text(activity.timeAgo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImpactSection extends GetView<ProfileDeleteAccountController> {
  const _ImpactSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Ce qui sera supprimé',
      child: Column(
        children: controller.impactItems
            .map(
              (item) => Container(
                margin: EdgeInsets.only(bottom: 12 * scale),
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: const Color(0xFFFECACA)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32 * scale,
                      height: 32 * scale,
                      decoration: BoxDecoration(color: const Color(0x19EF4444), borderRadius: BorderRadius.circular(12 * scale)),
                      alignment: Alignment.center,
                      child: Icon(Icons.close_rounded, color: const Color(0xFFEF4444), size: 16 * scale),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6 * scale),
                          Text(item.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _AlternativesSection extends GetView<ProfileDeleteAccountController> {
  const _AlternativesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Alternatives à considérer',
      child: Column(
        children: controller.alternatives
            .map(
              (alternative) => Container(
                margin: EdgeInsets.only(bottom: 12 * scale),
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [alternative.colors.first, alternative.colors.first.withValues(alpha: 0.3)]),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: alternative.colors.last),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(12 * scale)),
                      alignment: Alignment.center,
                      child: Icon(Icons.auto_awesome_rounded, color: alternative.colors.last.withAlpha(0xFF), size: 18 * scale),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(alternative.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 6 * scale),
                          Text(alternative.description, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                          SizedBox(height: 10 * scale),
                          GestureDetector(
                            onTap: () => Get.snackbar(alternative.title, 'Fonctionnalité à venir.'),
                            child: Text(
                              alternative.actionLabel,
                              style: GoogleFonts.inter(color: alternative.colors.last.darken(), fontSize: 13 * scale, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _FeedbackSection extends GetView<ProfileDeleteAccountController> {
  const _FeedbackSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Aidez-nous à nous améliorer',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pourquoi souhaitez-vous supprimer votre compte ?',
            style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12 * scale),
          ...controller.reasons.map(
            (reason) => Obx(
              () => RadioListTile<String>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF176BFF),
                title: Text(reason, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
                value: reason,
                groupValue: controller.selectedReason.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.selectReason(value);
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          Text('Commentaires supplémentaires (optionnel)', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 12 * scale),
          TextField(
            controller: controller.commentsController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Dites-nous ce qui pourrait nous aider à vous retenir...',
              hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
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
            ),
          ),
        ],
      ),
    );
  }
}

class _SecuritySection extends GetView<ProfileDeleteAccountController> {
  const _SecuritySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Vérification de sécurité',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Confirmez votre mot de passe', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 12 * scale),
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Saisissez votre mot de passe actuel',
              hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 14 * scale),
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
            ),
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFFEFCE8),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFFEF08A)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28 * scale,
                  height: 28 * scale,
                  decoration: BoxDecoration(color: const Color(0x19F59E0B), shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(Icons.timer_outlined, color: const Color(0xFFF59E0B), size: 16 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    'Votre compte sera désactivé immédiatement, puis définitivement supprimé après 30 jours. Vous pouvez le réactiver en vous reconnectant pendant cette période.',
                    style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FinalConfirmationSection extends GetView<ProfileDeleteAccountController> {
  const _FinalConfirmationSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Confirmation finale',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            controller.acknowledgementTexts.length,
            (index) => Obx(
              () => CheckboxListTile(
                dense: true,
                activeColor: const Color(0xFFEF4444),
                contentPadding: EdgeInsets.only(left: 4 * scale),
                value: controller.acknowledgements[index],
                onChanged: (value) => controller.toggleAcknowledgement(index, value ?? false),
                title: Text(
                  controller.acknowledgementTexts[index],
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.5),
                ),
              ),
            ),
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tapez "SUPPRIMER" pour confirmer',
                  style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12 * scale),
                TextField(
                  controller: controller.confirmController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'SUPPRIMER',
                    hintStyle: GoogleFonts.inter(color: const Color(0xFFADB5BD), fontSize: 14 * scale),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                      borderSide: const BorderSide(color: Color(0xFFFCA5A5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12 * scale),
                      borderSide: const BorderSide(color: Color(0xFFEF4444)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportSection extends GetView<ProfileDeleteAccountController> {
  const _SupportSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Besoin d’aide ?',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notre équipe support est là pour vous aider à résoudre vos problèmes.',
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale),
          ),
          SizedBox(height: 18 * scale),
          Row(
            children: controller.supportOptions
                .map(
                  (option) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: option == controller.supportOptions.last ? 0 : 12 * scale),
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                      decoration: BoxDecoration(
                        color: option.highlight ? const Color(0x19176BFF) : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(14 * scale),
                        border: Border.all(color: option.highlight ? const Color(0x33176BFF) : const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          Icon(option.icon, color: option.highlight ? const Color(0xFF176BFF) : const Color(0xFF0B1220), size: 22 * scale),
                          SizedBox(height: 10 * scale),
                          Text(option.label, textAlign: TextAlign.center, style: GoogleFonts.inter(color: option.highlight ? const Color(0xFF176BFF) : const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends GetView<ProfileDeleteAccountController> {
  const _BottomActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.fromLTRB(20 * scale, 16 * scale, 20 * scale, 24 * scale),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 56 * scale,
                child: ElevatedButton(
                  onPressed: controller.canSubmit.value ? controller.submitDeletion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    disabledBackgroundColor: const Color(0x33EF4444),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  ),
                  child: Obx(
                    () => controller.isDeletionInProgress.value
                        ? SizedBox(width: 20 * scale, height: 20 * scale, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text('Supprimer définitivement mon compte', style: GoogleFonts.poppins(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12 * scale),
            SizedBox(
              width: double.infinity,
              height: 52 * scale,
              child: OutlinedButton(
                onPressed: controller.cancelDeletion,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                child: Text('Annuler et revenir aux paramètres', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.scale, required this.label, required this.color});

  final double scale;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: GoogleFonts.inter(color: color, fontSize: 12.5 * scale, fontWeight: FontWeight.w600)),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.scale, required this.title, required this.child});

  final double scale;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 18 * scale, offset: Offset(0, 12 * scale))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 16 * scale),
          child,
        ],
      ),
    );
  }
}

extension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

