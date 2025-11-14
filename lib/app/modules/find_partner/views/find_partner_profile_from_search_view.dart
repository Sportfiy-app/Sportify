import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/find_partner_controller.dart';

class FindPartnerProfileFromSearchView extends GetView<FindPartnerController> {
  const FindPartnerProfileFromSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.12);

          return SafeArea(
            child: Column(
              children: [
                _GradientHero(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _CompatibilityCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _SocialQuickStats(scale: scale),
                        SizedBox(height: 16 * scale),
                        _SportsCards(scale: scale),
                        SizedBox(height: 16 * scale),
                        _AvailabilityCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _StatisticsGrid(scale: scale),
                        SizedBox(height: 16 * scale),
                        _AnnouncementsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _ReviewsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _BadgesSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _ContactPreferences(scale: scale),
                        SizedBox(height: 16 * scale),
                        _FooterActions(scale: scale),
                        SizedBox(height: 16 * scale),
                        Obx(
                          () => controller.hasSentRequest.value
                              ? _FriendRequestBanner(scale: scale)
                              : const SizedBox.shrink(),
                        ),
                        SizedBox(height: 24 * scale),
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

class _GradientHero extends GetView<FindPartnerController> {
  const _GradientHero({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          begin: Alignment(0.35, 0.35),
          end: Alignment(1.06, -0.35),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale),
      child: Column(
        children: [
          Row(
            children: [
              _HeroCircleButton(
                scale: scale,
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: Get.back,
              ),
              const Spacer(),
              _HeroCircleButton(
                scale: scale,
                icon: Icons.share_outlined,
                onTap: () => Get.snackbar('Partager', 'Lien de profil partagé prochainement'),
              ),
              SizedBox(width: 12 * scale),
              _HeroCircleButton(
                scale: scale,
                icon: Icons.more_horiz_rounded,
                onTap: () => Get.snackbar('Options', 'Options supplémentaires disponibles bientôt'),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 128 * scale,
                height: 128 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 40 * scale,
                      offset: Offset(0, 20 * scale),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profile.avatarUrl),
                ),
              ),
              Positioned(
                bottom: -10 * scale,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB800),
                    borderRadius: BorderRadius.circular(999 * scale),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 12 * scale,
                        offset: Offset(0, 6 * scale),
                      ),
                    ],
                  ),
                  child: Text(
                    profile.levelLabel,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 90 * scale,
                bottom: 8 * scale,
                child: Container(
                  width: 24 * scale,
                  height: 24 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFF16A34A),
                    borderRadius: BorderRadius.circular(999 * scale),
                    border: Border.all(color: Colors.white, width: 2 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.circle, size: 8 * scale, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 28 * scale),
          Text(
            profile.name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            '${profile.distance} • ${profile.city} • ${profile.age} ans',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14 * scale,
            ),
          ),
          SizedBox(height: 6 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flash_on_rounded, size: 16 * scale, color: Colors.white.withValues(alpha: 0.7)),
              SizedBox(width: 6 * scale),
              Text(
                'Active il y a 2h',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13 * scale,
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => ElevatedButton.icon(
                    onPressed: controller.toggleRequest,
                    icon: Icon(
                      controller.hasSentRequest.value ? Icons.check_rounded : Icons.person_add_alt_1_rounded,
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
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF176BFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12 * scale),
              ElevatedButton.icon(
                onPressed: controller.sendProfileMessage,
                icon: Icon(Icons.chat_bubble_outline_rounded, size: 18 * scale),
                label: Text(
                  'Message',
                  style: GoogleFonts.inter(fontSize: 16 * scale, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 14 * scale),
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
        ],
      ),
    );
  }
}

class _CompatibilityCard extends GetView<FindPartnerController> {
  const _CompatibilityCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final compatibility = controller.profileCompatibility;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
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
                  'Compatibilité sportive',
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
                  color: const Color(0x1916A34A),
                  borderRadius: BorderRadius.circular(999 * scale),
                ),
                child: Text(
                  '${compatibility.percentage}%',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF16A34A),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          ClipRRect(
            borderRadius: BorderRadius.circular(999 * scale),
            child: SizedBox(
              height: 12 * scale,
              child: Stack(
                children: [
                  Container(color: const Color(0xFFE2E8F0)),
                  FractionallySizedBox(
                    widthFactor: (compatibility.percentage / 100).clamp(0.0, 1.0),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF16A34A), Color(0xFFFFB800), Color(0xFFEF4444)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 8 * scale,
            children: [
              _CompatibilityChip(
                scale: scale,
                icon: Icons.sports_soccer_rounded,
                label: 'Sports en commun: ${compatibility.sportsInCommon}',
              ),
              _CompatibilityChip(
                scale: scale,
                icon: Icons.workspace_premium_outlined,
                label: compatibility.levelsMatch ? 'Niveaux compatibles' : 'Niveaux différents',
              ),
              _CompatibilityChip(
                scale: scale,
                icon: Icons.pin_drop_outlined,
                label: compatibility.proximity,
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: compatibility.experienceSummary
                .map(
                  (line) => Padding(
                    padding: EdgeInsets.only(bottom: 4 * scale),
                    child: Text(
                      line,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 13 * scale,
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

class _SocialQuickStats extends GetView<FindPartnerController> {
  const _SocialQuickStats({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile;
    final mutual = controller.mutualFriends;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Réseau social',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: [
              _StatTile(
                scale: scale,
                icon: Icons.people_alt_outlined,
                iconBackground: const Color(0x19176BFF),
                label: '${profile.friendsCount} amis',
                highlight: '${profile.mutualFriendsCount} en commun',
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: SizedBox(
                  height: 40 * scale,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < mutual.length && i < 3; i++)
                        Positioned(
                          left: i * 24 * scale,
                          child: CircleAvatar(
                            radius: 20 * scale,
                            backgroundImage: NetworkImage(mutual[i].avatarUrl),
                          ),
                        ),
                      Positioned(
                        left: 3 * 24 * scale,
                        child: Container(
                          width: 40 * scale,
                          height: 40 * scale,
                          decoration: BoxDecoration(
                            color: const Color(0xFF176BFF),
                            borderRadius: BorderRadius.circular(999 * scale),
                            border: Border.all(color: Colors.white, width: 2 * scale),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '+${controller.mutualFriendsOverflow}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
  }
}

class _SportsCards extends GetView<FindPartnerController> {
  const _SportsCards({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final sports = controller.sportExperiences;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
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
                  'Sports pratiqués',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: const Color(0x19FFB800),
                  borderRadius: BorderRadius.circular(999 * scale),
                ),
                child: Text(
                  '${sports.length} sports',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFB800),
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w700,
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
                    child: _GradientSportCard(scale: scale, sport: sport),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _AvailabilityCard extends GetView<FindPartnerController> {
  const _AvailabilityCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final days = controller.profileAvailability;
    final summary = controller.profileAvailabilitySummary;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
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
                  'Disponibilités',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: const Color(0x1916A34A),
                  borderRadius: BorderRadius.circular(999 * scale),
                ),
                child: Text(
                  summary.headline,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF16A34A),
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
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
                          color: day.isAvailable ? const Color(0xFF16A34A) : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(999 * scale),
                          border: Border.all(
                            color: day.isAvailable ? const Color(0xFF16A34A) : const Color(0xFFE2E8F0),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          day.date,
                          style: GoogleFonts.inter(
                            color: day.isAvailable ? Colors.white : const Color(0xFF475569),
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
          SizedBox(height: 12 * scale),
          Row(
            children: [
              Container(
                width: 12 * scale,
                height: 12 * scale,
                decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle),
              ),
              SizedBox(width: 6 * scale),
              Text(
                'Disponible',
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
              ),
              SizedBox(width: 16 * scale),
              Container(
                width: 12 * scale,
                height: 12 * scale,
                decoration: const BoxDecoration(color: Color(0xFFE2E8F0), shape: BoxShape.circle),
              ),
              SizedBox(width: 6 * scale),
              Text(
                'Occupé',
                style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
              ),
              const Spacer(),
              Text(
                summary.preferredTime,
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatisticsGrid extends GetView<FindPartnerController> {
  const _StatisticsGrid({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = controller.profileStatistics;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistiques',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stats.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.4,
            ),
            itemBuilder: (context, index) {
              final stat = stats[index];
              return Container(
                decoration: BoxDecoration(
                  color: stat.accent.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: stat.accent.withValues(alpha: 0.1)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 10 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stat.value,
                      style: GoogleFonts.poppins(
                        color: stat.accent,
                        fontSize: 20 * scale,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      stat.label,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 13 * scale,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
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
                  'Annonces récentes',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${announcements.length} annonces',
                style: GoogleFonts.inter(
                  color: const Color(0xFF475569),
                  fontSize: 12 * scale,
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
                    child: _AnnouncementTile(scale: scale, announcement: announcement),
                  ),
                )
                .toList(),
          ),
        ],
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
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
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
                  'Avis et témoignages',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                  SizedBox(width: 4 * scale),
                  Text(
                    '${controller.profileRating.toStringAsFixed(1)} (${controller.profileReviewCount} avis)',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 12 * scale,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: reviews
                .map(
                  (review) => Padding(
                    padding: EdgeInsets.only(bottom: review == reviews.last ? 0 : 12 * scale),
                    child: _ReviewTile(scale: scale, review: review),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _BadgesSection extends GetView<FindPartnerController> {
  const _BadgesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final achievements = controller.achievements;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Badges & Réalisations',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: achievements
                .map(
                  (achievement) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6 * scale),
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
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w500,
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
    );
  }
}

class _ContactPreferences extends GetView<FindPartnerController> {
  const _ContactPreferences({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final preferences = controller.profileContactPreferences;
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Préférences de contact',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 16 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: preferences
                .map(
                  (preference) => Padding(
                    padding: EdgeInsets.only(bottom: preference == preferences.last ? 0 : 12 * scale),
                    child: _ContactPreferenceTile(scale: scale, preference: preference),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _FooterActions extends GetView<FindPartnerController> {
  const _FooterActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60 * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16 * scale),
            gradient: const LinearGradient(
              colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
              begin: Alignment(0.35, 0.35),
              end: Alignment(1.06, -0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 18 * scale,
                offset: Offset(0, 10 * scale),
              ),
            ],
          ),
          child: TextButton.icon(
            onPressed: controller.toggleRequest,
            icon: Icon(Icons.person_add_alt_1_rounded, color: Colors.white, size: 20 * scale),
            label: Text(
              'Demander en ami',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        Container(
          height: 64 * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFF176BFF), width: 2 * scale),
          ),
          child: TextButton.icon(
            onPressed: controller.sendProfileMessage,
            icon: Icon(Icons.chat_bubble_outline_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
            label: Text(
              'Envoyer un message',
              style: GoogleFonts.poppins(
                color: const Color(0xFF176BFF),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: controller.reportProfile,
                icon: Icon(Icons.block_rounded, color: const Color(0xFFEF4444), size: 18 * scale),
                label: Text(
                  'Bloquer',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: const Color(0xFFEF4444), width: 1.5 * scale),
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                ),
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: controller.reportProfile,
                icon: Icon(Icons.flag_outlined, color: const Color(0xFFF59E0B), size: 18 * scale),
                label: Text(
                  'Signaler',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF59E0B),
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: const Color(0xFFF59E0B), width: 1.5 * scale),
                  padding: EdgeInsets.symmetric(vertical: 14 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FriendRequestBanner extends StatelessWidget {
  const _FriendRequestBanner({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF16A34A),
        borderRadius: BorderRadius.circular(16 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 30 * scale,
            offset: Offset(0, 16 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        children: [
          Container(
            width: 32 * scale,
            height: 32 * scale,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(999 * scale),
            ),
            child: Icon(Icons.check_rounded, color: Colors.white, size: 18 * scale),
          ),
          SizedBox(width: 12 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Demande d’ami envoyée !',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Anita recevra une notification',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12 * scale,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroCircleButton extends StatelessWidget {
  const _HeroCircleButton({
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
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(999 * scale),
        ),
        child: Icon(icon, color: Colors.white, size: 18 * scale),
      ),
    );
  }
}

class _CompatibilityChip extends StatelessWidget {
  const _CompatibilityChip({
    required this.scale,
    required this.icon,
    required this.label,
  });

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
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
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.scale,
    required this.icon,
    required this.iconBackground,
    required this.label,
    this.highlight,
  });

  final double scale;
  final IconData icon;
  final Color iconBackground;
  final String label;
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36 * scale,
              height: 36 * scale,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Icon(icon, color: iconBackground.withValues(alpha: 0.9), size: 18 * scale),
            ),
            SizedBox(height: 8 * scale),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (highlight != null) ...[
              SizedBox(height: 4 * scale),
              Text(
                highlight!,
                style: GoogleFonts.inter(
                  color: const Color(0xFF176BFF),
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GradientSportCard extends StatelessWidget {
  const _GradientSportCard({required this.scale, required this.sport});

  final double scale;
  final SportExperience sport;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        gradient: LinearGradient(colors: sport.iconGradient, begin: Alignment.centerLeft, end: Alignment.centerRight),
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
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 24 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sport.name,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      sport.level,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 13 * scale,
                      ),
                    ),
                  ],
                ),
              ),
              if (sport.highlightBadge != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(999 * scale),
                  ),
                  child: Text(
                    sport.highlightBadge!.label,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
          if (sport.tenureLines != null) ...[
            SizedBox(height: 12 * scale),
            Text(
              sport.tenureLines!.join(' '),
              style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 12 * scale),
            ),
          ],
        ],
      ),
    );
  }
}

class _AnnouncementTile extends GetView<FindPartnerController> {
  const _AnnouncementTile({required this.scale, required this.announcement});

  final double scale;
  final ProfileAnnouncement announcement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 20 * scale, backgroundImage: NetworkImage(announcement.avatarUrl)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            announcement.statsLabel,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF0B1220),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
          Wrap(
            spacing: 12 * scale,
            runSpacing: 8 * scale,
            children: [
              _AnnouncementChip(
                scale: scale,
                icon: Icons.location_on_outlined,
                label: announcement.distanceLabel,
              ),
              _AnnouncementChip(
                scale: scale,
                icon: Icons.calendar_month_outlined,
                label: announcement.dateLabel,
              ),
              _AnnouncementChip(
                scale: scale,
                icon: Icons.access_time_rounded,
                label: announcement.timeLabel,
              ),
              _AnnouncementChip(
                scale: scale,
                icon: Icons.people_alt_outlined,
                label: announcement.interestedLabel,
              ),
              _AnnouncementChip(
                scale: scale,
                icon: Icons.euro_outlined,
                label: announcement.priceLabel,
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: [
              FilledButton(
                onPressed: controller.joinAnnouncement,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF176BFF),
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 10 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scale)),
                ),
                child: Text(
                  announcement.actionLabel,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12 * scale),
              OutlinedButton(
                onPressed: () => Get.snackbar('Annonce', 'Ajoutée à vos favoris'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 10 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10 * scale)),
                  side: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale),
                ),
                child: Text(
                  'Enregistrer',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnnouncementChip extends StatelessWidget {
  const _AnnouncementChip({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(999 * scale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14 * scale, color: const Color(0xFF475569)),
          SizedBox(width: 6 * scale),
          Text(
            label,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
          ),
        ],
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
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border(
          left: BorderSide(color: const Color(0xFF16A34A), width: 4 * scale),
          top: const BorderSide(color: Color(0xFFE2E8F0)),
          right: const BorderSide(color: Color(0xFFE2E8F0)),
          bottom: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20 * scale, backgroundImage: NetworkImage(review.avatarUrl)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            review.rating.round(),
                            (index) => Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 14 * scale),
                          ),
                        ),
                        SizedBox(width: 6 * scale),
                        Text(
                          review.timeAgo,
                          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8 * scale),
          Text(
            review.message,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _ContactPreferenceTile extends StatelessWidget {
  const _ContactPreferenceTile({required this.scale, required this.preference});

  final double scale;
  final ProfileContactPreference preference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: preference.background,
              borderRadius: BorderRadius.circular(999 * scale),
            ),
            child: Icon(preference.icon, color: preference.statusColor, size: 18 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  preference.title,
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  preference.subtitle,
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
            decoration: BoxDecoration(
              color: preference.statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999 * scale),
            ),
            child: Text(
              preference.statusLabel,
              style: GoogleFonts.poppins(color: preference.statusColor, fontSize: 12 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

