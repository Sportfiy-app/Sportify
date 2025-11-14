import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/find_partner_controller.dart';

class UserActionsSheet extends GetView<FindPartnerController> {
  const UserActionsSheet({super.key});

  static Future<T?> show<T>() {
    final controller = Get.find<FindPartnerController>();
    controller.clearUserActionFeedback();
    return Get.bottomSheet<T>(
      const UserActionsSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final scale = (width / 375).clamp(0.85, 1.08);
    final profile = controller.profile;
    final stats = controller.profileStatistics.take(3).toList();
    final sports = controller.sportExperiences.take(3).toList();
    final activities = controller.recentActivity.take(2).toList();
    final quickActions = _QuickActionData.build(controller);

    return GestureDetector(
      onTap: Get.back,
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: media.size.height * 0.92,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 24 * scale,
                      offset: Offset(0, -8 * scale),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 44 * scale,
                          height: 4 * scale,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(999 * scale),
                          ),
                        ),
                      ),
                      SizedBox(height: 18 * scale),
                      Row(
                        children: [
                          _CircleButton(
                            scale: scale,
                            icon: Icons.share_outlined,
                            onTap: controller.shareProfile,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Profil de ${profile.name.split(' ').first}',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 18 * scale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          _CircleButton(
                            scale: scale,
                            icon: Icons.close_rounded,
                            onTap: Get.back,
                          ),
                        ],
                      ),
                      SizedBox(height: 18 * scale),
                      _ProfileSummary(scale: scale, profile: profile),
                      SizedBox(height: 16 * scale),
                      Obx(
                        () {
                          final feedback = controller.userActionFeedback.value;
                          if (feedback == null) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16 * scale),
                            child: _FeedbackBanner(scale: scale, feedback: feedback, onClose: controller.clearUserActionFeedback),
                          );
                        },
                      ),
                      if (sports.isNotEmpty) ...[
                        _SectionLabel(scale: scale, label: 'Sports en commun'),
                        SizedBox(height: 12 * scale),
                        Wrap(
                          spacing: 10 * scale,
                          runSpacing: 10 * scale,
                          children: sports
                              .map(
                                (sport) => _PillChip(
                                  scale: scale,
                                  icon: Icons.sports_tennis_rounded,
                                  label: sport.name,
                                  color: sport.iconGradient.first,
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: 20 * scale),
                      ],
                      _SectionLabel(scale: scale, label: 'Statistiques clés'),
                      SizedBox(height: 12 * scale),
                      _StatGrid(scale: scale, stats: stats),
                      SizedBox(height: 20 * scale),
                      if (activities.isNotEmpty) ...[
                        _SectionLabel(scale: scale, label: 'Activité récente'),
                        SizedBox(height: 12 * scale),
                        ...activities.map(
                          (activity) => Padding(
                            padding: EdgeInsets.only(bottom: activity == activities.last ? 0 : 12 * scale),
                            child: _ActivityTile(scale: scale, activity: activity),
                          ),
                        ),
                        SizedBox(height: 20 * scale),
                      ],
                      _PrimaryActions(scale: scale, controller: controller),
                      SizedBox(height: 20 * scale),
                      _SectionLabel(scale: scale, label: 'Actions rapides'),
                      SizedBox(height: 12 * scale),
                      _QuickActionsGrid(scale: scale, actions: quickActions),
                      SizedBox(height: 24 * scale),
                      _DangerZone(scale: scale, controller: controller),
                      SizedBox(height: 12 * scale),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({required this.scale, required this.profile});

  final double scale;
  final PartnerProfile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24 * scale),
                child: Image.network(
                  profile.avatarUrl,
                  width: 72 * scale,
                  height: 72 * scale,
                  fit: BoxFit.cover,
                ),
              ),
              if (profile.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20 * scale,
                    height: 20 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(999 * scale),
                      border: Border.all(color: Colors.white, width: 3 * scale),
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
                  profile.name,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  '@${profile.name.toLowerCase().replaceAll(' ', '_')}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 13 * scale,
                  ),
                ),
                SizedBox(height: 12 * scale),
                Row(
                  children: [
                    _MiniInfoChip(
                      scale: scale,
                      icon: Icons.star_rounded,
                      label: '${profile.matchesCount} matchs',
                      color: const Color(0xFFFFB800),
                    ),
                    SizedBox(width: 8 * scale),
                    _MiniInfoChip(
                      scale: scale,
                      icon: Icons.location_on_outlined,
                      label: profile.distance,
                      color: const Color(0xFF0EA5E9),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.scale, required this.label});

  final double scale;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        color: const Color(0xFF0B1220),
        fontSize: 16 * scale,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _PillChip extends StatelessWidget {
  const _PillChip({
    required this.scale,
    required this.icon,
    required this.label,
    required this.color,
  });

  final double scale;
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999 * scale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16 * scale, color: color),
          SizedBox(width: 8 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 13 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.scale, required this.stats});

  final double scale;
  final List<ProfileStatistic> stats;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 320;
        return Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: stats
              .map(
                (stat) => SizedBox(
                  width: isWide ? (constraints.maxWidth - 12 * scale) / 2 : constraints.maxWidth,
                  child: Container(
                    padding: EdgeInsets.all(16 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16 * scale),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stat.value,
                          style: GoogleFonts.poppins(
                            color: stat.accent,
                            fontSize: 22 * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6 * scale),
                        Text(
                          stat.label,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontSize: 13 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.scale, required this.activity});

  final double scale;
  final ActivityFeedItem activity;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: activity.iconColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            child: Icon(activity.icon, color: activity.iconColor, size: 22 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.message,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 14 * scale,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  activity.timeAgo,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 12 * scale,
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

class _PrimaryActions extends StatelessWidget {
  const _PrimaryActions({required this.scale, required this.controller});

  final double scale;
  final FindPartnerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.followProfile,
            icon: Icon(Icons.favorite_border_rounded, size: 18 * scale, color: Colors.white),
            label: Text(
              'Suivre',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(vertical: 14 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
              elevation: 0,
            ),
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: controller.sendProfileMessage,
            icon: Icon(Icons.chat_bubble_outline_rounded, size: 18 * scale, color: const Color(0xFF0B1220)),
            label: Text(
              'Message',
              style: GoogleFonts.inter(
                color: const Color(0xFF0B1220),
                fontSize: 15 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
              side: BorderSide(color: const Color(0xFFE2E8F0), width: 1.2 * scale),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid({required this.scale, required this.actions});

  final double scale;
  final List<_QuickActionData> actions;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12 * scale,
      runSpacing: 12 * scale,
      children: actions
          .map(
            (action) => SizedBox(
              width: 160 * scale,
              child: InkWell(
                borderRadius: BorderRadius.circular(18 * scale),
                onTap: action.onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12 * scale,
                        offset: Offset(0, 6 * scale),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40 * scale,
                        height: 40 * scale,
                        decoration: BoxDecoration(
                          color: action.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                        child: Icon(action.icon, color: action.color, size: 22 * scale),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Text(
                          action.label,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0B1220),
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _DangerZone extends StatelessWidget {
  const _DangerZone({required this.scale, required this.controller});

  final double scale;
  final FindPartnerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFEF4444).withValues(alpha: 0.12),
            const Color(0xFFB91C1C).withValues(alpha: 0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36 * scale,
                height: 36 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Icon(Icons.warning_rounded, color: const Color(0xFFB91C1C), size: 20 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zone sensible',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFB91C1C),
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      'Utilisez ces actions si le comportement de l\'utilisateur ne respecte pas les règles.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF7F1D1D),
                        fontSize: 12.5 * scale,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.blockProfile,
              icon: Icon(Icons.block_rounded, size: 18 * scale, color: Colors.white),
              label: Text(
                'Bloquer l\'utilisateur',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.5 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          Center(
            child: TextButton(
              onPressed: controller.reportProfile,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFB91C1C),
                padding: EdgeInsets.symmetric(vertical: 10 * scale, horizontal: 16 * scale),
              ),
              child: Text(
                'Signaler ce profil',
                style: GoogleFonts.inter(
                  color: const Color(0xFFB91C1C),
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({
    required this.scale,
    required this.feedback,
    required this.onClose,
  });

  final double scale;
  final UserActionFeedback feedback;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: feedback.background,
        borderRadius: BorderRadius.circular(18 * scale),
        boxShadow: [
          BoxShadow(
            color: feedback.background.withValues(alpha: 0.2),
            blurRadius: 16 * scale,
            offset: Offset(0, 8 * scale),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36 * scale,
            height: 36 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            child: Icon(feedback.icon, color: Colors.white, size: 20 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedback.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  feedback.message,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13 * scale,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          GestureDetector(
            onTap: onClose,
            child: Icon(Icons.close_rounded, color: Colors.white.withValues(alpha: 0.9), size: 20 * scale),
          ),
        ],
      ),
    );
  }
}

class _MiniInfoChip extends StatelessWidget {
  const _MiniInfoChip({
    required this.scale,
    required this.icon,
    required this.label,
    required this.color,
  });

  final double scale;
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999 * scale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14 * scale, color: color),
          SizedBox(width: 6 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 12 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
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
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, size: 20 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

class _QuickActionData {
  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  static List<_QuickActionData> build(FindPartnerController controller) {
    return [
      _QuickActionData(
        icon: Icons.event_available_rounded,
        label: 'Inviter',
        color: const Color(0xFF176BFF),
        onTap: controller.inviteToActivity,
      ),
      _QuickActionData(
        icon: Icons.person_add_alt_1_rounded,
        label: 'Ajouter ami',
        color: const Color(0xFF16A34A),
        onTap: controller.sendFriendRequest,
      ),
      _QuickActionData(
        icon: Icons.ios_share_rounded,
        label: 'Partager',
        color: const Color(0xFFFFB800),
        onTap: controller.shareProfile,
      ),
      _QuickActionData(
        icon: Icons.calendar_month_rounded,
        label: 'Planifier',
        color: const Color(0xFF0EA5E9),
        onTap: controller.onCreateEventTap,
      ),
    ];
  }
}
