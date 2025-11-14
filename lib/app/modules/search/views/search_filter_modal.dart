import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/search_results_controller.dart';

class SearchFilterModal extends GetView<SearchResultsController> {
  const SearchFilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const designWidth = 375.0;
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
        final scale = (width / designWidth).clamp(0.9, 1.06).toDouble();

        return FractionallySizedBox(
          heightFactor: 0.97,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 32 * scale, offset: Offset(0, -12 * scale)),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  SizedBox(height: 12 * scale),
                  Container(
                    width: 46 * scale,
                    height: 4 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  SizedBox(height: 16 * scale),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: _HeaderBar(scale: scale),
                  ),
                  SizedBox(height: 20 * scale),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 32 * scale),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SearchTextField(scale: scale),
                            SizedBox(height: 20 * scale),
                            _PrimaryFiltersRow(scale: scale),
                            SizedBox(height: 28 * scale),
                            _ResultsHeader(scale: scale),
                            SizedBox(height: 20 * scale),
                            for (final result in controller.filterVenueResults)
                              Padding(
                                padding: EdgeInsets.only(bottom: result == controller.filterVenueResults.last ? 0 : 20 * scale),
                                child: _VenueResultCard(scale: scale, result: result),
                              ),
                            SizedBox(height: 28 * scale),
                            _LoadMoreButton(scale: scale),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _BottomNavigation(scale: scale),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeaderBar extends GetView<SearchResultsController> {
  const _HeaderBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(
          scale: scale,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: Get.back,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rechercher',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                'Affinez vos critères et explorez les résultats',
                style: GoogleFonts.inter(
                  color: const Color(0xFF64748B),
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        _CircleIconButton(
          scale: scale,
          icon: Icons.check_rounded,
          background: const Color(0xFF176BFF),
          iconColor: Colors.white,
          onTap: controller.applyFilters,
        ),
      ],
    );
  }
}

class _SearchTextField extends GetView<SearchResultsController> {
  const _SearchTextField({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: const Color(0xFF176BFF), size: 20 * scale),
          SizedBox(width: 12 * scale),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Rechercher des établissements...',
                hintStyle: GoogleFonts.inter(color: const Color(0xFFADAEBC), fontSize: 16 * scale, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            width: 36 * scale,
            height: 36 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF176BFF).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.tune_rounded, color: const Color(0xFF176BFF), size: 18 * scale),
          ),
        ],
      ),
    );
  }
}

class _PrimaryFiltersRow extends GetView<SearchResultsController> {
  const _PrimaryFiltersRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.primaryFilters
            .map(
              (filter) => Padding(
                padding: EdgeInsets.only(right: 12 * scale),
                child: _PrimaryFilterChip(scale: scale, option: filter),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ResultsHeader extends GetView<SearchResultsController> {
  const _ResultsHeader({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            controller.filterResultsSummary,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GestureDetector(
          onTap: controller.openMapView,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12 * scale),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Icon(Icons.map_rounded, color: const Color(0xFF176BFF), size: 16 * scale),
                SizedBox(width: 8 * scale),
                Text(
                  'Carte',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _VenueResultCard extends StatelessWidget {
  const _VenueResultCard({required this.scale, required this.result});

  final double scale;
  final FilterVenueResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20 * scale)),
            child: SizedBox(
              height: 192 * scale,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(result.imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.55),
                          Colors.black.withValues(alpha: 0.15),
                          Colors.black.withValues(alpha: 0.35),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16 * scale,
                    top: 16 * scale,
                    child: _StatusChip(
                      scale: scale,
                      label: result.availabilityLabel,
                      background: result.availabilityColor,
                    ),
                  ),
                  Positioned(
                    right: 16 * scale,
                    top: 16 * scale,
                    child: _StatusChip(
                      scale: scale,
                      label: result.distanceLabel,
                      background: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),
                  Positioned(
                    left: 16 * scale,
                    bottom: 16 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999 * scale),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                          SizedBox(width: 6 * scale),
                          Text(
                            result.ratingLabel,
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: 6 * scale),
                          Text(
                            '(${result.reviewCount})',
                            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.82), fontSize: 12 * scale),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20 * scale, 20 * scale, 20 * scale, 18 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.title,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Wrap(
                  spacing: 10 * scale,
                  runSpacing: 8 * scale,
                  children: result.sports
                      .map(
                        (sport) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                          child: Text(
                            sport,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 18 * scale),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: result.priceLabel,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF176BFF),
                              fontSize: 18 * scale,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '  /heure',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 14 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (result.isBookable)
                      ElevatedButton(
                        onPressed: () => Get.snackbar('Réserver', 'Ouverture de la réservation pour ${result.title}'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF176BFF),
                          padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 10 * scale),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                        ),
                        child: Text(
                          'Réserver',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14 * scale, fontWeight: FontWeight.w600),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24 * scale, vertical: 10 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Text(
                          'Indisponible',
                          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w600),
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

class _LoadMoreButton extends GetView<SearchResultsController> {
  const _LoadMoreButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: controller.loadMoreFilterResults,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 28 * scale, vertical: 14 * scale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        icon: Icon(Icons.refresh_rounded, color: const Color(0xFF475569), size: 18 * scale),
        label: Text(
          'Charger plus',
          style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _BottomNavigation extends GetView<SearchResultsController> {
  const _BottomNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12 * scale, left: 16 * scale, right: 16 * scale, bottom: 12 * scale + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFE2E8F0), width: 1 * scale)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 12 * scale, offset: Offset(0, -6 * scale)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.filterShortcuts
            .map(
              (shortcut) => _BottomNavItem(scale: scale, shortcut: shortcut),
            )
            .toList(),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.scale,
    required this.icon,
    required this.onTap,
    this.background = const Color(0xFFF8FAFC),
    this.iconColor = const Color(0xFF0B1220),
  });

  final double scale;
  final IconData icon;
  final VoidCallback onTap;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48 * scale,
        height: 48 * scale,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(999 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 22 * scale, color: iconColor),
      ),
    );
  }
}

class _PrimaryFilterChip extends StatelessWidget {
  const _PrimaryFilterChip({required this.scale, required this.option});

  final double scale;
  final PrimaryFilterOption option;

  @override
  Widget build(BuildContext context) {
    final bool highlight = option.isHighlighted;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18 * scale, vertical: 10 * scale),
      decoration: BoxDecoration(
        gradient: highlight
            ? const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)], begin: Alignment.topLeft, end: Alignment.bottomRight)
            : null,
        color: highlight ? null : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(999 * scale),
        border: Border.all(color: highlight ? Colors.transparent : const Color(0xFFE2E8F0)),
        boxShadow: highlight
            ? [
                BoxShadow(color: const Color(0xFF176BFF).withValues(alpha: 0.3), blurRadius: 16 * scale, offset: Offset(0, 8 * scale)),
              ]
            : null,
      ),
      child: Row(
        children: [
          Icon(option.icon, size: 16 * scale, color: highlight ? Colors.white : const Color(0xFF475569)),
          SizedBox(width: 8 * scale),
          Text(
            option.label,
            style: GoogleFonts.inter(
              color: highlight ? Colors.white : const Color(0xFF475569),
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.scale, required this.label, required this.background});

  final double scale;
  final String label;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 6 * scale),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.scale, required this.shortcut});

  final double scale;
  final FilterBottomShortcut shortcut;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF176BFF);
    final bool isActive = shortcut.isActive;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              color: isActive ? activeColor.withValues(alpha: 0.1) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14 * scale),
              border: Border.all(color: isActive ? activeColor.withValues(alpha: 0.4) : const Color(0xFFE2E8F0)),
            ),
            alignment: Alignment.center,
            child: Icon(shortcut.icon, color: isActive ? activeColor : const Color(0xFF475569), size: 20 * scale),
          ),
          SizedBox(height: 6 * scale),
          Text(
            shortcut.label,
            style: GoogleFonts.inter(
              color: isActive ? activeColor : const Color(0xFF475569),
              fontSize: 12 * scale,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

