import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.88, 1.12);

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 240 * scale,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                      begin: Alignment(0.35, 0.35),
                      end: Alignment(1.06, -0.35),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
                      child: _HeaderBar(scale: scale),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale).copyWith(bottom: 160 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SummaryCard(scale: scale),
                            SizedBox(height: 20 * scale),
                            _StatsStrip(scale: scale),
                            SizedBox(height: 28 * scale),
                            _SectionGroupTitle(scale: scale, title: 'Essentiels du profil'),
                            SizedBox(height: 12 * scale),
                            ...controller.essentials.map(
                              (section) => Padding(
                                padding: EdgeInsets.only(bottom: 12 * scale),
                                child: _SectionTile(scale: scale, section: section),
                              ),
                            ),
                            SizedBox(height: 28 * scale),
                            _SectionGroupTitle(scale: scale, title: 'Personnalisation'),
                            SizedBox(height: 12 * scale),
                            ...controller.personalization.map(
                              (section) => Padding(
                                padding: EdgeInsets.only(bottom: 12 * scale),
                                child: _SectionTile(scale: scale, section: section),
                              ),
                            ),
                            SizedBox(height: 24 * scale),
                            _BiographyCard(scale: scale),
                            SizedBox(height: 28 * scale),
                            _PremiumCard(scale: scale),
                            SizedBox(height: 28 * scale),
                            _SectionGroupTitle(scale: scale, title: 'Compte & sécurité'),
                            SizedBox(height: 12 * scale),
                            ...controller.account.map(
                              (section) => Padding(
                                padding: EdgeInsets.only(bottom: 12 * scale),
                                child: _SectionTile(scale: scale, section: section),
                              ),
                            ),
                            SizedBox(height: 32 * scale),
                            _DangerZone(scale: scale),
                          ],
                        ),
                      ),
                    ),
                    _BottomActions(scale: scale),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18 * scale),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Modifier mon profil',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20 * scale,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Container(
          width: 44 * scale,
          height: 44 * scale,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.help_outline_rounded, color: Colors.white, size: 20 * scale),
        ),
      ],
    );
  }
}

class _SummaryCard extends GetView<ProfileEditController> {
  const _SummaryCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 86 * scale,
                    height: 86 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4 * scale),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 20 * scale, offset: Offset(0, 10 * scale)),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=60'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10 * scale,
                    right: -4 * scale,
                    child: GestureDetector(
                      onTap: () {
                        controller.openSection(controller.essentials[1]);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white, width: 2 * scale),
                        ),
                        child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16 * scale),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summary.name,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF0B1220),
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6 * scale),
                    Text(
                      summary.username,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12 * scale),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: summary.levelAccent,
                        borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                          BoxShadow(color: summary.levelAccent.withValues(alpha: 0.25), blurRadius: 14 * scale, offset: Offset(0, 8 * scale)),
                        ],
                      ),
                      child: Text(
                        summary.levelLabel,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12.5 * scale, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              padding: EdgeInsets.all(16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biographie',
                    style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8 * scale),
                  Text(
                    controller.biography.value,
                    style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.45),
                  ),
                  SizedBox(height: 12 * scale),
                  TextButton.icon(
                    onPressed: () => controller.openSection(
                      controller.personalization.firstWhere((element) => element.id == 'profile_bio'),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: const Color(0xFF176BFF),
                    ),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Modifier la biographie'),
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

class _StatsStrip extends GetView<ProfileEditController> {
  const _StatsStrip({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * scale),
        gradient: const LinearGradient(
          colors: [Color(0x11176BFF), Color(0x11FFB800)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 16 * scale),
      child: Row(
        children: [
          _StatChip(
            scale: scale,
            icon: Icons.star_rate_rounded,
            accent: const Color(0xFFFFB800),
            label: '${summary.rating}',
            caption: 'Note moyenne',
          ),
          _Divider(scale: scale),
          _StatChip(
            scale: scale,
            icon: Icons.emoji_events_outlined,
            accent: const Color(0xFF176BFF),
            label: '${summary.weeklyWins} cette semaine',
            caption: 'Victoires',
          ),
          _Divider(scale: scale),
          _StatChip(
            scale: scale,
            icon: Icons.sports_score_rounded,
            accent: const Color(0xFF16A34A),
            label: '${summary.matches}',
            caption: 'Matchs joués',
          ),
          _Divider(scale: scale),
          _StatChip(
            scale: scale,
            icon: Icons.access_time_rounded,
            accent: const Color(0xFFF97316),
            label: '${summary.streakHours}h',
            caption: 'Temps joué',
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.scale,
    required this.icon,
    required this.accent,
    required this.label,
    required this.caption,
  });

  final double scale;
  final IconData icon;
  final Color accent;
  final String label;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(color: accent.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(14 * scale)),
            alignment: Alignment.center,
            child: Icon(icon, color: accent, size: 20 * scale),
          ),
          SizedBox(height: 8 * scale),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13.5 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4 * scale),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 11.5 * scale),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 48 * scale, margin: EdgeInsets.symmetric(horizontal: 12 * scale), color: const Color(0xFFE2E8F0));
  }
}

class _SectionGroupTitle extends StatelessWidget {
  const _SectionGroupTitle({required this.scale, required this.title});

  final double scale;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: const Color(0xFF0B1220),
        fontSize: 18 * scale,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SectionTile extends GetView<ProfileEditController> {
  const _SectionTile({required this.scale, required this.section});

  final double scale;
  final ProfileEditSection section;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isUpdated = controller.updatedSections.contains(section.id);
        final canTap = !section.hasToggle;
        final content = Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: section.isDanger ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 14 * scale, offset: Offset(0, 8 * scale)),
              ],
            ),
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                Container(
                  width: 48 * scale,
                  height: 48 * scale,
                  decoration: BoxDecoration(
                    color: section.iconBackground,
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Icon(section.icon, color: section.iconTint, size: 24 * scale),
                ),
                SizedBox(width: 16 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.title,
                        style: GoogleFonts.poppins(
                          color: section.isDanger ? const Color(0xFFEF4444) : const Color(0xFF0B1220),
                          fontSize: 15.5 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4 * scale),
                      Text(
                        section.subtitle,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 13 * scale,
                        ),
                      ),
                      if (section.statuses.isNotEmpty) ...[
                        SizedBox(height: 10 * scale),
                        Wrap(
                          spacing: 8 * scale,
                          runSpacing: 8 * scale,
                          children: section.statuses
                              .map(
                                (status) => _StatusChip(
                                  scale: scale,
                                  status: status,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                if (section.hasToggle)
                  Switch.adaptive(
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotifications,
                    activeColor: section.iconTint,
                  )
                else
                  Column(
                    children: [
                      Icon(Icons.chevron_right_rounded, color: section.isDanger ? const Color(0xFFEF4444) : const Color(0xFF94A3B8), size: 24 * scale),
                      if (isUpdated)
                        Padding(
                          padding: EdgeInsets.only(top: 6 * scale),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
                            decoration: BoxDecoration(
                              color: const Color(0xFF16A34A).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle_rounded, color: const Color(0xFF16A34A), size: 14 * scale),
                                SizedBox(width: 4 * scale),
                                Text(
                                  'Modifié',
                                  style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 11 * scale, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          );
        if (!canTap) {
          return content;
        }
        return GestureDetector(
          onTap: () => controller.openSection(section),
          child: content,
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.scale, required this.status});

  final double scale;
  final ProfileEditStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: status.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status.icon != null) ...[
            Icon(status.icon, color: status.textColor, size: 14 * scale),
            SizedBox(width: 4 * scale),
          ],
          Text(
            status.label,
            style: GoogleFonts.inter(color: status.textColor, fontSize: 12 * scale, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _BiographyCard extends GetView<ProfileEditController> {
  const _BiographyCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(20 * scale),
          gradient: const LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Storytelling',
            style: GoogleFonts.poppins(color: Colors.white.withValues(alpha: 0.8), fontSize: 13 * scale, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10 * scale),
            Text(
              controller.biography.value,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, height: 1.6),
            ),
            SizedBox(height: 16 * scale),
            Text(
              'Astuce : Une biographie claire augmente les demandes de match de 24 %',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.5 * scale),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumCard extends GetView<ProfileEditController> {
  const _PremiumCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (!controller.hasPremium.value) {
          return GestureDetector(
            onTap: controller.openPremiumManagement,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20 * scale),
                gradient: const LinearGradient(
                  colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF0F5AE0).withValues(alpha: 0.25), blurRadius: 20 * scale, offset: Offset(0, 14 * scale)),
                ],
              ),
              padding: EdgeInsets.all(20 * scale),
              child: Row(
                children: [
                  Container(
                    width: 52 * scale,
                    height: 52 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(16 * scale),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 28 * scale),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sportify Premium',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 17 * scale, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 6 * scale),
                        Text(
                          'Débloquez des statistiques avancées et des partenaires vérifiés.',
                          style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 13 * scale),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: Colors.white, size: 24 * scale),
                ],
              ),
            ),
          );
        }

        final expires = controller.premiumExpires.value;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20 * scale),
            border: Border.all(color: const Color(0xFFFFB800), width: 1.5),
            gradient: const LinearGradient(
              colors: [Color(0xFFFFFBEB), Color(0xFFFFF3C4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(20 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52 * scale,
                    height: 52 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB800).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16 * scale),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.workspace_premium_rounded, color: const Color(0xFFFFB800), size: 28 * scale),
                  ),
                  SizedBox(width: 14 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.premiumLabel.value,
                          style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 17 * scale, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 6 * scale),
                        Text(
                          'Expire le ${expires.day.toString().padLeft(2, '0')}/${expires.month.toString().padLeft(2, '0')}/${expires.year}',
                          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: controller.openPremiumManagement,
                    style: TextButton.styleFrom(foregroundColor: const Color(0xFFFFB800)),
                    child: const Text('Gérer'),
                  ),
                ],
              ),
              SizedBox(height: 16 * scale),
              Wrap(
                spacing: 12 * scale,
                runSpacing: 12 * scale,
                children: const [
                  _PremiumPerk(icon: Icons.trending_up_rounded, label: 'Statistiques avancées'),
                  _PremiumPerk(icon: Icons.verified_user_rounded, label: 'Partenaires vérifiés'),
                  _PremiumPerk(icon: Icons.bolt_rounded, label: 'Réservations prioritaires'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PremiumPerk extends StatelessWidget {
  const _PremiumPerk({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFFFFB800), size: 18),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _DangerZone extends GetView<ProfileEditController> {
  const _DangerZone({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zone de danger',
          style: GoogleFonts.poppins(
            color: const Color(0xFFEF4444),
            fontSize: 15 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12 * scale),
        ...controller.danger.map(
          (section) => Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: _SectionTile(scale: scale, section: section),
          ),
        ),
      ],
    );
  }
}

class _BottomActions extends GetView<ProfileEditController> {
  const _BottomActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12 * scale, offset: Offset(0, -6 * scale)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: controller.resetChanges,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              child: Text(
                'Réinitialiser',
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 15 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: FilledButton(
              onPressed: controller.saveChanges,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              child: Text(
                'Enregistrer',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

