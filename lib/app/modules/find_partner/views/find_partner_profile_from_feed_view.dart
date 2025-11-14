import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/find_partner_controller.dart';

class FindPartnerProfileFromFeedView extends GetView<FindPartnerController> {
  const FindPartnerProfileFromFeedView({super.key});

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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 12 * scale),
                        _ProfileHeroSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _MutualFriendsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _SportsPracticedSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _RecentStatusCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _AchievementsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _StatisticsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _AnnouncementsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _ReviewsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _AvailabilitySection(scale: scale),
                        SizedBox(height: 24 * scale),
                        _MessageButton(scale: scale),
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
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, size: 18 * scale, color: const Color(0xFF0B1220)),
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
              _RoundIconButton(
                scale: scale,
                icon: Icons.share_outlined,
                onTap: () => Get.snackbar('Partager', 'Fonctionnalité prochaine.'),
              ),
              SizedBox(width: 8 * scale),
              _RoundIconButton(
                scale: scale,
                icon: Icons.more_horiz_rounded,
                onTap: () => Get.snackbar('Options', 'Menu à venir.'),
              ),
            ],
          ),
        ],
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
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 20 * scale,
              offset: Offset(0, 12 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 80 * scale,
                      height: 80 * scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF176BFF), width: 4 * scale),
                      ),
                      padding: EdgeInsets.all(4 * scale),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profile.avatarUrl),
                      ),
                    ),
                    Positioned(
                      bottom: -12 * scale,
                      left: 8 * scale,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFB800), Color(0xFFFF8C00)],
                          ),
                          borderRadius: BorderRadius.circular(999 * scale),
                        ),
                        child: Text(
                          profile.levelLabel,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12 * scale,
                            fontWeight: FontWeight.w600,
                          ),
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
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6 * scale),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14 * scale, color: const Color(0xFF94A3B8)),
                          SizedBox(width: 4 * scale),
                          Text(
                            '${profile.distance} • ${profile.city}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 14 * scale,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4 * scale),
                      Row(
                        children: [
                          Icon(Icons.cake_outlined, size: 14 * scale, color: const Color(0xFF94A3B8)),
                          SizedBox(width: 4 * scale),
                          Text(
                            '${profile.age} ans',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 14 * scale,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12 * scale),
                      Row(
                        children: [
                          _ProfileStatPill(
                            scale: scale,
                            value: profile.friendsCount.toString(),
                            label: 'Amis',
                          ),
                          SizedBox(width: 12 * scale),
                          _ProfileStatPill(
                            scale: scale,
                            value: profile.mutualFriendsCount.toString(),
                            label: 'En commun',
                            highlightColor: const Color(0xFF176BFF),
                          ),
                          SizedBox(width: 12 * scale),
                          _ProfileStatPill(
                            scale: scale,
                            value: profile.matchesCount.toString(),
                            label: 'Matchs',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32 * scale),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => ElevatedButton.icon(
                      onPressed: controller.toggleRequest,
                      icon: Icon(
                        controller.hasSentRequest.value ? Icons.check_rounded : Icons.person_add_alt_rounded,
                        size: 18 * scale,
                      ),
                      label: Text(
                        controller.hasSentRequest.value ? 'Demande envoyée' : 'Demander en ami',
                        style: GoogleFonts.inter(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14 * scale),
                        backgroundColor: const Color(0xFF176BFF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12 * scale),
                _RoundIconButton(
                  scale: scale,
                  icon: Icons.message_outlined,
                  onTap: controller.sendProfileMessage,
                ),
              ],
            ),
          ],
        ),
      ),
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Amis en commun',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.viewAllMutualFriends,
                  child: Text(
                    'Voir tout',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16 * scale),
            Row(
              children: [
                SizedBox(
                  width: (friends.length + 1) * 32 * scale,
                  height: 40 * scale,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < friends.length; i++)
                        Positioned(
                          left: i * 24 * scale,
                          child: CircleAvatar(
                            radius: 20 * scale,
                            backgroundImage: NetworkImage(friends[i].avatarUrl),
                          ),
                        ),
                      Positioned(
                        left: friends.length * 24 * scale,
                        child: Container(
                          width: 40 * scale,
                          height: 40 * scale,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(999 * scale),
                            border: Border.all(color: Colors.white, width: 2 * scale),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '+${controller.mutualFriendsOverflow}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12 * scale),
            Text(
              '${friends.first.name}, ${friends[1].name}, ${friends[2].name} et ${controller.mutualFriendsOverflow} autres amis en commun',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SportsPracticedSection extends GetView<FindPartnerController> {
  const _SportsPracticedSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final sports = controller.sportExperiences;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sports pratiqués',
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
                    color: const Color(0x3316A34A),
                    borderRadius: BorderRadius.circular(999 * scale),
                  ),
                  child: Text(
                    '${sports.length} sports',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF16A34A),
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16 * scale),
            Column(
              children: sports
                  .map(
                    (sport) => Padding(
                      padding: EdgeInsets.only(bottom: sport == sports.last ? 0 : 12 * scale),
                      child: Container(
                        padding: EdgeInsets.all(16 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48 * scale,
                              height: 48 * scale,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: sport.iconGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12 * scale),
                              ),
                              child: Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 22 * scale),
                            ),
                            SizedBox(width: 12 * scale),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sport.name,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF0B1220),
                                      fontSize: 16 * scale,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4 * scale),
                                  Text(
                                    sport.level,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF475569),
                                      fontSize: 14 * scale,
                                    ),
                                  ),
                                  if (sport.tenureLines != null) ...[
                                    SizedBox(height: 4 * scale),
                                    Text(
                                      sport.tenureLines!.join(' '),
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF475569),
                                        fontSize: 13 * scale,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (sport.highlightBadge != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                                decoration: BoxDecoration(
                                  color: sport.highlightBadge!.background,
                                  borderRadius: BorderRadius.circular(999 * scale),
                                ),
                                child: Text(
                                  sport.highlightBadge!.label,
                                  style: GoogleFonts.inter(
                                    color: sport.highlightBadge!.textColor,
                                    fontSize: 12 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
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

class _RecentStatusCard extends GetView<FindPartnerController> {
  const _RecentStatusCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final presence = controller.profilePresence;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
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
            SizedBox(height: 12 * scale),
            Row(
              children: [
                Container(
                  width: 8 * scale,
                  height: 8 * scale,
                  decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle),
                ),
                SizedBox(width: 8 * scale),
                Expanded(
                  child: Text(
                    presence.statusLabel,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 14 * scale,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8 * scale),
            Text(
              '${presence.responseLabel}\n${presence.responseValue}',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                height: 1.4,
              ),
            ),
            SizedBox(height: 8 * scale),
            Text(
              'Dernière activité : ${presence.lastActivity}',
              style: GoogleFonts.inter(
                color: const Color(0xFF0B1220),
                fontSize: 13 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementsSection extends GetView<FindPartnerController> {
  const _AchievementsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final achievements = controller.achievements;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Badges & Réalisations',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${achievements.length} badges',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFFB800),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16 * scale),
            Row(
              children: achievements
                  .map(
                    (achievement) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6 * scale),
                        child: Container(
                          height: 96 * scale,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12 * scale),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12 * scale, horizontal: 8 * scale),
                          child: Column(
                            children: [
                              Container(
                                width: 48 * scale,
                                height: 48 * scale,
                                decoration: BoxDecoration(
                                  color: achievement.backgroundColor,
                                  borderRadius: BorderRadius.circular(12 * scale),
                                ),
                                child: Icon(Icons.emoji_events_rounded, color: achievement.iconColor, size: 24 * scale),
                              ),
                              SizedBox(height: 8 * scale),
                              Text(
                                achievement.title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 12 * scale,
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

class _StatisticsSection extends GetView<FindPartnerController> {
  const _StatisticsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = controller.profileStatistics;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistiques',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            Wrap(
              spacing: 12 * scale,
              runSpacing: 12 * scale,
              children: stats
                  .map(
                    (stat) => SizedBox(
                      width: (MediaQuery.of(context).size.width - 16 * scale * 2 - 12 * scale) / 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        child: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}

class _AnnouncementsSection extends GetView<FindPartnerController> {
  const _AnnouncementsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final announcements = controller.profileAnnouncements;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Annonces sportives',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.snackbar('Annonces', 'Affichage complet prochainement.'),
                  child: Text(
                    'Voir tout',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF176BFF),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16 * scale),
            Column(
              children: announcements
                  .map(
                    (announcement) => Padding(
                      padding: EdgeInsets.only(bottom: announcement == announcements.last ? 0 : 12 * scale),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12 * scale),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        padding: EdgeInsets.all(16 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48 * scale,
                                  height: 48 * scale,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                                    ),
                                    borderRadius: BorderRadius.circular(12 * scale),
                                  ),
                                  child: Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 24 * scale),
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
                                              announcement.message.split('!').first,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFF0B1220),
                                                fontSize: 16 * scale,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 8 * scale),
                                          Text(
                                            announcement.timeAgo,
                                            style: GoogleFonts.inter(
                                              color: const Color(0xFF475569),
                                              fontSize: 12 * scale,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6 * scale),
                                      Text(
                                        announcement.message,
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF475569),
                                          fontSize: 13 * scale,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12 * scale),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 14 * scale, color: const Color(0xFF94A3B8)),
                                SizedBox(width: 4 * scale),
                                Text(
                                  announcement.distanceLabel,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF475569),
                                    fontSize: 12 * scale,
                                  ),
                                ),
                                SizedBox(width: 12 * scale),
                                Icon(Icons.calendar_month_rounded, size: 14 * scale, color: const Color(0xFF94A3B8)),
                                SizedBox(width: 4 * scale),
                                Text(
                                  announcement.dateLabel,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF475569),
                                    fontSize: 12 * scale,
                                  ),
                                ),
                                SizedBox(width: 12 * scale),
                                Icon(Icons.access_time_rounded, size: 14 * scale, color: const Color(0xFF94A3B8)),
                                SizedBox(width: 4 * scale),
                                Text(
                                  announcement.timeLabel,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF475569),
                                    fontSize: 12 * scale,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12 * scale),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF176BFF),
                                    borderRadius: BorderRadius.circular(10 * scale),
                                  ),
                                  child: Text(
                                    announcement.actionLabel,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 12 * scale,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8 * scale),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(10 * scale),
                                  ),
                                  child: Text(
                                    announcement.priceLabel,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF475569),
                                      fontSize: 12 * scale,
                                    ),
                                  ),
                                ),
                              ],
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

class _ReviewsSection extends GetView<FindPartnerController> {
  const _ReviewsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final reviews = controller.profileReviews;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Avis de la communauté',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${controller.profileReviewCount} avis',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16 * scale),
            Column(
              children: reviews
                  .map(
                    (review) => Padding(
                      padding: EdgeInsets.only(bottom: review == reviews.last ? 0 : 12 * scale),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18 * scale,
                            backgroundImage: NetworkImage(review.avatarUrl),
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
                                        review.author,
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF0B1220),
                                          fontSize: 14 * scale,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                                    SizedBox(width: 4 * scale),
                                    Text(
                                      review.rating.toStringAsFixed(1),
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF0B1220),
                                        fontSize: 13 * scale,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4 * scale),
                                Text(
                                  review.message,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF475569),
                                    fontSize: 13 * scale,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: 4 * scale),
                                Text(
                                  review.timeAgo,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF94A3B8),
                                    fontSize: 12 * scale,
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
            SizedBox(height: 12 * scale),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: controller.viewAllReviews,
                child: Text(
                  'Voir tous les avis',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
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

class _AvailabilitySection extends GetView<FindPartnerController> {
  const _AvailabilitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final days = controller.profileAvailability;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x14176BFF),
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disponibilités cette semaine',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days
                  .map(
                    (day) => Column(
                      children: [
                        Text(
                          day.day,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF475569),
                            fontSize: 12 * scale,
                          ),
                        ),
                        SizedBox(height: 8 * scale),
                        Container(
                          width: 32 * scale,
                          height: 32 * scale,
                          decoration: BoxDecoration(
                            color: day.isAvailable ? const Color(0x3316A34A) : const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(8 * scale),
                            border: Border.all(
                              color: day.isAvailable ? const Color(0xFF16A34A) : const Color(0xFFE2E8F0),
                              width: 1 * scale,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day.date,
                            style: GoogleFonts.inter(
                              color: day.isAvailable ? const Color(0xFF16A34A) : const Color(0xFF475569),
                              fontSize: 12 * scale,
                              fontWeight: day.isAvailable ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16 * scale),
            Row(
              children: [
                Container(
                  width: 12 * scale,
                  height: 12 * scale,
                  decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle),
                ),
                SizedBox(width: 8 * scale),
                Text(
                  'Disponible',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                  ),
                ),
                SizedBox(width: 16 * scale),
                Container(
                  width: 12 * scale,
                  height: 12 * scale,
                  decoration: const BoxDecoration(color: Color(0xFFE2E8F0), shape: BoxShape.circle),
                ),
                SizedBox(width: 8 * scale),
                Text(
                  'Occupé',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
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

class _MessageButton extends GetView<FindPartnerController> {
  const _MessageButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: ElevatedButton.icon(
        onPressed: controller.sendProfileMessage,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF176BFF),
          padding: EdgeInsets.symmetric(vertical: 16 * scale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
        ),
        icon: Icon(Icons.chat_bubble_outline_rounded, size: 18 * scale),
        label: Text(
          'Envoyer un message',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ProfileStatPill extends StatelessWidget {
  const _ProfileStatPill({
    required this.scale,
    required this.value,
    required this.label,
    this.highlightColor,
  });

  final double scale;
  final String value;
  final String label;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final color = highlightColor ?? const Color(0xFF0B1220);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: highlightColor != null ? highlightColor!.withValues(alpha: 0.12) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(999 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 16 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2 * scale),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 12 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
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
        width: 48 * scale,
        height: 48 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, color: const Color(0xFF475569), size: 20 * scale),
      ),
    );
  }
}

