import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/bottom_navigation/bottom_nav_widget.dart';
import '../controllers/find_partner_controller.dart';

class FindPartnerView extends GetView<FindPartnerController> {
  const FindPartnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.15);

          return Stack(
            children: [
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 120 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Header(scale: scale),
                            SizedBox(height: 12 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _SearchBar(scale: scale),
                            ),
                            SizedBox(height: 16 * scale),
                            _HeroActions(scale: scale),
                            SizedBox(height: 20 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _ActiveFilters(scale: scale),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _SectionIntro(
                                scale: scale,
                                resultLabel: '127 résultats',
                                query: 'Mark',
                              ),
                            ),
                            SizedBox(height: 20 * scale),
                            ...controller.partnerSections.map(
                              (section) => Padding(
                                padding: EdgeInsets.only(bottom: 24 * scale),
                                child: _PartnerSection(scale: scale, section: section),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _VenueSection(scale: scale, venues: controller.venueHighlights),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _AnnouncementSection(scale: scale, announcements: controller.announcements),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _QuickActionsSection(scale: scale, actions: controller.quickActions),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _SuggestionBuckets(scale: scale, buckets: controller.suggestionBuckets),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _SimilarSearches(scale: scale, searches: controller.similarSearches),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _EventHighlightCard(scale: scale, highlight: controller.eventHighlight),
                            ),
                            SizedBox(height: 16 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _EventHighlightCard(scale: scale, highlight: controller.groupRunHighlight),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _GroupSection(scale: scale, groups: controller.groups),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _UpcomingEvents(scale: scale, events: controller.nearbyEvents),
                            ),
                            SizedBox(height: 24 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                              child: _LoadMoreCard(scale: scale),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const BottomNavWidget(),
                  ],
                ),
              ),
              Positioned(
                right: 20 * scale,
                bottom: 110 * scale,
                child: _FloatingFilterButton(scale: scale),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends GetView<FindPartnerController> {
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
          Container(
            width: 48 * scale,
            height: 48 * scale,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Text(
              'A',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hey, Anna !', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Text('Trouve ton partenaire idéal', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
              ],
            ),
          ),
          _HeaderIcon(
            scale: scale,
            icon: Icons.notifications_none_rounded,
            badgeLabel: '3',
            background: const Color(0xFFF8FAFC),
          ),
          SizedBox(width: 10 * scale),
          _HeaderIcon(
            scale: scale,
            icon: Icons.chat_bubble_outline_rounded,
            badgeLabel: '2',
            background: const Color(0x19176BFF),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.scale,
    required this.icon,
    required this.background,
    this.badgeLabel,
  });

  final double scale;
  final IconData icon;
  final Color background;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Action', 'Fonctionnalité à venir'),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: const Color(0xFF0B1220), size: 20 * scale),
          ),
          if (badgeLabel != null)
            Positioned(
              right: -2 * scale,
              top: -6 * scale,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6 * scale, vertical: 2 * scale),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white, width: 2 * scale),
                ),
                child: Text(
                  badgeLabel!,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 11 * scale, fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchBar extends GetView<FindPartnerController> {
  const _SearchBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 58 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                    SizedBox(width: 12 * scale),
                    Expanded(
                      child: Text(
                        'Partenaires ou salle de sport...',
                        style: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 16 * scale),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12 * scale),
            _SquareButton(
              scale: scale,
              icon: Icons.tune_rounded,
              background: const Color(0xFF176BFF),
              foreground: Colors.white,
              onTap: controller.openFilters,
            ),
          ],
        ),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: EdgeInsets.all(4 * scale),
                child: Row(
                  children: [
                    _TogglePill(label: 'Recommandés', isSelected: true, scale: scale),
                    SizedBox(width: 6 * scale),
                    _TogglePill(label: 'Entre amis', isSelected: false, scale: scale),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12 * scale),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 36 * scale,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12 * scale),
                child: Row(
                  children: [
                    Icon(Icons.sports_tennis_rounded, size: 18 * scale, color: const Color(0xFF176BFF)),
                    SizedBox(width: 8 * scale),
                    Expanded(
                      child: Text('Tous les sports', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale)),
                    ),
                    Icon(Icons.expand_more_rounded, size: 18 * scale, color: const Color(0xFF94A3B8)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8 * scale),
            _FilterChip(scale: scale, icon: Icons.place_outlined, label: '5 km'),
            SizedBox(width: 8 * scale),
            _FilterChip(scale: scale, icon: Icons.calendar_today_outlined, label: 'Dispo'),
          ],
        ),
      ],
    );
  }
}

class _HeroActions extends GetView<FindPartnerController> {
  const _HeroActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100 * scale,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final action = controller.heroActions[index];
          return _HeroActionCard(scale: scale, action: action);
        },
        separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
        itemCount: controller.heroActions.length,
      ),
    );
  }
}

class _ActiveFilters extends GetView<FindPartnerController> {
  const _ActiveFilters({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Filtres actifs', style: GoogleFonts.poppins(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 12 * scale),
        Wrap(
          spacing: 10 * scale,
          runSpacing: 10 * scale,
          children: controller.activeFilters
              .map(
                (filter) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF176BFF),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF176BFF).withValues(alpha: 0.25), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline_rounded, size: 14 * scale, color: Colors.white),
                      SizedBox(width: 6 * scale),
                      Text(filter, style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _SectionIntro extends StatelessWidget {
  const _SectionIntro({required this.scale, required this.resultLabel, required this.query});

  final double scale;
  final String resultLabel;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale),
          children: [
            TextSpan(text: '$resultLabel ', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontWeight: FontWeight.w600, fontSize: 14 * scale)),
            TextSpan(text: 'trouvés pour '),
            TextSpan(text: '"$query"', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _PartnerSection extends StatelessWidget {
  const _PartnerSection({required this.scale, required this.section});

  final double scale;
  final PartnerHighlightSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32 * scale,
                    height: 32 * scale,
                    decoration: BoxDecoration(color: section.color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8 * scale)),
                    alignment: Alignment.center,
                    child: Icon(section.icon, color: section.color, size: 18 * scale),
                  ),
                  SizedBox(width: 12 * scale),
                  Text(section.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
                ],
              ),
              TextButton(
                onPressed: () => Get.snackbar('Voir tout', 'Affichage complet pour ${section.title}'),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF176BFF), padding: EdgeInsets.zero),
                child: Text('Voir tout', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12 * scale),
        SizedBox(
          height: 210 * scale,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _PartnerCard(scale: scale, partner: section.partners[index], accent: section.color),
            separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
            itemCount: section.partners.length,
          ),
        ),
      ],
    );
  }
}

class _VenueSection extends StatelessWidget {
  const _VenueSection({required this.scale, required this.venues});

  final double scale;
  final List<VenueHighlight> venues;

  @override
  Widget build(BuildContext context) {
    if (venues.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Établissements', icon: Icons.store_mall_directory_outlined, color: const Color(0xFF16A34A)),
        SizedBox(height: 12 * scale),
        ...venues.map(
          (venue) => Padding(
            padding: EdgeInsets.only(bottom: 16 * scale),
            child: _VenueCard(scale: scale, venue: venue),
          ),
        ),
      ],
    );
  }
}

class _AnnouncementSection extends StatelessWidget {
  const _AnnouncementSection({required this.scale, required this.announcements});

  final double scale;
  final List<AnnouncementCard> announcements;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Annonces', icon: Icons.campaign_outlined, color: const Color(0xFFFFB800)),
        SizedBox(height: 12 * scale),
        ...announcements.map(
          (announcement) => Padding(
            padding: EdgeInsets.only(bottom: 16 * scale),
            child: _AnnouncementCardWidget(scale: scale, announcement: announcement),
          ),
        ),
      ],
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection({required this.scale, required this.actions});

  final double scale;
  final List<QuickActionCard> actions;

  @override
  Widget build(BuildContext context) {
    if (actions.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Actions rapides', icon: Icons.flash_on_rounded, color: const Color(0xFF176BFF)),
        SizedBox(height: 16 * scale),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12 * scale,
            crossAxisSpacing: 12 * scale,
            childAspectRatio: 163 / 108,
          ),
          itemBuilder: (context, index) => _QuickActionTile(scale: scale, action: actions[index]),
        ),
      ],
    );
  }
}

class _SuggestionBuckets extends StatelessWidget {
  const _SuggestionBuckets({required this.scale, required this.buckets});

  final double scale;
  final List<SuggestionBucket> buckets;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Suggestions pour vous', icon: Icons.lightbulb_outline_rounded, color: const Color(0xFFFFB800)),
        SizedBox(height: 16 * scale),
        ...buckets.map(
          (bucket) => Padding(
            padding: EdgeInsets.only(bottom: 12 * scale),
            child: _SuggestionBucketTile(scale: scale, bucket: bucket),
          ),
        ),
      ],
    );
  }
}

class _SimilarSearches extends StatelessWidget {
  const _SimilarSearches({required this.scale, required this.searches});

  final double scale;
  final List<String> searches;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Recherches similaires', icon: Icons.search_rounded, color: const Color(0xFF176BFF)),
        SizedBox(height: 16 * scale),
        Wrap(
          spacing: 10 * scale,
          runSpacing: 10 * scale,
          children: searches
              .map(
                (search) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 10 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(search, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale)),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _EventHighlightCard extends StatelessWidget {
  const _EventHighlightCard({required this.scale, required this.highlight});

  final double scale;
  final EventHighlight highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            height: 128 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [highlight.accent, highlight.accent.withValues(alpha: 0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16 * scale)),
            ),
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8 * scale)),
                  child: Text(highlight.badge, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 16 * scale),
                Text(highlight.title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 6 * scale),
                Text(highlight.subtitle, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 14 * scale)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoRow(scale: scale, icon: Icons.schedule_rounded, label: highlight.schedule),
                      SizedBox(height: 8 * scale),
                      _InfoRow(scale: scale, icon: Icons.place_outlined, label: highlight.distance),
                      SizedBox(height: 8 * scale),
                      _InfoRow(scale: scale, icon: Icons.people_outline_rounded, label: highlight.participants),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Get.snackbar('Événement', 'Inscription à "${highlight.title}"'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF176BFF),
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 12 * scale),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                  ),
                  child: Text('Participer', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14 * scale)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupSection extends StatelessWidget {
  const _GroupSection({required this.scale, required this.groups});

  final double scale;
  final List<GroupHighlight> groups;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Groupes recommandés', icon: Icons.groups_rounded, color: const Color(0xFF176BFF)),
        SizedBox(height: 16 * scale),
        ...groups.map(
          (group) => Padding(
            padding: EdgeInsets.only(bottom: 16 * scale),
            child: _GroupCard(scale: scale, group: group),
          ),
        ),
      ],
    );
  }
}

class _UpcomingEvents extends StatelessWidget {
  const _UpcomingEvents({required this.scale, required this.events});

  final double scale;
  final List<EventCardData> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Événements près de vous', icon: Icons.event_rounded, color: const Color(0xFFFFB800)),
        SizedBox(height: 16 * scale),
        ...events.map(
          (event) => Padding(
            padding: EdgeInsets.only(bottom: 16 * scale),
            child: _NearbyEventCard(scale: scale, event: event),
          ),
        ),
      ],
    );
  }
}

class _LoadMoreCard extends StatelessWidget {
  const _LoadMoreCard({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.snackbar('Résultats', 'Chargement de plus de résultats...'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(vertical: 16 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
            ),
            child: Text('Charger plus de résultats', style: GoogleFonts.inter(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 12 * scale),
        Text('Affichage de 20 résultats sur 127', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
      ],
    );
  }
}

class _FloatingFilterButton extends StatelessWidget {
  const _FloatingFilterButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<FindPartnerController>().openFilters(),
      child: Container(
        width: 56 * scale,
        height: 56 * scale,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 16 * scale, offset: Offset(0, 12 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(Icons.filter_alt_rounded, color: Colors.white, size: 24 * scale),
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  const _SquareButton({
    required this.scale,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final double scale;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48 * scale,
        height: 58 * scale,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: foreground, size: 20 * scale),
      ),
    );
  }
}

class _TogglePill extends StatelessWidget {
  const _TogglePill({required this.label, required this.isSelected, required this.scale});

  final String label;
  final bool isSelected;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40 * scale,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF176BFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(10 * scale),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : const Color(0xFF475569),
            fontSize: 14 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36 * scale,
      padding: EdgeInsets.symmetric(horizontal: 12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16 * scale, color: const Color(0xFF475569)),
          SizedBox(width: 6 * scale),
          Text(label, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale)),
        ],
      ),
    );
  }
}

class _HeroActionCard extends StatelessWidget {
  const _HeroActionCard({required this.scale, required this.action});

  final double scale;
  final HeroAction action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Action', action.label),
      child: Container(
        width: 165 * scale,
        decoration: BoxDecoration(
          color: action.background,
          borderRadius: BorderRadius.circular(16 * scale),
          boxShadow: [
            BoxShadow(color: action.background.withValues(alpha: 0.25), blurRadius: 16 * scale, offset: Offset(0, 12 * scale)),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 18 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48 * scale,
              height: 48 * scale,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14 * scale)),
              alignment: Alignment.center,
              child: Icon(action.icon, color: action.foreground, size: 24 * scale),
            ),
            SizedBox(height: 12 * scale),
            Text(
              action.label,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  const _PartnerCard({required this.scale, required this.partner, required this.accent});

  final double scale;
  final PartnerHighlight partner;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(radius: 32 * scale, backgroundImage: NetworkImage(partner.avatarUrl)),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 18 * scale,
                    height: 18 * scale,
                    decoration: BoxDecoration(
                      color: partner.availabilityColor,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: Colors.white, width: 3 * scale),
                    ),
                  ),
                ),
                if (partner.isPro || partner.isVip || partner.isCoach || partner.isNew)
                  Positioned(
                    left: 0,
                    top: -4 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        partner.isCoach
                            ? 'Coach'
                            : partner.isVip
                                ? 'VIP'
                                : partner.isPro
                                    ? 'PRO'
                                    : 'NEW',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 11 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10 * scale),
            Text(
              partner.name,
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.place_outlined, size: 12 * scale, color: const Color(0xFF475569)),
                SizedBox(width: 4 * scale),
                Flexible(
                  child: Text(
                    partner.distance,
                    style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 11 * scale),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4 * scale),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 3 * scale),
              decoration: BoxDecoration(
                color: partner.availabilityColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                partner.availabilityLabel,
                style: GoogleFonts.inter(color: partner.availabilityColor, fontSize: 11 * scale, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 6 * scale),
            Wrap(
              spacing: 4 * scale,
              runSpacing: 4 * scale,
              alignment: WrapAlignment.center,
              children: partner.tags
                  .map(
                    (tag) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 6 * scale, vertical: 3 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 10 * scale),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 6 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, size: 14 * scale, color: const Color(0xFFFFB800)),
                SizedBox(width: 4 * scale),
                Text(partner.rating, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard({required this.scale, required this.venue});

  final double scale;
  final VenueHighlight venue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16 * scale)),
            child: SizedBox(
              height: 128 * scale,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(venue.imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xB3000000), Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16 * scale,
                    left: 16 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB800),
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                      child: Text(venue.badge, style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Positioned(
                    top: 16 * scale,
                    right: 16 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8 * scale)),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: Colors.amber, size: 14 * scale),
                          SizedBox(width: 4 * scale),
                          Text(venue.rating, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(venue.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Text(venue.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale)),
                SizedBox(height: 12 * scale),
                Wrap(
                  spacing: 8 * scale,
                  runSpacing: 8 * scale,
                  children: venue.sports
                      .map(
                        (sport) => Chip(
                          label: Text(sport),
                          backgroundColor: venue.accent.withValues(alpha: 0.1),
                          labelStyle: GoogleFonts.inter(color: venue.accent, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                          shape: StadiumBorder(side: BorderSide(color: venue.accent.withValues(alpha: 0.2))),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 12 * scale),
                Row(
                  children: [
                    _InfoRow(scale: scale, icon: Icons.place_outlined, label: venue.distance),
                    SizedBox(width: 12 * scale),
                    _InfoRow(scale: scale, icon: Icons.people_alt_outlined, label: venue.capacity),
                  ],
                ),
                SizedBox(height: 10 * scale),
                Wrap(
                  spacing: 8 * scale,
                  runSpacing: 8 * scale,
                  children: venue.extras
                      .map(
                        (extra) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_outline_rounded, size: 14 * scale, color: const Color(0xFF16A34A)),
                              SizedBox(width: 6 * scale),
                              Text(extra, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 16 * scale),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
                      decoration: BoxDecoration(
                        color: venue.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                      child: Text(venue.price, style: GoogleFonts.inter(color: venue.accent, fontSize: 14 * scale, fontWeight: FontWeight.w700)),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () => Get.snackbar('Établissement', 'Plus d\'infos sur ${venue.title}'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      child: Text('Voir plus', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(width: 8 * scale),
                    ElevatedButton(
                      onPressed: () => Get.snackbar('Réservation', 'Réservation envoyée à ${venue.title}'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176BFF),
                        padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                      ),
                      child: Text('Réserver', style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
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

class _AnnouncementCardWidget extends StatelessWidget {
  const _AnnouncementCardWidget({required this.scale, required this.announcement});

  final double scale;
  final AnnouncementCard announcement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 22 * scale, backgroundImage: NetworkImage(announcement.avatarUrl)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(announcement.author, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4 * scale),
                    Text(announcement.timeAgo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  ],
                ),
              ),
              Wrap(
                spacing: 6 * scale,
                children: announcement.badges
                    .map(
                      (badge) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFF176BFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(badge, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(announcement.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 8 * scale),
          Text(announcement.body, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.5)),
          SizedBox(height: 12 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 8 * scale,
            children: [
              _InfoRow(scale: scale, icon: Icons.place_outlined, label: announcement.distance),
              _InfoRow(scale: scale, icon: Icons.people_outline_rounded, label: announcement.participants),
              _InfoRow(scale: scale, icon: Icons.euro_rounded, label: announcement.priceLabel),
            ],
          ),
          SizedBox(height: 12 * scale),
          Wrap(
            spacing: 8 * scale,
            runSpacing: 8 * scale,
            children: announcement.stats
                .map(
                  (stat) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12 * scale),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(stat, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 16 * scale),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.snackbar('Annonce', announcement.actionLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF176BFF),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
              ),
              child: Text(announcement.actionLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.scale, required this.action});

  final double scale;
  final QuickActionCard action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Action rapide', action.label),
      child: Container(
        decoration: BoxDecoration(
          color: action.background,
          borderRadius: BorderRadius.circular(16 * scale),
          boxShadow: [
            BoxShadow(color: action.background.withValues(alpha: 0.2), blurRadius: 12 * scale, offset: Offset(0, 10 * scale)),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44 * scale,
              height: 44 * scale,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14 * scale)),
              alignment: Alignment.center,
              child: Icon(action.icon, color: action.foreground, size: 22 * scale),
            ),
            SizedBox(height: 12 * scale),
            Text(action.label, style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _SuggestionBucketTile extends StatelessWidget {
  const _SuggestionBucketTile({required this.scale, required this.bucket});

  final double scale;
  final SuggestionBucket bucket;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(color: bucket.iconColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14 * scale)),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_outward_rounded, color: bucket.iconColor, size: 20 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bucket.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Text(bucket.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Get.snackbar('Suggestions', bucket.title),
            child: Text('Voir', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.scale, required this.group});

  final double scale;
  final GroupHighlight group;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64 * scale,
            height: 64 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [group.accent, group.accent.withValues(alpha: 0.7)]),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            alignment: Alignment.center,
            child: Text(
              group.badge,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 6 * scale),
                Text(group.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, height: 1.4)),
                SizedBox(height: 12 * scale),
                Wrap(
                  spacing: 12 * scale,
                  children: [
                    _InfoRow(scale: scale, icon: Icons.place_outlined, label: group.distance),
                    _InfoRow(scale: scale, icon: Icons.people_outline_rounded, label: group.members),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          ElevatedButton(
            onPressed: () => Get.snackbar('Groupes', group.joinLabel),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
            ),
            child: Text(group.joinLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _NearbyEventCard extends StatelessWidget {
  const _NearbyEventCard({required this.scale, required this.event});

  final double scale;
  final EventCardData event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56 * scale,
                height: 56 * scale,
                decoration: BoxDecoration(color: event.accent.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14 * scale)),
                alignment: Alignment.center,
                child: Text(event.dateLabel, style: GoogleFonts.inter(color: event.accent, fontSize: 12 * scale, fontWeight: FontWeight.w700)),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4 * scale),
                    Text(event.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(color: event.accent.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12 * scale)),
                child: Text(event.priceLabel, style: GoogleFonts.inter(color: event.accent, fontSize: 13 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 8 * scale,
            children: [
              _InfoRow(scale: scale, icon: Icons.schedule_rounded, label: event.schedule),
              _InfoRow(scale: scale, icon: Icons.place_outlined, label: event.distance),
              _InfoRow(scale: scale, icon: Icons.people_outline_rounded, label: event.participants),
            ],
          ),
          SizedBox(height: 16 * scale),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.snackbar('Événements', 'Participation à ${event.title}'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12 * scale),
                side: BorderSide(color: event.accent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
              ),
              child: Text('Participer', style: GoogleFonts.inter(color: event.accent, fontSize: 14 * scale, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.scale, required this.title, required this.icon, required this.color});

  final double scale;
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32 * scale,
              height: 32 * scale,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8 * scale)),
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 18 * scale),
            ),
            SizedBox(width: 10 * scale),
            Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
          ],
        ),
        TextButton(
          onPressed: () => Get.snackbar(title, 'Action à venir'),
          style: TextButton.styleFrom(foregroundColor: const Color(0xFF176BFF), padding: EdgeInsets.zero),
          child: Text('Voir tout', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

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
