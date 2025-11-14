import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/map_explore_controller.dart';

class MapExploreView extends GetView<MapExploreController> {
  const MapExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.hasBoundedWidth ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.15);
          final padding = MediaQuery.of(context).padding;

          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 72 * scale),
                    Expanded(child: _MapCanvas(scale: scale)),
                  ],
                ),
                Positioned(
                  left: 16 * scale,
                  right: 16 * scale,
                  top: padding.top + 12 * scale,
                  child: _TopSearchBar(scale: scale),
                ),
                Positioned(
                  left: 16 * scale,
                  top: padding.top + 16 * scale + 72 * scale,
                  child: _FilterFloatingPanel(scale: scale),
                ),
                Positioned(
                  right: 16 * scale,
                  bottom: padding.bottom + 140 * scale,
                  child: _MapControls(scale: scale),
                ),
                Positioned(
                  right: 16 * scale,
                  top: padding.top + 100 * scale,
                  child: _LocationButton(scale: scale),
                ),
                _FilterSidebar(scale: scale),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _VenueListSheet(scale: scale),
                ),
                Positioned(
                  bottom: padding.bottom + 16 * scale,
                  left: 16 * scale,
                  right: 16 * scale,
                  child: _BottomNavigator(scale: scale),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TopSearchBar extends GetView<MapExploreController> {
  const _TopSearchBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18 * scale),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 18 * scale, offset: Offset(0, 8 * scale)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              color: const Color(0x19176BFF),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.search_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Carte des terrains',
                  style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  'Explorer les lieux sportifs',
                  style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale),
                ),
              ],
            ),
          ),
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.notifications_none_rounded, color: const Color(0xFF475569), size: 18 * scale),
          ),
        ],
      ),
    );
  }
}

class _FilterFloatingPanel extends GetView<MapExploreController> {
  const _FilterFloatingPanel({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.toggleFilters,
      child: Container(
        width: 48 * scale,
        height: 48 * scale,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
          borderRadius: BorderRadius.circular(16 * scale),
          boxShadow: [
            BoxShadow(color: const Color(0xFF176BFF).withValues(alpha: 0.2), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(Icons.tune_rounded, color: Colors.white, size: 22 * scale),
      ),
    );
  }
}

class _MapControls extends GetView<MapExploreController> {
  const _MapControls({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MapControlButton(
          scale: scale,
          icon: Icons.zoom_in_rounded,
          onTap: () => Get.snackbar('Carte', 'Zoom avant.'),
        ),
        SizedBox(height: 10 * scale),
        _MapControlButton(
          scale: scale,
          icon: Icons.zoom_out_rounded,
          onTap: () => Get.snackbar('Carte', 'Zoom arrière.'),
        ),
        SizedBox(height: 10 * scale),
        _MapControlButton(
          scale: scale,
          icon: Icons.layers_rounded,
          onTap: () => Get.snackbar('Carte', 'Changer de vue (satellite / plan).'),
        ),
      ],
    );
  }
}

class _MapControlButton extends StatelessWidget {
  const _MapControlButton({required this.scale, required this.icon, required this.onTap});

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(14 * scale),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 16 * scale, offset: Offset(0, 8 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 20 * scale),
      ),
    );
  }
}

class _LocationButton extends GetView<MapExploreController> {
  const _LocationButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.useMyLocation,
      child: Container(
        width: 48 * scale,
        height: 48 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 18 * scale, offset: Offset(0, 8 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(Icons.my_location_rounded, color: const Color(0xFF176BFF), size: 22 * scale),
      ),
    );
  }
}

class _MapCanvas extends GetView<MapExploreController> {
  const _MapCanvas({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale).copyWith(bottom: 16 * scale),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24 * scale),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFEFF6FF), Color(0xFFF0FDF4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomPaint(
                painter: _GridPainter(),
              ),
            ),
            ...controller.venues.map(
              (venue) => _MapPin(scale: scale, venue: venue),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(16 * scale),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 10 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14 * scale),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14 * scale, offset: Offset(0, 6 * scale)),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _LegendDot(color: const Color(0xFF16A34A), label: 'Disponible', scale: scale),
                      SizedBox(width: 12 * scale),
                      _LegendDot(color: const Color(0xFFF59E0B), label: 'Bientôt complet', scale: scale),
                      SizedBox(width: 12 * scale),
                      _LegendDot(color: const Color(0xFFEF4444), label: 'Complet', scale: scale),
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

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label, required this.scale});

  final Color color;
  final String label;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10 * scale, height: 10 * scale, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 6 * scale),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
      ],
    );
  }
}

class _MapPin extends GetView<MapExploreController> {
  const _MapPin({required this.scale, required this.venue});

  final double scale;
  final MapVenue venue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: venue.coordinate.dx * MediaQuery.of(context).size.width - 24 * scale,
      top: (venue.coordinate.dy * (MediaQuery.of(context).size.height * 0.58)) - 56 * scale,
      child: GestureDetector(
        onTap: () => controller.onVenueTap(venue),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: venue.gradient),
                borderRadius: BorderRadius.circular(20 * scale),
                boxShadow: [
                  BoxShadow(color: venue.gradient.last.withValues(alpha: 0.3), blurRadius: 16 * scale, offset: Offset(0, 8 * scale)),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(venue.icon, color: Colors.white, size: 16 * scale),
                  SizedBox(width: 6 * scale),
                  Text(
                    venue.priceLabel,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: 10 * scale,
              height: 10 * scale,
              decoration: BoxDecoration(
                color: venue.gradient.last,
                borderRadius: BorderRadius.circular(3 * scale),
              ),
              margin: EdgeInsets.only(top: 6 * scale),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSidebar extends GetView<MapExploreController> {
  const _FilterSidebar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        left: controller.filtersOpened.value ? 0 : -280 * scale,
        top: 0,
        bottom: 0,
        child: Container(
          width: 280 * scale,
          margin: EdgeInsets.symmetric(vertical: 12 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(24 * scale)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.16), blurRadius: 28 * scale, offset: Offset(8 * scale, 0)),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20 * scale, 20 * scale, 20 * scale, 12 * scale),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filtres',
                        style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.toggleFilters,
                      child: Container(
                        width: 36 * scale,
                        height: 36 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.close, color: const Color(0xFF475569), size: 18 * scale),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...controller.sidebarFilters.map(
                        (category) => Padding(
                          padding: EdgeInsets.only(bottom: 24 * scale),
                          child: _FilterCategorySection(scale: scale, category: category),
                        ),
                      ),
                      _PriceSlider(scale: scale),
                      SizedBox(height: 24 * scale),
                      _DistanceChips(scale: scale),
                      SizedBox(height: 24 * scale),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20 * scale, 12 * scale, 20 * scale, 20 * scale),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.applyFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF176BFF),
                          padding: EdgeInsets.symmetric(vertical: 14 * scale),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                        ),
                        child: Text('Appliquer les filtres', style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(height: 10 * scale),
                    TextButton(
                      onPressed: controller.resetFilters,
                      child: Text('Réinitialiser', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterCategorySection extends StatelessWidget {
  const _FilterCategorySection({required this.scale, required this.category});

  final double scale;
  final MapFilterCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category.title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 14 * scale),
        Wrap(
          spacing: 12 * scale,
          runSpacing: 10 * scale,
          children: category.options
              .map(
                (option) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 10 * scale),
                  decoration: BoxDecoration(
                    gradient: option.isActive ? const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]) : null,
                    color: option.isActive ? null : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(14 * scale),
                    border: Border.all(color: option.isActive ? Colors.transparent : const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (option.icon != null) ...[
                        Icon(option.icon, color: option.isActive ? Colors.white : const Color(0xFF475569), size: 16 * scale),
                        SizedBox(width: 8 * scale),
                      ],
                      Text(
                        option.label,
                        style: GoogleFonts.inter(
                          color: option.isActive ? Colors.white : const Color(0xFF475569),
                          fontSize: 13 * scale,
                          fontWeight: option.isActive ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
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

class _PriceSlider extends GetView<MapExploreController> {
  const _PriceSlider({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prix maximum', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 16 * scale),
        Stack(
          children: [
            Container(
              height: 8 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Container(
              height: 8 * scale,
              width: 140 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFF176BFF),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF176BFF).withValues(alpha: 0.35), blurRadius: 16 * scale, offset: Offset(0, 6 * scale)),
                ],
              ),
            ),
            Positioned(
              left: 130 * scale,
              top: -8 * scale,
              child: Container(
                width: 24 * scale,
                height: 24 * scale,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFF176BFF), width: 2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10 * scale),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: controller.priceSteps
              .map(
                (price) => Text(price, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _DistanceChips extends GetView<MapExploreController> {
  const _DistanceChips({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Distance', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
        SizedBox(height: 14 * scale),
        Row(
          children: controller.radiusOptions
              .map(
                (radius) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: radius == controller.radiusOptions.last ? 0 : 10 * scale),
                    padding: EdgeInsets.symmetric(vertical: 10 * scale),
                    decoration: BoxDecoration(
                      color: radius == '5 km' ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(12 * scale),
                      border: Border.all(color: radius == '5 km' ? Colors.transparent : const Color(0xFFE2E8F0)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      radius,
                      style: GoogleFonts.inter(
                        color: radius == '5 km' ? Colors.white : const Color(0xFF475569),
                        fontSize: 13.5 * scale,
                        fontWeight: FontWeight.w600,
                      ),
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

class _VenueListSheet extends GetView<MapExploreController> {
  const _VenueListSheet({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final showList = controller.showListPane.value;
        final selected = controller.selectedVenue.value;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          height: showList ? 280 * scale : 120 * scale,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 24 * scale, offset: Offset(0, -10 * scale)),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Terrains disponibles',
                        style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: const Color(0x19176BFF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${controller.venues.length} résultats',
                        style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 12.5 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 10 * scale),
                    GestureDetector(
                      onTap: controller.toggleListPane,
                      child: Container(
                        width: 40 * scale,
                        height: 40 * scale,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                        alignment: Alignment.center,
                        child: Icon(showList ? Icons.expand_more_rounded : Icons.expand_less_rounded, color: const Color(0xFF475569)),
                      ),
                    ),
                  ],
                ),
              ),
              if (selected != null) _SelectedVenuePreview(scale: scale, venue: selected),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 16 * scale, right: 16 * scale, bottom: 12 * scale),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.venues.length,
                  itemBuilder: (context, index) {
                    final venue = controller.venues[index];
                    return Padding(
                      padding: EdgeInsets.only(right: index == controller.venues.length - 1 ? 0 : 16 * scale),
                      child: _VenueCard(scale: scale, venue: venue),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SelectedVenuePreview extends GetView<MapExploreController> {
  const _SelectedVenuePreview({required this.scale, required this.venue});

  final double scale;
  final MapVenue venue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Container(
        padding: EdgeInsets.all(16 * scale),
        margin: EdgeInsets.only(bottom: 12 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(18 * scale),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 20 * scale, offset: Offset(0, 10 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(venue.name, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                const Spacer(),
                GestureDetector(
                  onTap: controller.closeVenuePreview,
                  child: Icon(Icons.close_rounded, color: Colors.white.withValues(alpha: 0.7), size: 18 * scale),
                ),
              ],
            ),
            SizedBox(height: 6 * scale),
            Text('${venue.sports.join(', ')} • ${venue.distanceLabel}', style: GoogleFonts.inter(color: Colors.white70, fontSize: 12.5 * scale)),
            SizedBox(height: 12 * scale),
            Row(
              children: venue.slots
                  .map(
                    (slot) => Container(
                      margin: EdgeInsets.only(right: 8 * scale),
                      padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12 * scale),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Text(slot, style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 14 * scale),
            Row(
              children: [
                Text(venue.priceLabel, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(width: 10 * scale),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                  decoration: BoxDecoration(
                    color: venue.availabilityColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(venue.availabilityLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => controller.bookVenue(venue),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0F172A),
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 10 * scale),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, size: 16 * scale),
                      SizedBox(width: 6 * scale),
                      Text('Réserver', style: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                    ],
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

class _VenueCard extends GetView<MapExploreController> {
  const _VenueCard({required this.scale, required this.venue});

  final double scale;
  final MapVenue venue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openVenueDetails(venue),
      child: Container(
        width: 260 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 16 * scale, offset: Offset(0, 8 * scale)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: venue.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.vertical(top: Radius.circular(18 * scale)),
              ),
              padding: EdgeInsets.all(16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                        child: Row(
                          children: [
                            Icon(venue.icon, color: Colors.white, size: 16 * scale),
                            SizedBox(width: 6 * scale),
                            Text(venue.priceLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.favorite_border_rounded, color: Colors.white, size: 18 * scale),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    venue.name,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6 * scale),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: Colors.white70, size: 14 * scale),
                      SizedBox(width: 4 * scale),
                      Text(venue.distanceLabel, style: GoogleFonts.inter(color: Colors.white70, fontSize: 12 * scale)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venue.sports.join(' • '),
                    style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale),
                  ),
                  SizedBox(height: 10 * scale),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                      SizedBox(width: 4 * scale),
                      Text(
                        '${venue.ratingLabel} (${venue.reviewCount})',
                        style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                        decoration: BoxDecoration(
                          color: venue.availabilityColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Text(
                          venue.availabilityLabel,
                          style: GoogleFonts.inter(color: venue.availabilityColor, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16 * scale),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => controller.bookVenue(venue),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF176BFF),
                        side: const BorderSide(color: Color(0xFF176BFF)),
                        padding: EdgeInsets.symmetric(vertical: 12 * scale),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
                      ),
                      child: Text('Réserver', style: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600)),
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

class _BottomNavigator extends StatelessWidget {
  const _BottomNavigator({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final items = [
      _BottomItem(icon: Icons.home_filled, label: 'Accueil'),
      _BottomItem(icon: Icons.search_rounded, label: 'Rechercher'),
      _BottomItem(icon: Icons.map_rounded, label: 'Carte', isActive: true),
      _BottomItem(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
      _BottomItem(icon: Icons.person_outline_rounded, label: 'Profil'),
    ];
    return Container(
      height: 72 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22 * scale),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items
            .map(
              (item) => Expanded(
                child: GestureDetector(
                  onTap: () => Get.snackbar(item.label, 'Navigation vers ${item.label}.'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon, color: item.isActive ? const Color(0xFF176BFF) : const Color(0xFF475569), size: 20 * scale),
                      SizedBox(height: 6 * scale),
                      Text(
                        item.label,
                        style: GoogleFonts.inter(
                          color: item.isActive ? const Color(0xFF176BFF) : const Color(0xFF475569),
                          fontSize: 11.5 * scale,
                          fontWeight: item.isActive ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BottomItem {
  const _BottomItem({required this.icon, required this.label, this.isActive = false});

  final IconData icon;
  final String label;
  final bool isActive;
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFD1D5DB).withValues(alpha: 0.45);

    const cellWidth = 48.0;
    const cellHeight = 60.0;

    for (double x = 0; x < size.width; x += cellWidth) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += cellHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

