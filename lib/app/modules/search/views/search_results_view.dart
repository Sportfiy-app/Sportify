import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/search_results_controller.dart';
import 'search_filter_modal.dart';

class SearchResultsView extends GetView<SearchResultsController> {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 90 * scale)),
                  SliverToBoxAdapter(child: _SearchField(scale: scale)),
                  SliverToBoxAdapter(child: _ActiveFilters(scale: scale)),
                  SliverToBoxAdapter(child: _ResultsSummary(scale: scale)),
                  SliverToBoxAdapter(child: _PlayerSection(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 24 * scale)),
                  SliverToBoxAdapter(child: _VenueSection(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 24 * scale)),
                  SliverToBoxAdapter(child: _AnnouncementSection(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 24 * scale)),
                  SliverToBoxAdapter(child: _QuickActionsGrid(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 24 * scale)),
                  SliverToBoxAdapter(child: _SuggestionSection(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 24 * scale)),
                  SliverToBoxAdapter(child: _SimilarSearches(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 24 * scale)),
                  SliverToBoxAdapter(child: _LoadMoreSection(scale: scale)),
                  SliverToBoxAdapter(child: SizedBox(height: 140 * scale)),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _TopBar(scale: scale),
              ),
              Positioned(
                right: 16 * scale,
                bottom: 180 * scale,
                child: _FloatingFilterButton(scale: scale),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _BottomNav(scale: scale),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 64 * scale,
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 4 * scale)),
          ],
        ),
        child: Row(
          children: [
            _TopIconButton(
              scale: scale,
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: Get.back,
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(
                'Résultats de recherche',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 12 * scale),
            _TopIconButton(
              scale: scale,
              icon: Icons.filter_alt_outlined,
              onTap: () => Get.bottomSheet(
                const SearchFilterModal(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({required this.scale, required this.icon, required this.onTap});

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
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}

class _SearchField extends GetView<SearchResultsController> {
  const _SearchField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 24 * scale, offset: Offset(0, 12 * scale)),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recherche',
              style: GoogleFonts.inter(
                color: const Color(0xFF475569),
                fontSize: 13 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12 * scale),
            Row(
              children: [
                Container(
                  width: 40 * scale,
                  height: 40 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.search_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Obx(
                    () => Text(
                      controller.query.value,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0B1220),
                        fontSize: 18 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.snackbar('Éditer', 'Modification de la recherche à venir'),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFF176BFF).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'Modifier',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF176BFF),
                        fontSize: 13 * scale,
                        fontWeight: FontWeight.w600,
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

class _ActiveFilters extends GetView<SearchResultsController> {
  const _ActiveFilters({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16 * scale, right: 16 * scale, top: 20 * scale),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(horizontal: BorderSide(color: const Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtres actifs',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: controller.activeFilters
                .map(
                  (chip) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 7 * scale),
                    decoration: BoxDecoration(
                      color: chip.color,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (chip.icon != null) ...[
                          Icon(chip.icon, size: 14 * scale, color: Colors.white),
                          SizedBox(width: 6 * scale),
                        ],
                        Text(
                          chip.label,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6 * scale),
                        Container(
                          width: 16 * scale,
                          height: 16 * scale,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.close, size: 10 * scale, color: Colors.white),
                        ),
                      ],
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

class _ResultsSummary extends GetView<SearchResultsController> {
  const _ResultsSummary({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20 * scale, 24 * scale, 20 * scale, 0),
      child: Obx(
        () => RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 14 * scale,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: '${controller.resultsSummary} ',
                style: const TextStyle(color: Color(0xFF0B1220), fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: '"${controller.query.value}"',
                style: const TextStyle(color: Color(0xFF475569)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerSection extends GetView<SearchResultsController> {
  const _PlayerSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20 * scale, 20 * scale, 20 * scale, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.person_search_rounded,
            title: 'Joueurs (${controller.playerResults.length})',
            actionLabel: 'Voir tout',
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: controller.visiblePlayers
                .map(
                  (player) => Padding(
                    padding: EdgeInsets.only(bottom: 16 * scale),
                    child: _PlayerCard(scale: scale, player: player),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({required this.scale, required this.player});

  final double scale;
  final SearchPlayerResult player;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20 * scale, offset: Offset(0, 12 * scale)),
                      BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20 * scale, offset: Offset(0, 12 * scale)),
        ],
      ),
      padding: EdgeInsets.all(18 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(radius: 28 * scale, backgroundImage: NetworkImage(player.avatarUrl)),
              Positioned(
                bottom: -2 * scale,
                right: -2 * scale,
                child: Container(
                  width: 16 * scale,
                  height: 16 * scale,
                  decoration: BoxDecoration(
                    color: player.online ? const Color(0xFF16A34A) : const Color(0xFF94A3B8),
                    border: Border.all(color: Colors.white, width: 3 * scale),
                    borderRadius: BorderRadius.circular(9999),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        player.name,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF0B1220),
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: player.levelColor,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        player.levelBadge,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8 * scale),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 16 * scale, color: const Color(0xFF475569)),
                    SizedBox(width: 4 * scale),
                    Text(
                      player.distanceLabel,
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                    ),
                    SizedBox(width: 12 * scale),
                    Icon(Icons.star_rounded, size: 16 * scale, color: const Color(0xFFFFB800)),
                    SizedBox(width: 4 * scale),
                    Text(
                      player.ratingLabel,
                      style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                    ),
                  ],
                ),
                SizedBox(height: 12 * scale),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8 * scale,
                        runSpacing: 8 * scale,
                        children: [
                          _TagChip(label: 'Football', color: const Color(0xFF176BFF), scale: scale),
                          _TagChip(label: 'Sport collectif', color: const Color(0xFF16A34A), scale: scale),
                        ],
                      ),
                    ),
                    SizedBox(width: 12 * scale),
                    ElevatedButton.icon(
                      onPressed: () => Get.snackbar('Message', 'Entrer en contact avec ${player.name}'),
                      icon: Icon(Icons.send_rounded, size: 16 * scale),
                      label: Text(
                        player.messageCta,
                        style: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176BFF),
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                      ),
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

class _VenueSection extends GetView<SearchResultsController> {
  const _VenueSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final primary = controller.venueHighlight;
    final secondary = controller.venueSecondary;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.store_mall_directory_rounded,
            title: 'Établissements (18)',
            actionLabel: 'Voir tout',
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: [
              _VenueCard(scale: scale, venue: primary),
              SizedBox(height: 16 * scale),
              _VenueCard(scale: scale, venue: secondary),
            ],
          ),
        ],
      ),
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard({required this.scale, required this.venue});

  final double scale;
  final SearchVenueHighlight venue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 24 * scale, offset: Offset(0, 12 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 128 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: venue.gradient),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20 * scale)),
            ),
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB800),
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                      child: Text(
                        venue.availabilityLabel,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rate_rounded, size: 14 * scale, color: const Color(0xFFFFB800)),
                          SizedBox(width: 4 * scale),
                          Text(
                            venue.ratingLabel,
                            style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 12 * scale, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  venue.title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  venue.subtitle,
                  style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 14 * scale),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            venue.pricePerHour,
                            style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 18 * scale, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4 * scale),
                          Text(
                            'par heure',
                            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Get.snackbar('Réservation', 'Demande envoyée au complexe'),
                      icon: Icon(Icons.calendar_month_rounded, size: 16 * scale),
                      label: Text(
                        'Réserver',
                        style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176BFF),
                        padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16 * scale),
                Wrap(
                  spacing: 12 * scale,
                  runSpacing: 12 * scale,
                  children: [
                    _IconLabel(icon: Icons.location_on_outlined, label: venue.distanceLabel, scale: scale),
                    _IconLabel(icon: Icons.people_alt_outlined, label: venue.capacityLabel, scale: scale),
                    _IconLabel(icon: Icons.local_parking_rounded, label: venue.amenityLabel, scale: scale),
                  ],
                ),
                SizedBox(height: 16 * scale),
                Wrap(
                  spacing: 10 * scale,
                  children: venue.sports.map((sport) => _TagChip(label: sport, color: const Color(0xFF16A34A), scale: scale)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({required this.icon, required this.label, required this.scale});

  final IconData icon;
  final String label;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16 * scale, color: const Color(0xFF475569)),
        SizedBox(width: 6 * scale),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
      ],
    );
  }
}

class _AnnouncementSection extends GetView<SearchResultsController> {
  const _AnnouncementSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.campaign_rounded,
            title: 'Annonces (${controller.announcements.length})',
            actionLabel: 'Voir tout',
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: controller.visibleAnnouncements
                .map(
                  (announcement) => Padding(
                    padding: EdgeInsets.only(bottom: 18 * scale),
                    child: _AnnouncementCard(scale: scale, announcement: announcement),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.scale, required this.announcement});

  final double scale;
  final SearchAnnouncement announcement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20 * scale, offset: Offset(0, 12 * scale)),
        ],
      ),
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 24 * scale, backgroundImage: NetworkImage(announcement.avatarUrl)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.author,
                      style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4 * scale),
                    Wrap(
                      spacing: 6 * scale,
                      children: announcement.tags
                          .map(
                            (tag) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                              decoration: BoxDecoration(
                                color: tag == 'Coach Pro'
                                    ? const Color(0xFFFFB800)
                                    : tag == 'Capitaine'
                                        ? const Color(0xFF0EA5E9)
                                        : const Color(0xFF176BFF),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                tag,
                                style: GoogleFonts.inter(color: Colors.white, fontSize: 11 * scale, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Text(
            announcement.headline,
            style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12 * scale),
          Text(
            announcement.description,
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.45),
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 16 * scale,
            runSpacing: 12 * scale,
            children: [
              _IconLabel(icon: Icons.location_on_outlined, label: announcement.distance, scale: scale),
              _IconLabel(icon: Icons.people_alt_outlined, label: announcement.participants, scale: scale),
              _IconLabel(icon: Icons.payments_outlined, label: announcement.price, scale: scale),
            ],
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => Get.snackbar('Action', '${announcement.ctaLabel} ${announcement.author}'),
                icon: Icon(Icons.chat_bubble_outline_rounded, size: 16 * scale, color: Colors.white),
                label: Text(
                  announcement.ctaLabel,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: announcement.ctaLabel.contains('Rejoindre') ? const Color(0xFF16A34A) : const Color(0xFF176BFF),
                  padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                ),
              ),
              if (announcement.extraActions != null) ...[
                SizedBox(width: 16 * scale),
                Expanded(
                  child: Wrap(
                    spacing: 12 * scale,
                    children: announcement.extraActions!
                        .map(
                          (label) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              label,
                              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends GetView<SearchResultsController> {
  const _QuickActionsGrid({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * scale),
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(24 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.flash_on_rounded,
            title: 'Actions rapides',
          ),
          SizedBox(height: 16 * scale),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.quickActions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16 * scale,
              mainAxisSpacing: 16 * scale,
              childAspectRatio: 164 / 108,
            ),
            itemBuilder: (context, index) {
              final action = controller.quickActions[index];
              return _QuickActionCard(scale: scale, action: action);
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.scale, required this.action});

  final double scale;
  final QuickSearchAction action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar(action.title, 'Action en préparation'),
      child: Container(
        decoration: BoxDecoration(
          color: action.background,
          borderRadius: BorderRadius.circular(16 * scale),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48 * scale,
              height: 48 * scale,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(9999),
              ),
              alignment: Alignment.center,
              child: Icon(action.icon, color: Colors.white, size: 24 * scale),
            ),
            SizedBox(height: 12 * scale),
            Text(
              action.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionSection extends GetView<SearchResultsController> {
  const _SuggestionSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * scale),
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.lightbulb_rounded,
            title: 'Suggestions pour vous',
          ),
          SizedBox(height: 16 * scale),
          Column(
            children: controller.suggestionBuckets
                .map(
                  (suggestion) => Padding(
                    padding: EdgeInsets.only(bottom: 12 * scale),
                    child: _SuggestionCard(scale: scale, suggestion: suggestion),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.scale, required this.suggestion});

  final double scale;
  final SearchSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
      child: Row(
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(suggestion.icon, size: 20 * scale, color: const Color(0xFF176BFF)),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestion.title,
                  style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  suggestion.subtitle,
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.snackbar('Suggestion', suggestion.title),
            child: Text(
              'Voir',
              style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimilarSearches extends GetView<SearchResultsController> {
  const _SimilarSearches({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * scale),
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            scale: scale,
            icon: Icons.search_rounded,
            title: 'Recherches similaires',
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: controller.similarSearches
                .map(
                  (label) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 10 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale),
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

class _LoadMoreSection extends GetView<SearchResultsController> {
  const _LoadMoreSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20 * scale, 0, 20 * scale, 24 * scale),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => Get.snackbar('Résultats', 'Chargement de nouveaux résultats'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh_rounded, color: Colors.white, size: 18 * scale),
                SizedBox(width: 8 * scale),
                Text(
                  'Charger plus de résultats',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Affichage de ${controller.shownResults} résultats sur ${controller.playerResults.length + controller.announcements.length}',
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (84 + MediaQuery.of(context).padding.bottom) * scale,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 16 * scale, offset: Offset(0, -4 * scale)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(scale: scale, icon: Icons.home_filled, label: 'Accueil'),
          _NavItem(scale: scale, icon: Icons.search_rounded, label: 'Recherche', isActive: true),
          _FloatingPublish(scale: scale),
          _NavItem(scale: scale, icon: Icons.chat_bubble_outline_rounded, label: 'Messages', showBadge: true),
          _NavItem(scale: scale, icon: Icons.person_outline_rounded, label: 'Profil'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.scale, required this.icon, required this.label, this.isActive = false, this.showBadge = false});

  final double scale;
  final IconData icon;
  final String label;
  final bool isActive;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF176BFF) : const Color(0xFF475569);
    return GestureDetector(
      onTap: () => Get.snackbar(label, 'Navigation vers $label'),
      child: SizedBox(
        width: 70 * scale,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24 * scale),
                if (showBadge)
                  Positioned(
                    right: -6 * scale,
                    top: -6 * scale,
                    child: Container(
                      width: 8 * scale,
                      height: 8 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 6 * scale),
            Text(
              label,
              style: GoogleFonts.inter(color: color, fontSize: 12 * scale, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingPublish extends StatelessWidget {
  const _FloatingPublish({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88 * scale,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Get.snackbar('Publier', 'Création d\'annonce bientôt disponible'),
            child: Container(
              width: 56 * scale,
              height: 56 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFF176BFF),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: [
                  BoxShadow(color: const Color(0x19176BFF), blurRadius: 16 * scale, offset: Offset(0, 10 * scale)),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(Icons.add_rounded, color: Colors.white, size: 24 * scale),
            ),
          ),
          SizedBox(height: 6 * scale),
          Text(
            'Publier',
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale),
          ),
        ],
      ),
    );
  }
}

class _FloatingFilterButton extends StatelessWidget {
  const _FloatingFilterButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        const SearchFilterModal(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      ),
      child: Container(
        width: 56 * scale,
        height: 56 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFFFB800),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 16 * scale, offset: Offset(0, 10 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(Icons.filter_alt_rounded, color: Colors.white, size: 24 * scale),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.scale, required this.icon, required this.title, this.actionLabel});

  final double scale;
  final IconData icon;
  final String title;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24 * scale,
          height: 24 * scale,
          decoration: BoxDecoration(
            color: const Color(0xFF176BFF).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8 * scale),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 16 * scale, color: const Color(0xFF176BFF)),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: () => Get.snackbar(actionLabel!, 'Navigation en préparation'),
            child: Text(
              actionLabel!,
              style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.color, required this.scale});

  final String label;
  final Color color;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(color: color, fontSize: 12 * scale, fontWeight: FontWeight.w600),
      ),
    );
  }
}

