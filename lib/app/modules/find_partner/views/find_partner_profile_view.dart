import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/find_partner_controller.dart';
import 'user_actions_sheet.dart';

class FindPartnerProfileView extends GetView<FindPartnerController> {
  const FindPartnerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.85, 1.1);

          return SafeArea(
            child: Column(
              children: [
                _ProfileAppBar(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 24 * scale),
                    child: Column(
                      children: [
                        SizedBox(height: 16 * scale),
                        _ProfileHeroSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _MutualFriendsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _SportsPracticedCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _AchievementsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _ActiveAnnouncementsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _ReviewsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _StatisticsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _RecentActivityCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _ActionButtonsCard(scale: scale),
                      ],
                    ),
                  ),
                ),
                _ProfileBottomNav(scale: scale),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileAppBar extends GetView<FindPartnerController> {
  const _ProfileAppBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18 * scale,
                color: const Color(0xFF0B1220),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Profil',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Row(
            children: [
              _HeaderIconButton(
                scale: scale,
                icon: Icons.share_outlined,
                onTap: controller.openSearch,
              ),
              SizedBox(width: 8 * scale),
              _HeaderIconButton(
                scale: scale,
                icon: Icons.more_horiz_rounded,
                onTap: UserActionsSheet.show,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.scale,
    required this.icon,
    required this.onTap,
  });

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

class _ProfileHeroSection extends GetView<FindPartnerController> {
  const _ProfileHeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18 * scale,
              offset: Offset(0, 12 * scale),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 128 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: profile.heroGradient,
                  begin: const Alignment(0.35, 0.35),
                  end: const Alignment(1.06, -0.35),
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16 * scale)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.15,
                      child: Image.network(
                        profile.coverImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16 * scale,
                    top: 16 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999 * scale),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.place_rounded, size: 14 * scale, color: Colors.white),
                          SizedBox(width: 4 * scale),
                          Text(
                            profile.distance,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20 * scale, -48 * scale, 20 * scale, 20 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 96 * scale,
                        height: 96 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x26176BFF),
                              blurRadius: 32 * scale,
                              offset: Offset(0, 16 * scale),
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned.fill(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(profile.avatarUrl),
                              ),
                            ),
                            Positioned(
                              right: -2 * scale,
                              bottom: 6 * scale,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF16A34A), Color(0xFF15803D)],
                                  ),
                                  borderRadius: BorderRadius.circular(999 * scale),
                                  border: Border.all(color: Colors.white, width: 2 * scale),
                                ),
                                child: Text(
                                  profile.levelLabel,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                fontSize: 24 * scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6 * scale),
                            Text(
                              '${profile.age} ans • ${profile.city}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 15 * scale,
                              ),
                            ),
                            SizedBox(height: 8 * scale),
                            Row(
                              children: [
                                Container(
                                  width: 12 * scale,
                                  height: 12 * scale,
                                  decoration: BoxDecoration(
                                    color: profile.isOnline ? const Color(0xFF16A34A) : const Color(0xFF94A3B8),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6 * scale),
                                Text(
                                  profile.onlineLabel,
                                  style: GoogleFonts.inter(
                                    color: profile.isOnline ? const Color(0xFF16A34A) : const Color(0xFF475569),
                                    fontSize: 14 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24 * scale),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 14 * scale, horizontal: 12 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                    child: Row(
                      children: [
                        _ProfileCounter(
                          scale: scale,
                          value: profile.friendsCount,
                          label: 'Amis',
                        ),
                        _VerticalDivider(scale: scale),
                        _ProfileCounter(
                          scale: scale,
                          value: profile.mutualFriendsCount,
                          label: 'En commun',
                          highlightColor: const Color(0xFF176BFF),
                        ),
                        _VerticalDivider(scale: scale),
                        _ProfileCounter(
                          scale: scale,
                          value: profile.matchesCount,
                          label: 'Matchs',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * scale),
                  Obx(
                    () {
                      final requested = controller.hasSentRequest.value;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.toggleRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: requested ? const Color(0xFFE2E8F0) : const Color(0xFF176BFF),
                            foregroundColor: requested ? const Color(0xFF475569) : Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 16 * scale),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12 * scale),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                requested ? Icons.hourglass_top_rounded : Icons.person_add_alt_1_rounded,
                                size: 18 * scale,
                              ),
                              SizedBox(width: 8 * scale),
                              Text(
                                requested ? 'Demande envoyée' : 'Demander en ami',
                                style: GoogleFonts.inter(
                                  fontSize: 16 * scale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCounter extends StatelessWidget {
  const _ProfileCounter({
    required this.scale,
    required this.value,
    required this.label,
    this.highlightColor,
  });

  final double scale;
  final int value;
  final String label;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: GoogleFonts.poppins(
              color: highlightColor ?? const Color(0xFF0B1220),
              fontSize: 20 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 13 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36 * scale,
      color: const Color(0xFFE2E8F0),
      margin: EdgeInsets.symmetric(horizontal: 12 * scale),
    );
  }
}

class _MutualFriendsCard extends GetView<FindPartnerController> {
  const _MutualFriendsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final friends = controller.mutualFriends;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amis en commun',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20 * scale),
            SizedBox(
              height: 48 * scale,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 0; i < friends.length; i++)
                    Positioned(
                      left: i * 28 * scale,
                      child: Container(
                        width: 48 * scale,
                        height: 48 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2 * scale),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(friends[i].avatarUrl),
                        ),
                      ),
                    ),
                  Positioned(
                    left: friends.length * 28 * scale,
                    child: Container(
                      width: 48 * scale,
                      height: 48 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2 * scale),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+${controller.mutualFriendsOverflow}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16 * scale),
            Text(
              '${friends[0].name}, ${friends[1].name}, ${friends[2].name} et ${controller.mutualFriendsOverflow} autres amis en commun',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                height: 1.45,
              ),
            ),
            SizedBox(height: 16 * scale),
            TextButton(
              onPressed: controller.viewAllMutualFriends,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: const Color(0xFF176BFF),
              ),
              child: Text(
                'Voir tout',
                style: GoogleFonts.inter(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SportsPracticedCard extends GetView<FindPartnerController> {
  const _SportsPracticedCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sports pratiqués',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20 * scale),
            ...controller.sportExperiences.map(
              (experience) => Padding(
                padding: EdgeInsets.only(bottom: experience == controller.sportExperiences.last ? 0 : 12 * scale),
                child: _SportExperienceTile(scale: scale, experience: experience),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SportExperienceTile extends StatelessWidget {
  const _SportExperienceTile({required this.scale, required this.experience});

  final double scale;
  final SportExperience experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 52 * scale,
            height: 52 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: experience.iconGradient,
                begin: const Alignment(-0.4, -0.6),
                end: const Alignment(0.8, 1.0),
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.sports_handball_rounded, color: Colors.white, size: 24 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.name,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  experience.level,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          if (experience.tenureLines != null)
            Container(
              width: 72 * scale,
              padding: EdgeInsets.symmetric(vertical: 6 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(999 * scale),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: experience.tenureLines!
                    .map(
                      (line) => Text(
                        line,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          if (experience.highlightBadge != null)
            Container(
              margin: EdgeInsets.only(left: 12 * scale),
              padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
              decoration: BoxDecoration(
                color: experience.highlightBadge!.background,
                borderRadius: BorderRadius.circular(999 * scale),
              ),
              child: Text(
                experience.highlightBadge!.label,
                style: GoogleFonts.inter(
                  color: experience.highlightBadge!.textColor,
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AchievementsCard extends GetView<FindPartnerController> {
  const _AchievementsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final achievements = controller.achievements;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Réalisations',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20 * scale),
            Row(
              children: achievements
                  .map(
                    (achievement) => Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: achievement == achievements.last ? 0 : 12 * scale),
                        padding: EdgeInsets.all(16 * scale),
                        decoration: BoxDecoration(
                          color: achievement.backgroundColor,
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: Border.all(color: achievement.iconColor.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 48 * scale,
                              height: 48 * scale,
                              decoration: BoxDecoration(
                                color: achievement.iconColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.emoji_events_rounded, color: Colors.white, size: 24 * scale),
                            ),
                            SizedBox(height: 12 * scale),
                            Text(
                              achievement.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF0B1220),
                                fontSize: 14 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              achievement.subtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 12 * scale,
                              ),
                            ),
                          ],
                        ),
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

class _ActiveAnnouncementsCard extends GetView<FindPartnerController> {
  const _ActiveAnnouncementsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final announcements = controller.profileAnnouncements;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Annonces actives',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0x19176BFF),
                    borderRadius: BorderRadius.circular(999 * scale),
                  ),
                  child: Text(
                    '${announcements.length} actives',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20 * scale),
            ...announcements.map(
              (announcement) => Padding(
                padding: EdgeInsets.only(bottom: announcement == announcements.last ? 0 : 24 * scale),
                child: _ProfileAnnouncementCard(scale: scale, announcement: announcement),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAnnouncementCard extends GetView<FindPartnerController> {
  const _ProfileAnnouncementCard({required this.scale, required this.announcement});

  final double scale;
  final ProfileAnnouncement announcement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24 * scale,
              backgroundImage: NetworkImage(announcement.avatarUrl),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.author,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF0B1220),
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    announcement.timeAgo,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 12 * scale,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12 * scale),
        Text(
          announcement.message,
          style: GoogleFonts.inter(
            color: const Color(0xFF0B1220),
            fontSize: 14 * scale,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16 * scale),
        ClipRRect(
          borderRadius: BorderRadius.circular(12 * scale),
          child: AspectRatio(
            aspectRatio: 327 / 192,
            child: Image.network(
              announcement.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: [
            _InfoPill(scale: scale, icon: Icons.calendar_today_rounded, label: announcement.dateLabel),
            _InfoPill(scale: scale, icon: Icons.schedule_rounded, label: announcement.timeLabel),
            _InfoPill(scale: scale, icon: Icons.people_alt_outlined, label: announcement.slotsLabel),
          ],
        ),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 12 * scale,
          children: [
            _InfoPill(scale: scale, icon: Icons.euro_rounded, label: announcement.priceLabel),
            _InfoPill(scale: scale, icon: Icons.local_fire_department_outlined, label: announcement.interestedLabel),
            _InfoPill(scale: scale, icon: Icons.pin_drop_outlined, label: announcement.distanceLabel),
          ],
        ),
        SizedBox(height: 16 * scale),
        Row(
          children: [
            Expanded(
              child: Text(
                announcement.statsLabel,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 13 * scale,
                ),
              ),
            ),
            SizedBox(width: 12 * scale),
            ElevatedButton(
              onPressed: controller.joinAnnouncement,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10 * scale),
                ),
              ),
              child: Text(
                announcement.actionLabel,
                style: GoogleFonts.inter(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(999 * scale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16 * scale, color: const Color(0xFF475569)),
          SizedBox(width: 6 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 13 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewsCard extends GetView<FindPartnerController> {
  const _ReviewsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Évaluations',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(999 * scale),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star_rounded, size: 16 * scale, color: const Color(0xFFFFB800)),
                      SizedBox(width: 6 * scale),
                      Text(
                        '${controller.profileRating}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4 * scale),
                      Text(
                        '(${controller.profileReviewCount} avis)',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 12 * scale,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20 * scale),
            ...controller.profileReviews.map(
              (review) => Padding(
                padding: EdgeInsets.only(bottom: review == controller.profileReviews.last ? 0 : 16 * scale),
                child: _ReviewTile(scale: scale, review: review),
              ),
            ),
            SizedBox(height: 16 * scale),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: controller.viewAllReviews,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF176BFF),
                ),
                child: Text(
                  'Voir tous les avis (${controller.profileReviewCount})',
                  style: GoogleFonts.inter(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.scale, required this.review});

  final double scale;
  final ProfileReview review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20 * scale,
                backgroundImage: NetworkImage(review.avatarUrl),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0B1220),
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < review.rating ? Icons.star_rounded : Icons.star_outline_rounded,
                          size: 14 * scale,
                          color: const Color(0xFFFFB800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                review.timeAgo,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 12 * scale,
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(
            '"${review.message}"',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatisticsCard extends GetView<FindPartnerController> {
  const _StatisticsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = controller.profileStatistics;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 16 * scale) / 2;
            return Wrap(
              spacing: 16 * scale,
              runSpacing: 16 * scale,
              children: stats
                  .map(
                    (stat) => SizedBox(
                      width: itemWidth,
                      child: Container(
                        padding: EdgeInsets.all(16 * scale),
                        decoration: BoxDecoration(
                          color: stat.accent.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: Border.all(color: stat.accent.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stat.value,
                              style: GoogleFonts.poppins(
                                color: stat.accent,
                                fontSize: 24 * scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 6 * scale),
                            Text(
                              stat.label,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 13 * scale,
                                height: 1.4,
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
        ),
      ),
    );
  }
}

class _RecentActivityCard extends GetView<FindPartnerController> {
  const _RecentActivityCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final activities = controller.recentActivity;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activité récente',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20 * scale),
            ...activities.map(
              (activity) => Padding(
                padding: EdgeInsets.only(bottom: activity == activities.last ? 0 : 12 * scale),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36 * scale,
                      height: 36 * scale,
                      decoration: BoxDecoration(
                        color: activity.iconColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Icon(activity.icon, color: activity.iconColor, size: 20 * scale),
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
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtonsCard extends GetView<FindPartnerController> {
  const _ActionButtonsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => controller.openDirectMessage(controller.profile.name),
                icon: Icon(Icons.chat_bubble_rounded, size: 20 * scale),
                label: Text(
                  'Envoyer un message',
                  style: GoogleFonts.inter(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF176BFF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12 * scale),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.inviteToActivity,
                    icon: Icon(Icons.send_rounded, size: 18 * scale),
                    label: Text(
                      'Inviter',
                      style: GoogleFonts.inter(
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14 * scale),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: controller.reportProfile,
                    icon: Icon(Icons.report_gmailerrorred_rounded, size: 18 * scale, color: const Color(0xFF475569)),
                    label: Text(
                      'Signaler',
                      style: GoogleFonts.inter(
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14 * scale),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                    ),
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

class _ProfileBottomNav extends StatelessWidget {
  const _ProfileBottomNav({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20 * scale,
            offset: Offset(0, -4 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 10 * scale),
      child: Row(
        children: [
          Expanded(
            child: _NavItem(
              icon: Icons.home_filled,
              label: 'Accueil',
              scale: scale,
              onTap: () => Get.snackbar('Accueil', 'Navigation à venir'),
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.search_rounded,
              label: 'Recherche',
              scale: scale,
              isActive: true,
              onTap: () => Get.snackbar('Recherche', 'Vous êtes déjà ici'),
            ),
          ),
          Expanded(
            child: _NavCenterButton(scale: scale),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'Messages',
              scale: scale,
              onTap: () => Get.snackbar('Messages', 'Messagerie prochainement'),
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profil',
              scale: scale,
              onTap: () => Get.snackbar('Profil', 'Profil utilisateur'),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.scale,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final double scale;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF176BFF) : const Color(0xFF475569);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22 * scale),
          SizedBox(height: 6 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 12 * scale,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavCenterButton extends StatelessWidget {
  const _NavCenterButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 56 * scale,
        height: 56 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFF176BFF),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0x19176BFF),
              blurRadius: 20 * scale,
              offset: Offset(0, 10 * scale),
            ),
          ],
        ),
        child: Icon(Icons.add_rounded, color: Colors.white, size: 26 * scale),
      ),
    );
  }
}

