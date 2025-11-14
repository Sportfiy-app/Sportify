import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/favorite_places_controller.dart';

class FavoritePlacesView extends GetView<FavoritePlacesController> {
  const FavoritePlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);

          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 16 * scale).copyWith(bottom: 110 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TopNavigation(scale: scale),
                      SizedBox(height: 18 * scale),
                      _SearchBar(scale: scale),
                      SizedBox(height: 16 * scale),
                      _SummaryStats(scale: scale),
                      SizedBox(height: 28 * scale),
                      _RecentVisitsSection(scale: scale),
                      SizedBox(height: 28 * scale),
                      _FavoritePlacesSection(scale: scale),
                      SizedBox(height: 32 * scale),
                      _CollectionsSection(scale: scale),
                      SizedBox(height: 32 * scale),
                      _RecommendationSection(scale: scale),
                      SizedBox(height: 32 * scale),
                      _ActionSection(scale: scale),
                    ],
                  ),
                ),
                Positioned(
                  right: 24 * scale,
                  bottom: 84 * scale,
                  child: _FloatingAction(scale: scale),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _BottomNavigation(scale: scale),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TopNavigation extends GetView<FavoritePlacesController> {
  const _TopNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    return Row(
      children: [
        _CircleButton(
          scale: scale,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: Get.back,
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lieux favoris',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                '${summary.totalPlaces} lieux sauvegardés',
                style: GoogleFonts.inter(
                  color: const Color(0xFF64748B),
                  fontSize: 13 * scale,
                ),
              ),
            ],
          ),
        ),
        _CircleButton(
          scale: scale,
          icon: Icons.share_outlined,
          onTap: () => Get.snackbar('Partage', 'Fonctionnalité à venir.'),
        ),
        SizedBox(width: 12 * scale),
        _CircleButton(
          scale: scale,
          icon: Icons.more_horiz_rounded,
          onTap: () => Get.snackbar('Actions', 'Gestion des favoris bientôt disponible.'),
        ),
      ],
    );
  }
}

class _SearchBar extends GetView<FavoritePlacesController> {
  const _SearchBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 16 * scale, offset: Offset(0, 8 * scale)),
        ],
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16 * scale),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
                SizedBox(width: 10 * scale),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: controller.searchQuery.value),
                    onChanged: (value) => controller.searchQuery.value = value,
                    decoration: InputDecoration(
                      hintText: 'Rechercher dans vos favoris...',
                      hintStyle: GoogleFonts.inter(color: const Color(0xFFADB5BD), fontSize: 14 * scale),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              Expanded(child: _FilterToggle(scale: scale)),
              SizedBox(width: 12 * scale),
              _SortButton(scale: scale),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterToggle extends GetView<FavoritePlacesController> {
  const _FilterToggle({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: controller.filters
              .map(
                (chip) {
                  final isSelected = controller.selectedFilter.value == chip.label;
                  return Padding(
                    padding: EdgeInsets.only(right: 10 * scale),
                    child: GestureDetector(
                      onTap: () => controller.selectedFilter.value = chip.label,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 12 * scale),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment(-0.3, 0.8), end: Alignment(0.8, -0.6))
                              : null,
                          color: isSelected ? null : const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Icon(chip.icon, size: 16 * scale, color: isSelected ? Colors.white : const Color(0xFF475569)),
                            SizedBox(width: 8 * scale),
                            Text(
                              chip.label,
                              style: GoogleFonts.inter(
                                fontSize: 13.5 * scale,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white : const Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
              .toList(),
        ),
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Tri', 'Options de tri à venir.'),
      child: Container(
        width: 76 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(10 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tune_rounded, color: const Color(0xFF475569), size: 18 * scale),
            SizedBox(width: 6 * scale),
            Text('Trier', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _SummaryStats extends GetView<FavoritePlacesController> {
  const _SummaryStats({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final summary = controller.summary;
    return Container(
      height: 90 * scale,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(20 * scale),
        boxShadow: [BoxShadow(color: const Color(0x33176BFF), blurRadius: 22 * scale, offset: Offset(0, 14 * scale))],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SummaryTile(scale: scale, value: summary.totalPlaces.toString(), label: 'Lieux'),
          _SummaryTile(scale: scale, value: summary.sportsCount.toString(), label: 'Sports'),
          _SummaryTile(scale: scale, value: '${summary.averageDistance.toStringAsFixed(1)}km', label: 'Moyenne'),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.scale, required this.value, required this.label});

  final double scale;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 24 * scale, fontWeight: FontWeight.w700)),
        SizedBox(height: 4 * scale),
        Text(label, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 13 * scale)),
      ],
    );
  }
}

class _RecentVisitsSection extends GetView<FavoritePlacesController> {
  const _RecentVisitsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          scale: scale,
          title: 'Récemment visités',
          actionLabel: 'Voir tout',
          onAction: () => Get.snackbar('Historique', 'Liste complète bientôt disponible.'),
        ),
        SizedBox(height: 16 * scale),
        SizedBox(
          height: 176 * scale,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentVisits.length,
            separatorBuilder: (_, __) => SizedBox(width: 16 * scale),
            itemBuilder: (context, index) {
              final place = controller.recentVisits[index];
              return _RecentPlaceCard(scale: scale, place: place);
            },
          ),
        ),
      ],
    );
  }
}

class _RecentPlaceCard extends StatelessWidget {
  const _RecentPlaceCard({required this.scale, required this.place});

  final double scale;
  final RecentFavoritePlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 8 * scale))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18 * scale)),
            child: Stack(
              children: [
                Image.network(place.imageUrl, height: 86 * scale, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 8 * scale,
                  right: 8 * scale,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('${place.distanceKm.toStringAsFixed(1)}km', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 11 * scale, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 12 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 6 * scale),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 14 * scale),
                    SizedBox(width: 4 * scale),
                    Text(place.rating.toStringAsFixed(1), style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                  ],
                ),
                SizedBox(height: 6 * scale),
                Text(place.lastVisitedLabel, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritePlacesSection extends GetView<FavoritePlacesController> {
  const _FavoritePlacesSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Tous mes favoris', actionLabel: 'Filtrer', onAction: () => Get.snackbar('Filtres', 'Bientôt disponible.')),
        SizedBox(height: 16 * scale),
        Column(
          children: controller.favoritePlaces
              .map((place) => Padding(
                    padding: EdgeInsets.only(bottom: 20 * scale),
                    child: _FavoritePlaceCard(scale: scale, place: place),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _FavoritePlaceCard extends StatelessWidget {
  const _FavoritePlaceCard({required this.scale, required this.place});

  final double scale;
  final FavoritePlaceCard place;

  Color _statusColor(FavoritePlaceStatus status) {
    switch (status) {
      case FavoritePlaceStatus.open:
        return const Color(0xFF16A34A);
      case FavoritePlaceStatus.limited:
        return const Color(0xFFF59E0B);
      case FavoritePlaceStatus.closed:
        return const Color(0xFFEF4444);
    }
  }

  String _statusLabel(FavoritePlaceStatus status) {
    switch (status) {
      case FavoritePlaceStatus.open:
        return 'Ouvert';
      case FavoritePlaceStatus.limited:
        return 'Ferme bientôt';
      case FavoritePlaceStatus.closed:
        return 'Fermé';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(place.status);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18 * scale, offset: Offset(0, 12 * scale))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20 * scale)),
            child: Stack(
              children: [
                Image.network(place.imageUrl, height: 192 * scale, width: double.infinity, fit: BoxFit.cover),
                Container(
                  height: 192 * scale,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withValues(alpha: 0), Colors.black.withValues(alpha: 0), Colors.black.withValues(alpha: 0.65)],
                    ),
                  ),
                ),
                Positioned(
                  top: 12 * scale,
                  left: 12 * scale,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sports, size: 14 * scale, color: const Color(0xFF0B1220)),
                        SizedBox(width: 6 * scale),
                        Text(place.sportTag, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12 * scale,
                  right: 12 * scale,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('${place.distanceKm.toStringAsFixed(1)}km', style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                  ),
                ),
                Positioned(
                  bottom: 16 * scale,
                  left: 16 * scale,
                  right: 16 * scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place.title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 20 * scale, fontWeight: FontWeight.w700)),
                      SizedBox(height: 6 * scale),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, color: const Color(0xFFFFD166), size: 16 * scale),
                          SizedBox(width: 6 * scale),
                          Text(place.rating.toStringAsFixed(1), style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w500)),
                          SizedBox(width: 10 * scale),
                          Text('•', style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale)),
                          SizedBox(width: 10 * scale),
                          Text(place.price, style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16 * scale,
                  right: 16 * scale,
                  child: _CircleIconButton(scale: scale, icon: Icons.favorite, onTap: () => Get.snackbar('Favoris', '${place.title} restera dans vos favoris.')),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 16 * scale, color: const Color(0xFF475569)),
                    SizedBox(width: 8 * scale),
                    Expanded(
                      child: Text(place.address, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
                      child: Text(_statusLabel(place.status), style: GoogleFonts.inter(color: statusColor, fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(height: 14 * scale),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 16 * scale, color: const Color(0xFF475569)),
                    SizedBox(width: 6 * scale),
                    Text(place.hours, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                    SizedBox(width: 16 * scale),
                    Icon(Icons.group_outlined, size: 16 * scale, color: const Color(0xFF475569)),
                    SizedBox(width: 6 * scale),
                    Text(place.capacity, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                  ],
                ),
                if (place.badges.isNotEmpty) ...[
                  SizedBox(height: 14 * scale),
                  Wrap(
                    spacing: 10 * scale,
                    runSpacing: 8 * scale,
                    children: place.badges
                        .map(
                          (badge) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 6 * scale),
                            decoration: BoxDecoration(color: const Color(0x1916A34A), borderRadius: BorderRadius.circular(999)),
                            child: Text(badge, style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                          ),
                        )
                        .toList(),
                  ),
                ],
                SizedBox(height: 18 * scale),
                Row(
                  children: [
                    Expanded(
                      child: _PrimaryButton(
                        scale: scale,
                        label: place.status == FavoritePlaceStatus.closed ? 'Indisponible' : 'Réserver',
                        enabled: place.status != FavoritePlaceStatus.closed,
                        onTap: () => Get.snackbar('Réservation', 'Ouverture de la réservation pour ${place.title}.'),
                      ),
                    ),
                    SizedBox(width: 12 * scale),
                    _SecondarySquareButton(scale: scale, icon: Icons.route_outlined, onTap: () => Get.snackbar('Itinéraire', 'Guidage vers ${place.title}.')),
                    SizedBox(width: 12 * scale),
                    _SecondarySquareButton(scale: scale, icon: Icons.call_outlined, onTap: () => Get.snackbar('Contact', 'Appel vers ${place.title}.')),
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

class _CollectionsSection extends GetView<FavoritePlacesController> {
  const _CollectionsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final collections = controller.collections;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Collections', actionLabel: 'Gérer', onAction: () => Get.snackbar('Collections', 'Gestion des collections à venir.')),
        SizedBox(height: 18 * scale),
        Wrap(
          spacing: 16 * scale,
          runSpacing: 16 * scale,
          children: collections
              .map(
                (collection) => _CollectionCard(scale: scale, card: collection),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({required this.scale, required this.card});

  final double scale;
  final FavoriteCollectionCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164 * scale,
      height: 142 * scale,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [card.color, card.color.withValues(alpha: 0.85)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18 * scale),
        boxShadow: [BoxShadow(color: card.color.withValues(alpha: 0.25), blurRadius: 18 * scale, offset: Offset(0, 12 * scale))],
      ),
      padding: EdgeInsets.all(18 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24 * scale,
                height: 24 * scale,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8 * scale)),
                alignment: Alignment.center,
                child: Icon(Icons.layers_rounded, color: Colors.white, size: 16 * scale),
              ),
              const Spacer(),
              Text(card.countLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale)),
            ],
          ),
          SizedBox(height: 18 * scale),
          Text(card.title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 8 * scale),
          Text(card.subtitle, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 13 * scale)),
        ],
      ),
    );
  }
}

class _RecommendationSection extends GetView<FavoritePlacesController> {
  const _RecommendationSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final recommendation = controller.recommendation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Recommandations proches', actionLabel: 'Voir plus', onAction: () => Get.snackbar('Recommandations', 'Plus de recommandations à venir.')),
        SizedBox(height: 18 * scale),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 16 * scale, offset: Offset(0, 10 * scale))],
          ),
          padding: EdgeInsets.all(20 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48 * scale,
                    height: 48 * scale,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.auto_awesome_outlined, color: Colors.white, size: 24 * scale),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(recommendation.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4 * scale),
                        Text(recommendation.subtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18 * scale),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(14 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: EdgeInsets.all(14 * scale),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12 * scale),
                      child: Image.network(recommendation.suggestion.imageUrl, width: 48 * scale, height: 48 * scale, fit: BoxFit.cover),
                    ),
                    SizedBox(width: 14 * scale),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(recommendation.suggestion.name, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4 * scale),
                          Text('${recommendation.suggestion.description} • ${recommendation.suggestion.distanceKm.toStringAsFixed(1)}km',
                              style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                        SizedBox(width: 4 * scale),
                        Text(recommendation.suggestion.rating.toStringAsFixed(1), style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18 * scale),
              Row(
                children: [
                  Expanded(
                    child: _PrimaryButton(
                      scale: scale,
                      label: 'Découvrir',
                      onTap: () => Get.snackbar('Découvrir', 'Exploration de ${recommendation.suggestion.name}.'),
                    ),
                  ),
                  SizedBox(width: 12 * scale),
                  _SecondarySquareButton(scale: scale, icon: Icons.open_in_new_rounded, onTap: () => Get.snackbar('Détails', 'Ouverture de la fiche.')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionSection extends GetView<FavoritePlacesController> {
  const _ActionSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final actions = controller.actionCards;
    return Column(
      children: actions
          .map(
            (action) => Padding(
              padding: EdgeInsets.only(bottom: 16 * scale),
              child: _ActionListTile(scale: scale, card: action),
            ),
          )
          .toList(),
    );
  }
}

class _ActionListTile extends GetView<FavoritePlacesController> {
  const _ActionListTile({required this.scale, required this.card});

  final double scale;
  final FavoriteActionCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12 * scale, offset: Offset(0, 6 * scale))],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 18 * scale),
      child: Row(
        children: [
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(color: card.iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12 * scale)),
            alignment: Alignment.center,
            child: Icon(Icons.bookmark_added_outlined, color: card.iconColor, size: 22 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.title, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 4 * scale),
                Text(card.subtitle, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12.5 * scale)),
              ],
            ),
          ),
          if (card.hasToggle)
            Obx(
              () => Switch.adaptive(
                value: controller.notificationsEnabled.value,
                activeColor: const Color(0xFF176BFF),
                onChanged: (value) => controller.notificationsEnabled.value = value,
              ),
            )
          else
            Icon(Icons.chevron_right_rounded, color: const Color(0xFF94A3B8), size: 22 * scale),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.scale, required this.label, required this.onTap, this.enabled = true});

  final double scale;
  final String label;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final background = enabled ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0);
    final foreground = enabled ? Colors.white : const Color(0xFF94A3B8);
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 48 * scale,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        alignment: Alignment.center,
        child: Text(label, style: GoogleFonts.inter(color: foreground, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _SecondarySquareButton extends StatelessWidget {
  const _SecondarySquareButton({required this.scale, required this.icon, required this.onTap});

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 20 * scale),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.scale, required this.icon, required this.onTap});

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
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFFEF4444), size: 20 * scale),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.scale, required this.title, this.actionLabel, this.onAction});

  final double scale;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        const Spacer(),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(actionLabel!, style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w500)),
          ),
      ],
    );
  }
}

class _FloatingAction extends StatelessWidget {
  const _FloatingAction({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Ajouter', 'Création d’un nouveau favori prochainement.'),
      child: Container(
        width: 58 * scale,
        height: 58 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFF176BFF),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: const Color(0x4C176BFF), blurRadius: 28 * scale, offset: Offset(0, 14 * scale))],
        ),
        alignment: Alignment.center,
        child: Icon(Icons.add_rounded, color: Colors.white, size: 30 * scale),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = [
      _BottomNavItem(icon: Icons.home_outlined, label: 'Accueil'),
      _BottomNavItem(icon: Icons.search_rounded, label: 'Recherche'),
      _BottomNavItem(icon: Icons.calendar_today_outlined, label: 'Réservations'),
      _BottomNavItem(icon: Icons.favorite, label: 'Favoris', active: true),
      _BottomNavItem(icon: Icons.person_outline_rounded, label: 'Profil'),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 10 * scale),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) => item.build(scale)).toList(),
      ),
    );
  }
}

class _BottomNavItem {
  _BottomNavItem({required this.icon, required this.label, this.active = false});

  final IconData icon;
  final String label;
  final bool active;

  Widget build(double scale) {
    final color = active ? const Color(0xFF176BFF) : const Color(0xFF475569);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24 * scale),
        SizedBox(height: 6 * scale),
        Text(label, style: GoogleFonts.inter(color: color, fontSize: 11 * scale, fontWeight: active ? FontWeight.w600 : FontWeight.w500)),
      ],
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
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10 * scale, offset: Offset(0, 4 * scale))],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF0B1220), size: 18 * scale),
      ),
    );
  }
}
