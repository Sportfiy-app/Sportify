import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_actions_controller.dart';

class ProfileActionsView extends GetView<ProfileActionsController> {
  const ProfileActionsView({super.key});

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
                          _ProfileHero(scale: scale),
                          SizedBox(height: 20 * scale),
                          _QuickActions(scale: scale),
                          SizedBox(height: 24 * scale),
                          _SportsSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _StatsSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _BadgesSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _ActivitySection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _EventsSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _PreferencesSection(scale: scale),
                          SizedBox(height: 24 * scale),
                          _AccountActionsSection(scale: scale),
                          SizedBox(height: 32 * scale),
                        ],
                      ),
                    ),
                  ),
                ),
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
              'Mon profil',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 19 * scale, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            onPressed: () => Get.snackbar('Paramètres', 'Fonctionnalité à venir'),
            icon: const Icon(Icons.more_horiz_rounded, size: 22),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF3F4F6),
              padding: EdgeInsets.all(10 * scale),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends GetView<ProfileActionsController> {
  const _ProfileHero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final data = controller.header;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20 * scale),
        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: const Color(0x33176BFF), blurRadius: 24 * scale, offset: Offset(0, 18 * scale))],
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 48 * scale,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 44 * scale,
                  backgroundImage: NetworkImage(data.avatarUrl),
                ),
              ),
              Positioned(
                bottom: -4 * scale,
                right: MediaQuery.of(context).size.width * 0.32 * -1,
                child: Container(
                  width: 24 * scale,
                  height: 24 * scale,
                  decoration: const BoxDecoration(
                    color: Color(0xFF16A34A),
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 3)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            data.name,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6 * scale),
          Text(
            data.username,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 15 * scale),
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 8 * scale,
            alignment: WrapAlignment.center,
            children: [
              _HeroChip(scale: scale, label: data.levelLabel, icon: Icons.military_tech_rounded, background: Colors.white.withValues(alpha: 0.18)),
              _HeroChip(scale: scale, label: data.sportsCountLabel, icon: Icons.sports_soccer_rounded, background: Colors.white.withValues(alpha: 0.12)),
            ],
          ),
          SizedBox(height: 20 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HeroStat(scale: scale, value: data.matches.toString(), label: 'Matchs'),
              _HeroStat(scale: scale, value: data.wins.toString(), label: 'Victoires'),
              _HeroStat(scale: scale, value: '${data.rating}★', label: 'Rating'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.scale, required this.label, required this.icon, required this.background});

  final double scale;
  final String label;
  final IconData icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16 * scale, color: Colors.white),
          SizedBox(width: 8 * scale),
          Text(label, style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.scale, required this.value, required this.label});

  final double scale;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
        SizedBox(height: 4 * scale),
        Text(label, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 13 * scale)),
      ],
    );
  }
}

class _QuickActions extends GetView<ProfileActionsController> {
  const _QuickActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actions rapides', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: controller.quickActions
              .map(
                (action) => GestureDetector(
                  onTap: () => Get.snackbar(action.label, 'Action à venir.'),
                  child: Container(
                    width: (155 * scale).clamp(140, double.infinity),
                    padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 18 * scale),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: action.gradient),
                      borderRadius: BorderRadius.circular(16 * scale),
                      boxShadow: [BoxShadow(color: action.gradient.last.withValues(alpha: 0.2), blurRadius: 20 * scale, offset: Offset(0, 12 * scale))],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(action.icon, color: Colors.white, size: 22 * scale),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Text(action.label, style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                        ),
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

class _SportsSection extends GetView<ProfileActionsController> {
  const _SportsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Mes sports',
      trailing: TextButton(
        onPressed: () => Get.snackbar('Sports', 'Gestion des sports prochainement'),
        child: Text('Ajouter', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
      ),
      child: Column(
        children: controller.sports
            .map(
              (sport) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8 * scale),
                child: Row(
                  children: [
                    Container(
                      width: 44 * scale,
                      height: 44 * scale,
                      decoration: BoxDecoration(color: sport.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14 * scale)),
                      alignment: Alignment.center,
                      child: Icon(Icons.sports_soccer_rounded, color: sport.color, size: 22 * scale),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(sport.name, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4 * scale),
                          Text(sport.expertise, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                          SizedBox(height: 8 * scale),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6 * scale),
                            child: LinearProgressIndicator(
                              value: sport.progress,
                              minHeight: 6 * scale,
                              backgroundColor: const Color(0xFFE2E8F0),
                              valueColor: AlwaysStoppedAnimation<Color>(sport.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12 * scale),
                    Text(sport.badgeLabel, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _StatsSection extends GetView<ProfileActionsController> {
  const _StatsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Performances',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _StatTile(scale: scale, value: '70%', label: 'Taux de victoire', caption: '↗ +5% ce mois', gradient: const [Color(0xFF176BFF), Color(0xFF0F5AE0)])),
              SizedBox(width: 12 * scale),
              Expanded(child: _StatTile(scale: scale, value: '4.8', label: 'Note moyenne', caption: '★★★★★', gradient: const [Color(0xFF16A34A), Color(0xFF22C55E)])),
            ],
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: [
              Expanded(child: _StatTile(scale: scale, value: '23', label: 'Matchs ce mois', caption: '↗ +12 vs mois dernier', gradient: const [Color(0xFFFFB800), Color(0xFFF59E0B)])),
              SizedBox(width: 12 * scale),
              Expanded(child: _StatTile(scale: scale, value: '156', label: 'Points ELO', caption: 'Rang: Expert', gradient: const [Color(0xFF0EA5E9), Color(0xFF2563EB)])),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.scale,
    required this.value,
    required this.label,
    required this.caption,
    required this.gradient,
  });

  final double scale;
  final String value;
  final String label;
  final String caption;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * scale),
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: gradient.last.withValues(alpha: 0.28), blurRadius: 18 * scale, offset: Offset(0, 12 * scale))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 6 * scale),
          Text(label, style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 10 * scale),
          Text(caption, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 12 * scale)),
        ],
      ),
    );
  }
}

class _BadgesSection extends GetView<ProfileActionsController> {
  const _BadgesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Badges & Réalisations',
      trailing: TextButton(
        onPressed: () => Get.snackbar('Badges', 'Historique complet bientôt disponible'),
        child: Text('Voir tout', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
      ),
      child: Wrap(
        spacing: 12 * scale,
        runSpacing: 12 * scale,
        children: controller.primaryBadges
            .map(
              (badge) => Container(
                width: 100 * scale,
                height: 100 * scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18 * scale),
                  gradient: badge.muted
                      ? null
                      : LinearGradient(colors: badge.gradient, begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  color: badge.muted ? const Color(0xFFF1F5F9) : null,
                  border: Border.all(color: badge.muted ? const Color(0xFFE2E8F0) : Colors.transparent),
                  boxShadow: badge.muted
                      ? []
                      : [
                          BoxShadow(color: badge.gradient.last.withValues(alpha: 0.3), blurRadius: 18 * scale, offset: Offset(0, 12 * scale)),
                        ],
                ),
                padding: EdgeInsets.all(16 * scale),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events_rounded, color: badge.muted ? const Color(0xFF94A3B8) : Colors.white, size: 26 * scale),
                    SizedBox(height: 12 * scale),
                    Text(
                      badge.label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: badge.muted ? const Color(0xFF94A3B8) : Colors.white,
                        fontSize: 12.5 * scale,
                        fontWeight: FontWeight.w600,
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

class _ActivitySection extends GetView<ProfileActionsController> {
  const _ActivitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Activité récente',
      trailing: TextButton(
        onPressed: () => Get.snackbar('Activité', 'Historique complet bientôt disponible'),
        child: Text('Historique', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
      ),
      child: Column(
        children: controller.activities
            .map(
              (activity) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10 * scale),
                child: Row(
                  children: [
                    Container(
                      width: 48 * scale,
                      height: 48 * scale,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14 * scale), color: activity.statusColor.withValues(alpha: 0.15)),
                      alignment: Alignment.center,
                      child: Icon(Icons.flag_rounded, color: activity.statusColor, size: 22 * scale),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4 * scale),
                          Text(activity.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(activity.statusLabel, style: GoogleFonts.inter(color: activity.statusColor, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4 * scale),
                        Text(activity.timeLabel, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
                      ],
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

class _EventsSection extends GetView<ProfileActionsController> {
  const _EventsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Événements à venir',
      trailing: TextButton(
        onPressed: () => Get.snackbar('Événements', 'Calendrier disponible prochainement'),
        child: Text('Calendrier', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
      ),
      child: Column(
        children: controller.upcomingEvents
            .map(
              (event) => Container(
                margin: EdgeInsets.only(bottom: 14 * scale),
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16 * scale),
                  gradient: LinearGradient(colors: event.gradient),
                  border: Border.all(color: event.gradient.first.withValues(alpha: 0.4)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52 * scale,
                      height: 52 * scale,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16 * scale)),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(event.day, style: GoogleFonts.poppins(color: const Color(0xFF176BFF), fontSize: 18 * scale, fontWeight: FontWeight.w700)),
                          Text(event.month, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 11 * scale, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4 * scale),
                          Text('${event.location} • ${event.time}', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                          if (event.priceLabel != null) ...[
                            SizedBox(height: 6 * scale),
                            Text(event.priceLabel!, style: GoogleFonts.inter(color: const Color(0xFFFFB800), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                          ],
                          if (event.participantCount != null) ...[
                            SizedBox(height: 10 * scale),
                            Text('+${event.participantCount} participants', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                          ],
                        ],
                      ),
                    ),
                    if (event.ctaLabel != null)
                      ElevatedButton(
                        onPressed: () => Get.snackbar(event.title, 'Inscription prochainement'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF176BFF),
                          padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                        ),
                        child: Text(event.ctaLabel!, style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
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

class _PreferencesSection extends GetView<ProfileActionsController> {
  const _PreferencesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Préférences',
      child: Column(
        children: controller.preferences
            .map(
              (pref) => SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 4 * scale),
                value: pref.enabled,
                onChanged: (_) => Get.snackbar(pref.label, 'Réglage prochainement disponible'),
                activeColor: const Color(0xFF176BFF),
                title: Row(
                  children: [
                    Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12 * scale)),
                      alignment: Alignment.center,
                      child: Icon(pref.icon, color: const Color(0xFF176BFF), size: 18 * scale),
                    ),
                    SizedBox(width: 12 * scale),
                    Text(pref.label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _AccountActionsSection extends GetView<ProfileActionsController> {
  const _AccountActionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return _Card(
      scale: scale,
      title: 'Actions du compte',
      child: Column(
        children: controller.accountActions
            .map(
              (action) => ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => Get.snackbar(action.label, 'Action à venir.'),
                leading: Container(
                  width: 36 * scale,
                  height: 36 * scale,
                  decoration: BoxDecoration(
                    color: action.isDanger ? const Color(0xFFFEE2E2) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Icon(action.icon, color: action.isDanger ? const Color(0xFFEF4444) : const Color(0xFF176BFF), size: 18 * scale),
                ),
                title: Text(
                  action.label,
                  style: GoogleFonts.inter(
                    color: action.isDanger ? const Color(0xFFEF4444) : const Color(0xFF0B1220),
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(Icons.chevron_right_rounded, color: const Color(0xFFCBD5F5), size: 20 * scale),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.scale, required this.title, this.trailing, required this.child});

  final double scale;
  final String title;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 18 * scale, offset: Offset(0, 10 * scale))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
              if (trailing != null) trailing!,
            ],
          ),
          SizedBox(height: 16 * scale),
          child,
        ],
      ),
    );
  }
}

