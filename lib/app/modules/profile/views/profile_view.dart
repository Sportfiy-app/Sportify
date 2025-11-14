import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/bottom_navigation/bottom_nav_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.88, 1.1);
          final padding = MediaQuery.of(context).padding;

          return SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _HeaderSection(scale: scale),
                                _ProgressionCard(scale: scale),
                                _SportsSection(scale: scale),
                                _StatsSection(scale: scale),
                                _WeeklyActivity(scale: scale),
                                _BadgesSection(scale: scale),
                                _ReputationSection(scale: scale),
                                _StreakSection(scale: scale),
                                _QuickActionsSection(scale: scale),
                                _FriendsSection(scale: scale),
                                SizedBox(height: 130 * scale),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const BottomNavWidget(),
                  ],
                ),
                Positioned(
                  left: 16 * scale,
                  right: 16 * scale,
                  bottom: 16 * scale + padding.bottom + 80 * scale,
                  child: _FloatingAction(scale: scale),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderSection extends GetView<ProfileController> {
  const _HeaderSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final data = controller.profile.value;
        if (data == null) {
          return const SizedBox.shrink();
        }
        return Stack(
          children: [
            Container(
              height: 270 * scale,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                  begin: Alignment(0.35, 0.35),
                  end: Alignment(1.06, -0.35),
                ),
              ),
            ),
            Positioned(
              top: 12 * scale,
              left: 16 * scale,
              right: 16 * scale,
              child: Row(
                children: [
                  _RoundButton(
                    scale: scale,
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: Get.back,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Mon profil',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2 * scale),
                        Text(
                          '4 nouvelles interactions',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _RoundButton(
                        scale: scale,
                        icon: Icons.settings_outlined,
                        onTap: controller.openSettings,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 80 * scale,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: controller.changeAvatar,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 108 * scale,
                          height: 108 * scale,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white, width: 4 * scale),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 20 * scale, offset: Offset(0, 12 * scale)),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.network(data.avatarUrl, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: -12 * scale,
                          left: (108 * scale - 74 * scale) / 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 6 * scale),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB800),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: Colors.white, width: 2 * scale),
                              boxShadow: [
                                BoxShadow(color: const Color(0x33176BFF), blurRadius: 20 * scale),
                              ],
                            ),
                            child: Text(
                              'Niv. ${data.level}',
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 36 * scale),
                  Text(
                    data.name,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 24 * scale, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6 * scale),
                  Text(
                    '${data.city} • ${data.age} ans',
                    style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 14 * scale, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 18 * scale),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24 * scale),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: _FrostedButton(
                            scale: scale,
                            icon: Icons.edit_rounded,
                            label: 'Modifier mon profil',
                            onTap: controller.editProfile,
                          ),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          flex: 2,
                          child: _FrostedButton(
                            scale: scale,
                            icon: Icons.visibility_outlined,
                            label: 'Voir public',
                            onTap: controller.viewPublicProfile,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProgressionCard extends GetView<ProfileController> {
  const _ProgressionCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final data = controller.profile.value;
        if (data == null) {
          return const SizedBox.shrink();
        }
        final progress = data.xpProgress.clamp(0.0, 1.0);
        final percent = (progress * 100).round();
        return Padding(
          padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 0),
          child: Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progression',
                      style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${data.xp} / ${data.xpTarget} XP',
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 14 * scale),
                Stack(
                  children: [
                    Container(
                      height: 12 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: constraints.maxWidth * progress,
                        height: 12 * scale,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -24 * scale,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '$percent%',
                          style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16 * scale),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.xpRemaining} XP',
                          style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2 * scale),
                        Text(
                          'jusqu’au niveau ${data.level + 1}',
                          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14 * scale),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 18 * scale),
                          SizedBox(width: 8 * scale),
                          Text(
                            'Niveau ${data.level}',
                            style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SportsSection extends GetView<ProfileController> {
  const _SportsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.sports_tennis_rounded,
            title: 'Mes sports',
            actionLabel: 'Ajouter',
            onAction: controller.addSport,
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: controller.sports
                .map(
                  (sport) => _SportCard(scale: scale, sport: sport),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SportCard extends StatelessWidget {
  const _SportCard({required this.scale, required this.sport});

  final double scale;
  final SportSummary sport;

  @override
  Widget build(BuildContext context) {
    final color = Color(sport.color);
    return Container(
      margin: EdgeInsets.only(bottom: 12 * scale),
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * scale),
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.04),
          ],
        ),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          _SportIcon(scale: scale, icon: sport.icon, color: color),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sport.name,
                  style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  '${sport.levelLabel} • ${sport.years} ans',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                ),
                SizedBox(height: 8 * scale),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        sport.levelLabel,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '+${sport.weeklyHours}h cette semaine',
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale, fontWeight: FontWeight.w500),
                    ),
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

class _StatsSection extends GetView<ProfileController> {
  const _StatsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = controller.stats;
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.analytics_outlined,
            title: 'Mes données',
            onAction: () => controller.openQuickAction(controller.quickActions[3]),
            actionLabel: 'Explorer',
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: stats
                .map(
                  (stat) => _StatTile(
                    scale: scale,
                    stat: stat,
                    onTap: stat.route != null ? () => controller.openStat(stat) : null,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.scale, required this.stat, this.onTap});

  final double scale;
  final ProfileStat stat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final accent = Color(stat.accent);
    final icon = stat.icon ?? Icons.sports_score_rounded;
    final child = Container(
      width: (343 * scale - 12 * scale) / 2,
      padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: accent, size: 22 * scale),
          ),
          SizedBox(height: 12 * scale),
          Text(
            stat.value,
            style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 22 * scale, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 4 * scale),
          Text(
            stat.label,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
    if (onTap == null) {
      return child;
    }
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}

class _WeeklyActivity extends GetView<ProfileController> {
  const _WeeklyActivity({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final data = controller.weeklyActivity;
    final maxValue = (data.map((point) => point.value).fold<int>(0, math.max)).clamp(1, 12);

    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activité cette semaine',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
                ),
                Text(
                  'total 7h',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 18 * scale),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data
                  .map(
                    (point) => Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 64 * scale,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: (point.value / maxValue) * 64 * scale,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                gradient: LinearGradient(
                                  colors: point.value == 0
                                      ? [const Color(0xFFE2E8F0), const Color(0xFFE2E8F0)]
                                      : [
                                          const Color(0xFF176BFF),
                                          const Color(0xFF0F5AE0),
                                        ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8 * scale),
                          Text(
                            point.label,
                            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 11 * scale, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgesSection extends GetView<ProfileController> {
  const _BadgesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final badges = controller.badges;
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.emoji_events_outlined,
            title: 'Badges & trophées',
            actionLabel: 'Voir tout',
            onAction: controller.viewAllBadges,
          ),
          SizedBox(height: 16 * scale),
          SizedBox(
            height: 130 * scale,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 8 * scale),
              itemBuilder: (context, index) => _BadgeTile(scale: scale, badge: badges[index]),
              separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
              itemCount: badges.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.scale, required this.badge});

  final double scale;
  final ProfileBadge badge;

  @override
  Widget build(BuildContext context) {
    final color = Color(badge.color);
    return Container(
      width: 110 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8 * scale, offset: Offset(0, 4 * scale)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 16 * scale),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: badge.locked ? [const Color(0xFFE5E7EB), const Color(0xFFE5E7EB)] : [color, color.withValues(alpha: 0.85)],
              ),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(badge.locked ? Icons.lock_outline_rounded : Icons.emoji_events_rounded, color: Colors.white, size: 24 * scale),
          ),
          SizedBox(height: 10 * scale),
          Text(
            badge.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: badge.locked ? const Color(0xFF9CA3AF) : const Color(0xFF0B1220),
              fontSize: 12.5 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (badge.locked) ...[
            SizedBox(height: 6 * scale),
            Text(
              'À débloquer',
              style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 11 * scale),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReputationSection extends GetView<ProfileController> {
  const _ReputationSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile.value;
    if (profile == null) {
      return const SizedBox.shrink();
    }
    final breakdown = controller.ratingBreakdown;
    final comments = controller.comments;
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.star_rate_rounded,
            title: 'Ma réputation',
          ),
          SizedBox(height: 16 * scale),
          Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.ratingAverage.toStringAsFixed(1),
                          style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 32 * scale, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star_rounded,
                              color: index < profile.ratingAverage.round() ? const Color(0xFFFFB800) : const Color(0xFFE2E8F0),
                              size: 18 * scale,
                            ),
                          ),
                        ),
                        SizedBox(height: 6 * scale),
                        Text(
                          '${profile.ratingCount} évaluations ce mois-ci',
                          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 150 * scale,
                      child: Column(
                        children: breakdown
                            .map(
                              (item) => _RatingBar(
                                scale: scale,
                                stars: item.stars,
                                percentage: item.percentage,
                                count: item.count,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18 * scale),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Commentaires récents',
                    style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 12 * scale),
                ...comments.map((comment) => _CommentTile(scale: scale, comment: comment, color: const Color(0xFF176BFF))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  const _RatingBar({required this.scale, required this.stars, required this.percentage, required this.count});

  final double scale;
  final int stars;
  final int percentage;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4 * scale),
      child: Row(
        children: [
          SizedBox(width: 12 * scale, child: Text('$stars', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale))),
          SizedBox(width: 24 * scale, child: Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale)),
          Expanded(
            child: Container(
              height: 8 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 8 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB800),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
          SizedBox(
            width: 28 * scale,
            child: Text(
              '$count',
              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.scale, required this.comment, required this.color});

  final double scale;
  final UserComment comment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12 * scale),
      padding: EdgeInsets.all(14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12 * scale),
              image: DecorationImage(image: NetworkImage(comment.avatarUrl), fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.author,
                        style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      '${comment.hoursAgo}h',
                      style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale),
                    ),
                  ],
                ),
                SizedBox(height: 6 * scale),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < comment.rating ? Icons.star_rounded : Icons.star_border_rounded,
                      color: index < comment.rating ? color : const Color(0xFFE2E8F0),
                      size: 16 * scale,
                    ),
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  comment.message,
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakSection extends GetView<ProfileController> {
  const _StreakSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final data = controller.profile.value;
    if (data == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44 * scale,
                  height: 44 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.local_fire_department_rounded, color: const Color(0xFFFF6B00), size: 24 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    'Streak & motivation',
                    style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Objectif 21 jours',
                    style: GoogleFonts.inter(color: const Color(0xFFF97316), fontSize: 11.5 * scale, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18 * scale),
            Row(
              children: [
                Expanded(
                  child: _StreakCard(
                    scale: scale,
                    title: 'Streak actuel',
                    value: '${data.streakDays} jours',
                    caption: 'Continuez sur votre lancée !',
                    color: const Color(0xFF16A34A),
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: _StreakCard(
                    scale: scale,
                    title: 'Meilleure série',
                    value: '${data.streakBest} jours',
                    caption: 'Nouveau record à battre',
                    color: const Color(0xFF176BFF),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.scale, required this.title, required this.value, required this.caption, required this.color});

  final double scale;
  final String title;
  final String value;
  final String caption;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 8 * scale),
          Text(value, style: GoogleFonts.poppins(color: color, fontSize: 22 * scale, fontWeight: FontWeight.w700)),
          SizedBox(height: 6 * scale),
          Text(caption, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
        ],
      ),
    );
  }
}

class _QuickActionsSection extends GetView<ProfileController> {
  const _QuickActionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final actions = controller.quickActions;
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.flash_on_rounded,
            title: 'Actions rapides',
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: actions
                .map(
                  (action) => _QuickActionCard(
                    scale: scale,
                    action: action,
                    onTap: () => controller.openQuickAction(action),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.scale, required this.action, required this.onTap});

  final double scale;
  final QuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = _mapSportIconColor(action.icon);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (343 * scale - 12 * scale) / 2,
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8 * scale, offset: Offset(0, 4 * scale))],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SportIcon(scale: scale, icon: action.icon, color: iconColor),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(action.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4 * scale),
                  Text(action.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendsSection extends GetView<ProfileController> {
  const _FriendsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final friends = controller.friends;
    final activities = controller.friendActivities;
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.people_alt_rounded,
            title: 'Mes amis',
            actionLabel: 'Voir tout',
            onAction: controller.viewAllFriends,
          ),
          SizedBox(height: 12 * scale),
          SizedBox(
            height: 80 * scale,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 8 * scale),
              itemBuilder: (context, index) => _FriendBubble(scale: scale, friend: friends[index]),
              separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
              itemCount: friends.length,
            ),
          ),
          SizedBox(height: 18 * scale),
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: activities
                  .map((activity) => _FriendActivityCard(scale: scale, activity: activity))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FriendBubble extends StatelessWidget {
  const _FriendBubble({required this.scale, required this.friend});

  final double scale;
  final FriendPreview friend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 60 * scale,
              height: 60 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18 * scale),
                image: DecorationImage(image: NetworkImage(friend.avatarUrl), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 4 * scale,
              right: 4 * scale,
              child: Container(
                width: 12 * scale,
                height: 12 * scale,
                decoration: BoxDecoration(
                  color: Color(friend.statusColor),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2 * scale),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6 * scale),
        SizedBox(
          width: 70 * scale,
          child: Text(
            friend.name,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _FriendActivityCard extends StatelessWidget {
  const _FriendActivityCard({required this.scale, required this.activity});

  final double scale;
  final FriendActivity activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * scale),
      child: Row(
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14 * scale),
              image: DecorationImage(image: NetworkImage(activity.avatarUrl), fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                    children: [
                      TextSpan(text: activity.author, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0B1220))),
                      TextSpan(text: ' ${activity.message}'),
                    ],
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  activity.timeLabel,
                  style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: const Color(0xFFCBD5F5), size: 20 * scale),
        ],
      ),
    );
  }
}

class _FloatingAction extends GetView<ProfileController> {
  const _FloatingAction({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22 * scale),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 24 * scale, offset: Offset(0, 12 * scale))],
      ),
      child: Row(
        children: [
          Expanded(
            child: _FloatingButton(
              scale: scale,
              label: 'Partager mon profil',
              icon: Icons.share_rounded,
              background: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
              textColor: Colors.white,
              onTap: () => Get.snackbar('Partage', 'Lien de partage généré !'),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: _FloatingButton(
              scale: scale,
              label: 'Inviter un ami',
              icon: Icons.person_add_alt_rounded,
              background: const LinearGradient(colors: [Color(0xFFF8FAFF), Color(0xFFF1F5F9)]),
              textColor: const Color(0xFF176BFF),
              borderColor: const Color(0xFFE2E8F0),
              onTap: () => Get.snackbar('Invitations', 'Invitation envoyée.'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({
    required this.scale,
    required this.label,
    required this.icon,
    required this.background,
    required this.textColor,
    required this.onTap,
    this.borderColor,
  });

  final double scale;
  final String label;
  final IconData icon;
  final Gradient background;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
        decoration: BoxDecoration(
          gradient: background,
          borderRadius: BorderRadius.circular(16 * scale),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 18 * scale),
            SizedBox(width: 8 * scale),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.inter(color: textColor, fontSize: 13.5 * scale, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44 * scale,
        height: 44 * scale,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 20 * scale),
      ),
    );
  }
}

class _FrostedButton extends StatelessWidget {
  const _FrostedButton({required this.scale, required this.icon, required this.label, required this.onTap});

  final double scale;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18 * scale),
            SizedBox(width: 8 * scale),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13.5 * scale, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.scale,
    required this.icon,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final double scale;
  final IconData icon;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34 * scale,
          height: 34 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFF176BFF).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFF176BFF), size: 18 * scale),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600),
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}

class _SportIcon extends StatelessWidget {
  const _SportIcon({required this.scale, required this.icon, required this.color});

  final double scale;
  final SportIcon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48 * scale,
      height: 48 * scale,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      alignment: Alignment.center,
      child: Icon(_mapSportIcon(icon), color: color, size: 22 * scale),
    );
  }
}

IconData _mapSportIcon(SportIcon icon) {
  switch (icon) {
    case SportIcon.soccer:
      return Icons.sports_soccer_rounded;
    case SportIcon.fitness:
      return Icons.fitness_center_rounded;
    case SportIcon.trophy:
      return Icons.emoji_events_rounded;
    case SportIcon.chart:
      return Icons.analytics_rounded;
    case SportIcon.eye:
      return Icons.visibility_rounded;
    case SportIcon.history:
      return Icons.history_rounded;
    case SportIcon.gift:
      return Icons.card_giftcard_rounded;
    case SportIcon.bookmark:
      return Icons.bookmark_rounded;
  }
}

Color _mapSportIconColor(SportIcon icon) {
  switch (icon) {
    case SportIcon.soccer:
      return const Color(0xFF16A34A);
    case SportIcon.fitness:
      return const Color(0xFFF97316);
    case SportIcon.trophy:
      return const Color(0xFFFFB800);
    case SportIcon.chart:
      return const Color(0xFF0EA5E9);
    case SportIcon.eye:
      return const Color(0xFF6B7280);
    case SportIcon.history:
      return const Color(0xFF6366F1);
    case SportIcon.gift:
      return const Color(0xFFD946EF);
    case SportIcon.bookmark:
      return const Color(0xFF176BFF);
  }
}

