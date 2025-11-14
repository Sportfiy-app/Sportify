import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/booking_detail_controller.dart';

class BookingPlaceDetailView extends StatefulWidget {
  const BookingPlaceDetailView({super.key});

  @override
  State<BookingPlaceDetailView> createState() => _BookingPlaceDetailViewState();
}

class _BookingPlaceDetailViewState extends State<BookingPlaceDetailView> {
  final BookingDetailController controller = Get.find<BookingDetailController>();
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          final scale = (width / designWidth).clamp(0.9, 1.1);
          final padding = MediaQuery.of(context).padding;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: (120 + padding.bottom) * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: padding.top),
                    _HeroSection(scale: scale, pageController: _pageController),
                    Transform.translate(
                      offset: Offset(0, -28 * scale),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                        child: _DetailSheet(scale: scale),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: padding.top + 16 * scale,
                left: 16 * scale,
                right: 16 * scale,
                child: _TopBar(scale: scale),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _BottomBookingBar(scale: scale, bottomInset: padding.bottom),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroSection extends GetView<BookingDetailController> {
  const _HeroSection({required this.scale, required this.pageController});

  final double scale;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final facility = controller.facility;
    return SizedBox(
      height: 320 * scale,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: controller.galleryImages.length,
            onPageChanged: controller.setGalleryIndex,
            itemBuilder: (_, index) => Image.network(controller.galleryImages[index], fit: BoxFit.cover),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.black.withValues(alpha: 0.05),
                  Colors.black.withValues(alpha: 0.55),
                ],
              ),
            ),
          ),
          Positioned(
            top: 80 * scale,
            right: 20 * scale,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 6 * scale),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)]),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
                ],
              ),
              child: Text(
                facility.priceLabel,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            bottom: 20 * scale,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(
                () => _GalleryIndicator(
                  scale: scale,
                  count: controller.galleryImages.length,
                  index: controller.galleryIndex.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends GetView<BookingDetailController> {
  const _TopBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleOverlayButton(
          scale: scale,
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: controller.onBack,
        ),
        const Spacer(),
        _CircleOverlayButton(
          scale: scale,
          icon: Icons.info_outline_rounded,
          onTap: controller.onInfo,
        ),
      ],
    );
  }
}

class _DetailSheet extends GetView<BookingDetailController> {
  const _DetailSheet({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final facility = controller.facility;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24 * scale),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 28 * scale, offset: Offset(0, 18 * scale)),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20 * scale, 28 * scale, 20 * scale, 32 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(facility.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 28 * scale, fontWeight: FontWeight.w700)),
                    SizedBox(height: 8 * scale),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, color: const Color(0xFF475569), size: 18 * scale),
                        SizedBox(width: 6 * scale),
                        Expanded(
                          child: Text(
                            facility.distanceLabel,
                            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 14 * scale),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _FavoriteButton(scale: scale),
            ],
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: [
              _RatingPill(scale: scale, rating: facility.rating, count: facility.reviewCount),
              SizedBox(width: 10 * scale),
              _StatusPill(scale: scale, label: facility.statusLabel, color: facility.statusColor),
            ],
          ),
          SizedBox(height: 20 * scale),
          Text(
            'Terrain moderne et climatisé, idéal pour vos matchs entre amis. Équipements pro, vestiaires avec douches et réservation instantanée.',
            style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 15 * scale, height: 1.55),
          ),
          SizedBox(height: 24 * scale),
          _InfoGrid(scale: scale),
          SizedBox(height: 24 * scale),
          _QuickActions(scale: scale),
          SizedBox(height: 28 * scale),
          _AvailabilitySection(scale: scale),
          SizedBox(height: 28 * scale),
          _MapSection(scale: scale),
          SizedBox(height: 28 * scale),
          _ReviewsSection(scale: scale),
          SizedBox(height: 28 * scale),
          _SimilarSection(scale: scale),
          SizedBox(height: 28 * scale),
          _SupportStrip(scale: scale),
        ],
      ),
    );
  }
}

class _InfoGrid extends GetView<BookingDetailController> {
  const _InfoGrid({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final quickFacts = controller.quickFacts.take(3).toList();
    final items = [
      ...quickFacts.map(
        (fact) => _InfoCard(scale: scale, icon: fact.icon, label: fact.label, value: fact.value),
      ),
      _InfoCard(scale: scale, icon: Icons.attach_money_rounded, label: 'Tarif', value: controller.pricing.priceLabel),
    ].take(4).toList();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12 * scale,
        mainAxisSpacing: 12 * scale,
        childAspectRatio: 162 / 86,
      ),
      itemBuilder: (_, index) => items[index],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.scale, required this.icon, required this.label, required this.value});

  final double scale;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36 * scale,
            height: 36 * scale,
            decoration: BoxDecoration(
              color: const Color(0x14176BFF),
              borderRadius: BorderRadius.circular(12 * scale),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: const Color(0xFF176BFF), size: 18 * scale),
          ),
          SizedBox(height: 10 * scale),
          Text(label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
          SizedBox(height: 4 * scale),
          Text(value, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 15 * scale, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _QuickActions extends GetView<BookingDetailController> {
  const _QuickActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(label: 'Appeler', icon: Icons.phone_rounded, color: const Color(0xFF176BFF), onTap: controller.onCall),
      _QuickActionData(label: 'Itinéraire', icon: Icons.navigation_rounded, color: const Color(0xFF16A34A), onTap: controller.onDirections),
      _QuickActionData(label: 'Favoris', icon: Icons.favorite_border_rounded, color: const Color(0xFFFFB800), onTap: controller.onToggleFavorite),
    ];

    return Row(
      children: actions
          .map(
            (action) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: action == actions.last ? 0 : 12 * scale),
                child: GestureDetector(
                  onTap: action.onTap,
                  child: Container(
                    height: 84 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16 * scale),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 6))],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40 * scale,
                          height: 40 * scale,
                          decoration: BoxDecoration(
                            color: action.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                          alignment: Alignment.center,
                          child: Icon(action.icon, color: action.color, size: 20 * scale),
                        ),
                        SizedBox(height: 8 * scale),
                        Text(action.label, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _AvailabilitySection extends GetView<BookingDetailController> {
  const _AvailabilitySection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final slots = controller.dailyAvailabilities;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          scale: scale,
          title: 'Créneaux disponibles aujourd\'hui',
          trailing: TextButton(
            onPressed: controller.onViewMoreAvailability,
            child: Text('Voir plus', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 14 * scale),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: slots
                .map(
                  (slot) => Padding(
                    padding: EdgeInsets.only(right: 12 * scale),
                    child: Container(
                      width: 96 * scale,
                      padding: EdgeInsets.symmetric(vertical: 12 * scale),
                      decoration: BoxDecoration(
                        color: _backgroundForState(slot.state),
                        borderRadius: BorderRadius.circular(14 * scale),
                        border: Border.all(color: _borderForState(slot.state), width: 1.2 * scale),
                      ),
                      child: Column(
                        children: [
                          Text(slot.time, style: GoogleFonts.inter(color: _textForState(slot.state), fontSize: 15 * scale, fontWeight: FontWeight.w700)),
                          SizedBox(height: 6 * scale),
                          Text(_stateLabel(slot.state), style: GoogleFonts.inter(color: _textForState(slot.state), fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 16 * scale),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
          decoration: BoxDecoration(
            color: controller.highlight.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          child: Row(
            children: [
              Icon(Icons.bolt_rounded, color: controller.highlight.color, size: 18 * scale),
              SizedBox(width: 10 * scale),
              Expanded(
                child: Text(
                  controller.highlight.label,
                  style: GoogleFonts.inter(color: controller.highlight.color, fontSize: 13 * scale, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapSection extends GetView<BookingDetailController> {
  const _MapSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final location = controller.location;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(scale: scale, title: 'Localisation'),
        SizedBox(height: 16 * scale),
        ClipRRect(
          borderRadius: BorderRadius.circular(16 * scale),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 327 / 182,
                child: Image.network(location.mapImage, fit: BoxFit.cover),
              ),
              Positioned(
                left: 16 * scale,
                bottom: 16 * scale,
                right: 16 * scale,
                child: Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 24 * scale, offset: Offset(0, 10 * scale)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, color: const Color(0xFFEF4444), size: 20 * scale),
                          SizedBox(width: 8 * scale),
                          Expanded(
                            child: Text(controller.facility.address, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      SizedBox(height: 6 * scale),
                      Text(location.travelInfo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                      SizedBox(height: 4 * scale),
                      Text(location.transitInfo, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                      SizedBox(height: 12 * scale),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: controller.onOpenMaps,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF176BFF),
                            side: const BorderSide(color: Color(0xFF176BFF)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                          ),
                          child: Text('Obtenir l\'itinéraire', style: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewsSection extends GetView<BookingDetailController> {
  const _ReviewsSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final reviews = controller.reviews.take(2).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          scale: scale,
          title: 'Avis clients',
          trailing: TextButton(
            onPressed: controller.onViewAllReviews,
            child: Text('Voir tous', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 16 * scale),
        ...reviews.map(
          (review) => Padding(
            padding: EdgeInsets.only(bottom: review == reviews.last ? 0 : 12 * scale),
            child: _ReviewCard(scale: scale, review: review),
          ),
        ),
      ],
    );
  }
}

class _SimilarSection extends GetView<BookingDetailController> {
  const _SimilarSection({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          scale: scale,
          title: 'Terrains similaires',
          trailing: TextButton(
            onPressed: controller.onViewSimilar,
            child: Text('Voir plus', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 16 * scale),
        SizedBox(
          height: 182 * scale,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => _SimilarVenueCard(scale: scale, venue: controller.similarVenues[index]),
            separatorBuilder: (_, __) => SizedBox(width: 16 * scale),
            itemCount: controller.similarVenues.length,
          ),
        ),
      ],
    );
  }
}

class _SupportStrip extends GetView<BookingDetailController> {
  const _SupportStrip({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFA855F7), Color(0xFF7C3AED)]),
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Besoin d’aide ?', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 6 * scale),
          Text(
            'Notre équipe support est disponible 24h/7j pour vous accompagner.',
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.92), fontSize: 14 * scale),
          ),
          SizedBox(height: 12 * scale),
          TextButton(
            onPressed: controller.onInfo,
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Contacter le support', style: GoogleFonts.inter(fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 0, width: 6 * scale),
                Icon(Icons.arrow_outward_rounded, size: 16 * scale),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBookingBar extends GetView<BookingDetailController> {
  const _BottomBookingBar({required this.scale, required this.bottomInset});

  final double scale;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 16 * scale + bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 18, offset: Offset(0, -8))],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.pricing.priceLabel, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w700)),
              SizedBox(height: 4 * scale),
              Text('Réservation instantanée', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12.5 * scale)),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: controller.onBook,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF176BFF),
              padding: EdgeInsets.symmetric(horizontal: 26 * scale, vertical: 12 * scale),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16 * scale)),
            ),
            icon: Icon(Icons.calendar_month_rounded, color: Colors.white, size: 18 * scale),
            label: Text('Réserver', style: GoogleFonts.inter(color: Colors.white, fontSize: 15 * scale, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends GetView<BookingDetailController> {
  const _FavoriteButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.onToggleFavorite,
      child: Container(
        width: 40 * scale,
        height: 40 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.favorite_border_rounded, color: const Color(0xFFEF4444), size: 20 * scale),
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  const _RatingPill({required this.scale, required this.rating, required this.count});

  final double scale;
  final double rating;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: const Color(0x33FFB800),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
          SizedBox(width: 6 * scale),
          Text(rating.toStringAsFixed(1), style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w700)),
          SizedBox(width: 6 * scale),
          Text('($count)', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.scale, required this.label, required this.color});

  final double scale;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: GoogleFonts.inter(color: color, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.scale, required this.review});

  final double scale;
  final FacilityReview review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20 * scale, backgroundImage: NetworkImage(review.avatarUrl)),
              SizedBox(width: 12 * scale),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.author, style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2 * scale),
                  Text(review.timestamp, style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12 * scale)),
                ],
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: const Color(0x33FFB800),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                    SizedBox(width: 4 * scale),
                    Text(review.rating.toStringAsFixed(1), style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Text(review.content, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13.5 * scale, height: 1.5)),
        ],
      ),
    );
  }
}

class _SimilarVenueCard extends GetView<BookingDetailController> {
  const _SimilarVenueCard({required this.scale, required this.venue});

  final double scale;
  final SimilarVenue venue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240 * scale,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16 * scale)),
            child: SizedBox(
              height: 120 * scale,
              width: double.infinity,
              child: Image.network(venue.imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(venue.name, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
                SizedBox(height: 6 * scale),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                    SizedBox(width: 4 * scale),
                    Text(venue.rating.toStringAsFixed(1), style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                    const Spacer(),
                    Text(venue.priceLabel, style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 6 * scale),
                Text(venue.distanceLabel, style: GoogleFonts.inter(color: const Color(0xFF94A3B8), fontSize: 12 * scale)),
                SizedBox(height: 12 * scale),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: controller.onViewSimilar,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF176BFF),
                      side: const BorderSide(color: Color(0xFF176BFF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                    ),
                    child: Text('Voir le terrain', style: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600)),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.scale, required this.title, this.trailing});

  final double scale;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _GalleryIndicator extends StatelessWidget {
  const _GalleryIndicator({required this.scale, required this.count, required this.index});

  final double scale;
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: EdgeInsets.symmetric(horizontal: 4 * scale),
          width: i == index ? 16 * scale : 8 * scale,
          height: 8 * scale,
          decoration: BoxDecoration(
            color: i == index ? Colors.white : Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _CircleOverlayButton extends StatelessWidget {
  const _CircleOverlayButton({required this.scale, required this.icon, required this.onTap});

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
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 18 * scale),
      ),
    );
  }
}

class _QuickActionData {
  const _QuickActionData({required this.label, required this.icon, required this.color, required this.onTap});

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}

Color _backgroundForState(AvailabilityState state) {
  switch (state) {
    case AvailabilityState.available:
      return const Color(0x1916A34A);
    case AvailabilityState.limited:
      return const Color(0x19F59E0B);
    case AvailabilityState.full:
      return const Color(0x19EF4444);
  }
}

Color _borderForState(AvailabilityState state) {
  switch (state) {
    case AvailabilityState.available:
      return const Color(0xFF16A34A);
    case AvailabilityState.limited:
      return const Color(0xFFF59E0B);
    case AvailabilityState.full:
      return const Color(0xFFEF4444);
  }
}

Color _textForState(AvailabilityState state) {
  switch (state) {
    case AvailabilityState.available:
      return const Color(0xFF16A34A);
    case AvailabilityState.limited:
      return const Color(0xFFF59E0B);
    case AvailabilityState.full:
      return const Color(0xFFEF4444);
  }
}

String _stateLabel(AvailabilityState state) {
  switch (state) {
    case AvailabilityState.available:
      return 'Disponible';
    case AvailabilityState.limited:
      return 'Limité';
    case AvailabilityState.full:
      return 'Complet';
  }
}

