import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/find_partner_controller.dart';

class FindPartnerPrivateRequestView extends GetView<FindPartnerController> {
  const FindPartnerPrivateRequestView({super.key});

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
                _PendingAppBar(scale: scale),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 24 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 12 * scale),
                        _PendingHeroSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingStatusCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingSocialStatsCard(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingSportsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingAnnouncementsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingActivitySection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingMutualFriendsSection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingPrivacySection(scale: scale),
                        SizedBox(height: 16 * scale),
                        _PendingRecommendationsSection(scale: scale),
                        SizedBox(height: 20 * scale),
                        _PendingFooterActions(scale: scale),
                      ],
                    ),
                  ),
                ),
                _PendingBottomNav(scale: scale),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PendingAppBar extends StatelessWidget {
  const _PendingAppBar({required this.scale});

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
              child: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18 * scale, color: const Color(0xFF0B1220)),
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
                onTap: () => Get.snackbar('Partager', 'Fonction à venir'),
              ),
              SizedBox(width: 8 * scale),
              _HeaderIconButton(
                scale: scale,
                icon: Icons.more_horiz_rounded,
                onTap: () => Get.snackbar('Options', 'Paramètres à venir'),
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

class _PendingHeroSection extends GetView<FindPartnerController> {
  const _PendingHeroSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final profile = controller.pendingProfile;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20 * scale,
              offset: Offset(0, 12 * scale),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 168 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(-0.2, 0.3),
                  end: const Alignment(0.6, 1.2),
                  colors: profile.heroGradient,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16 * scale)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.12,
                      child: Image.network(
                        profile.coverImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 24 * scale, top: 24 * scale),
                      child: Container(
                        width: 100 * scale,
                        height: 100 * scale,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: profile.heroGradient,
                            begin: const Alignment(0.2, 0.2),
                            end: const Alignment(1, -0.3),
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 4 * scale),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(profile.avatarUrl),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20 * scale,
                    bottom: 28 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFB800), Color(0xFFFF8C00)],
                        ),
                        borderRadius: BorderRadius.circular(999 * scale),
                        border: Border.all(color: Colors.white, width: 2 * scale),
                      ),
                      child: Text(
                        profile.levelLabel,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 24 * scale),
              child: Column(
                children: [
                  Text(
                    profile.name,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 24 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6 * scale),
                  Text(
                    '${profile.age} ans • ${profile.distance}',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14 * scale,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    profile.city,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14 * scale,
                    ),
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

class _PendingStatusCard extends GetView<FindPartnerController> {
  const _PendingStatusCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Obx(
        () {
          final requestSent = controller.pendingRequestSent.value;
          return Container(
            padding: EdgeInsets.all(20 * scale),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16 * scale),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16 * scale,
                  offset: Offset(0, 8 * scale),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 8 * scale),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: requestSent
                          ? const [Color(0xFFF59E0B), Color(0xFFD97706)]
                          : const [Color(0xFFE2E8F0), Color(0xFFE2E8F0)],
                    ),
                    borderRadius: BorderRadius.circular(999 * scale),
                  ),
                  child: Text(
                    requestSent ? 'Demande en attente' : 'Demande annulée',
                    style: GoogleFonts.inter(
                      color: requestSent ? Colors.white : const Color(0xFF475569),
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 16 * scale),
                Text(
                  requestSent
                      ? 'Vous serez notifié lorsque ${controller.pendingProfile.name.split(' ').first} acceptera votre demande.'
                      : 'Votre demande a été annulée. Vous pouvez la renvoyer à tout moment.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 20 * scale),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: requestSent
                        ? controller.cancelPendingRequest
                        : controller.resendPendingRequest,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      backgroundColor: requestSent ? const Color(0xFFEF4444) : const Color(0xFF176BFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                    ),
                    child: Text(
                      requestSent ? 'Annuler ma demande' : 'Renvoyer une demande',
                      style: GoogleFonts.inter(
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w600,
                      ),
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

class _PendingSocialStatsCard extends GetView<FindPartnerController> {
  const _PendingSocialStatsCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final stats = controller.pendingSocialStats;
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
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        child: Row(
          children: stats
              .map(
                (stat) => Expanded(
                  child: Column(
                    children: [
                      Text(
                        stat.value,
                        style: GoogleFonts.poppins(
                          color: stat.accent,
                          fontSize: 28 * scale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4 * scale),
                      Text(
                        stat.label,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF475569),
                          fontSize: 14 * scale,
                        ),
                      ),
                      if (stat.pillLabel != null) ...[
                        SizedBox(height: 8 * scale),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 6 * scale),
                          decoration: BoxDecoration(
                            color: stat.accent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(999 * scale),
                          ),
                          child: Text(
                            stat.pillLabel!,
                            style: GoogleFonts.inter(
                              color: stat.accent,
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _PendingSportsSection extends GetView<FindPartnerController> {
  const _PendingSportsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final sports = controller.pendingSports;
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
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
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
            SizedBox(height: 16 * scale),
            ...sports.map(
              (sport) => Padding(
                padding: EdgeInsets.only(bottom: sport == sports.last ? 0 : 12 * scale),
                child: _PendingSportCard(scale: scale, sport: sport),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingSportCard extends StatelessWidget {
  const _PendingSportCard({required this.scale, required this.sport});

  final double scale;
  final PendingSportCardData sport;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: sport.cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: sport.cardBorderColor.withValues(alpha: 0.6)),
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
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.sports_handball_rounded, color: Colors.white, size: 22 * scale),
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
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 6 * scale),
            decoration: BoxDecoration(
              color: sport.chipColor,
              borderRadius: BorderRadius.circular(999 * scale),
            ),
            child: Text(
              sport.chipLabel,
              style: GoogleFonts.inter(
                color: Colors.white,
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

class _PendingAnnouncementsSection extends GetView<FindPartnerController> {
  const _PendingAnnouncementsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final announcements = controller.pendingAnnouncements;
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
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Annonces récentes',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            ...announcements.map(
              (announcement) => Padding(
                padding: EdgeInsets.only(bottom: announcement == announcements.last ? 0 : 12 * scale),
                child: _LockedAnnouncementCard(scale: scale, announcement: announcement),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LockedAnnouncementCard extends StatelessWidget {
  const _LockedAnnouncementCard({required this.scale, required this.announcement});

  final double scale;
  final PendingAnnouncement announcement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144 * scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12 * scale),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF0B1220)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFE5E7EB).withValues(alpha: 0.3)),
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12 * scale),
          Row(
            children: [
              Container(
                width: 36 * scale,
                height: 36 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.lock_outline_rounded, color: Colors.white, size: 18 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.message,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4 * scale),
                    Text(
                      announcement.helper,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13 * scale,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PendingActivitySection extends GetView<FindPartnerController> {
  const _PendingActivitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final activities = controller.pendingRecentActivity;
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
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
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
            SizedBox(height: 16 * scale),
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
                        color: activity.iconColor.withValues(alpha: 0.15),
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
                              fontWeight: FontWeight.w600,
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

class _PendingMutualFriendsSection extends GetView<FindPartnerController> {
  const _PendingMutualFriendsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final friends = controller.pendingMutualFriends;
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
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amis en commun (${friends.length + controller.pendingMutualFriendsOverflow})',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            SizedBox(
              height: 48 * scale,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (int i = 0; i < friends.length; i++)
                    Positioned(
                      left: i * 36 * scale,
                      child: CircleAvatar(
                        radius: 24 * scale,
                        backgroundImage: NetworkImage(friends[i].avatarUrl),
                      ),
                    ),
                  Positioned(
                    left: friends.length * 36 * scale,
                    child: Container(
                      width: 48 * scale,
                      height: 48 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2 * scale),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+${controller.pendingMutualFriendsOverflow}',
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
              '${friends.first.name}, ${friends[1].name}, ${friends[2].name} et ${controller.pendingMutualFriendsOverflow} autres amis en commun',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 14 * scale,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingPrivacySection extends GetView<FindPartnerController> {
  const _PendingPrivacySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = controller.pendingPrivacySettings;
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
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paramètres de confidentialité',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: item == items.last ? 0 : 12 * scale),
                child: Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: item.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(color: item.accent.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32 * scale,
                        height: 32 * scale,
                        decoration: BoxDecoration(
                          color: item.accent,
                          borderRadius: BorderRadius.circular(10 * scale),
                        ),
                        child: Icon(Icons.shield_outlined,
                            color: Colors.white, size: 18 * scale),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF0B1220),
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              item.description,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 13 * scale,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class _PendingRecommendationsSection extends GetView<FindPartnerController> {
  const _PendingRecommendationsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final recommendations = controller.pendingRecommendations;
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
              blurRadius: 16 * scale,
              offset: Offset(0, 8 * scale),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommandations',
              style: GoogleFonts.poppins(
                color: const Color(0xFF0B1220),
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            ...recommendations.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: item == recommendations.last ? 0 : 12 * scale),
                child: Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        item.iconColor.withValues(alpha: 0.1),
                        item.iconColor.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(color: item.iconColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40 * scale,
                        height: 40 * scale,
                        decoration: BoxDecoration(
                          color: item.iconColor,
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Icon(Icons.lightbulb_outline,
                            color: Colors.white, size: 22 * scale),
                      ),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF0B1220),
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              item.subtitle,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 13 * scale,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: item.iconColor, size: 20 * scale),
                    ],
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

class _PendingFooterActions extends GetView<FindPartnerController> {
  const _PendingFooterActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.contactPendingProfile,
              icon: Icon(Icons.chat_bubble_outline_rounded, size: 20 * scale),
              label: Text(
                'Envoyer un message',
                style: GoogleFonts.inter(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                backgroundColor: const Color(0xFF176BFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: controller.reportPendingProfile,
              icon: Icon(Icons.report_gmailerrorred_rounded,
                  size: 20 * scale, color: const Color(0xFFEF4444)),
              label: Text(
                'Signaler cet utilisateur',
                style: GoogleFonts.inter(
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingBottomNav extends StatelessWidget {
  const _PendingBottomNav({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16 * scale,
            offset: Offset(0, -4 * scale),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 10 * scale),
      child: Row(
        children: [
          Expanded(
            child: _BottomNavItem(
              icon: Icons.home_filled,
              label: 'Accueil',
              scale: scale,
              onTap: () => Get.snackbar('Accueil', 'Navigation à venir'),
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.search_rounded,
              label: 'Recherche',
              scale: scale,
              onTap: () => Get.snackbar('Recherche', 'Vous êtes déjà sur la recherche'),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 56 * scale,
                height: 56 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF176BFF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x19176BFF),
                      blurRadius: 18 * scale,
                      offset: Offset(0, 10 * scale),
                    ),
                  ],
                ),
                child: Icon(Icons.add_rounded, color: Colors.white, size: 26 * scale),
              ),
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'Messages',
              scale: scale,
              onTap: () => Get.snackbar('Messages', 'Messagerie prochainement'),
            ),
          ),
          Expanded(
            child: _BottomNavItem(
              icon: Icons.person_outline_rounded,
              label: 'Profil',
              scale: scale,
              isActive: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
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

