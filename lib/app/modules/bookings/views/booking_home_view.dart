import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/bottom_navigation/bottom_nav_widget.dart';
import '../controllers/booking_controller.dart';

class BookingHomeView extends GetView<BookingController> {
  const BookingHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: const Color(0xFFF8FAFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const designWidth = 375.0;
          final maxWidth = constraints.hasBoundedWidth
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width;
          final scale = (maxWidth / designWidth).clamp(0.85, 1.08);

          return SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 96 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Header(scale: scale),
                        SizedBox(height: 16 * scale),
                        _SearchBar(scale: scale),
                        SizedBox(height: 16 * scale),
                        _MetricsRow(scale: scale),
                        SizedBox(height: 24 * scale),
                        _HeroReservation(scale: scale),
                        SizedBox(height: 24 * scale),
                        _RecentBookings(scale: scale),
                        SizedBox(height: 28 * scale),
                        _CategoryGrid(scale: scale),
                        SizedBox(height: 28 * scale),
                        _RecommendedVenues(scale: scale),
                        SizedBox(height: 28 * scale),
                        _QuickActions(scale: scale),
                        SizedBox(height: 28 * scale),
                        _HistorySection(scale: scale),
                        SizedBox(height: 32 * scale),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _FloatingCreateButton(scale: scale),
                      SizedBox(height: 12 * scale),
                      const BottomNavWidget(),
                    ],
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

class _Header extends GetView<BookingController> {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12 * scale,
            offset: Offset(0, 4 * scale),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20 * scale,
            backgroundImage: NetworkImage(controller.userAvatar),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey, ${controller.userName} !',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0B1220),
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  'Prête pour votre prochaine session ?',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14 * scale,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12 * scale),
          _CircleIconButton(
            scale: scale,
            icon: Icons.notifications_none_rounded,
            onTap: controller.onNotificationTap,
          ),
          SizedBox(width: 8 * scale),
          _CircleIconButton(
            scale: scale,
            icon: Icons.calendar_month_rounded,
            onTap: controller.onBookingShortcutsTap,
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends GetView<BookingController> {
  const _SearchBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: GestureDetector(
        onTap: controller.onSearchTap,
        child: Container(
          height: 58 * scale,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12 * scale,
                offset: Offset(0, 4 * scale),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 24 * scale, color: const Color(0xFF94A3B8)),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  'Partenaires ou salle de sport...',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFADAEBC),
                    fontSize: 16 * scale,
                  ),
                ),
              ),
              Container(
                width: 44 * scale,
                height: 44 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF176BFF),
                  borderRadius: BorderRadius.circular(12 * scale),
                ),
                child: Icon(Icons.tune_rounded, color: Colors.white, size: 20 * scale),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricsRow extends GetView<BookingController> {
  const _MetricsRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final metrics = controller.metrics;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Row(
        children: metrics
            .map(
              (metric) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: metric == metrics.last ? 0 : 12 * scale),
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10 * scale,
                        offset: Offset(0, 4 * scale),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40 * scale,
                        height: 40 * scale,
                        decoration: BoxDecoration(
                          color: metric.accent.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          metric.value,
                          style: GoogleFonts.poppins(
                            color: metric.accent,
                            fontSize: 18 * scale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * scale),
                      Text(
                        metric.label,
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
    );
  }
}

class _HeroReservation extends StatelessWidget {
  const _HeroReservation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Réserver une salle ou terrain',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 24 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12 * scale),
          Text(
            'Choisissez votre sport et trouvez le lieu parfait',
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 16 * scale,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentBookings extends GetView<BookingController> {
  const _RecentBookings({required this.scale});

  final double scale;

  Color _statusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return const Color(0xFF16A34A);
      case BookingStatus.pending:
        return const Color(0xFFF59E0B);
      case BookingStatus.completed:
        return const Color(0xFF16A34A);
      case BookingStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }

  String _statusLabel(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
        return 'Confirmé';
      case BookingStatus.pending:
        return 'En attente';
      case BookingStatus.completed:
        return 'Terminé';
      case BookingStatus.cancelled:
        return 'Annulé';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookings = controller.recentBookings;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Réservations récentes',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: controller.onBookingShortcutsTap,
                child: Text(
                  'Voir tout',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          SizedBox(
            height: 110 * scale,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: bookings.length,
              separatorBuilder: (_, __) => SizedBox(width: 14 * scale),
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Container(
                  width: 200 * scale,
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12 * scale,
                        offset: Offset(0, 4 * scale),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36 * scale,
                            height: 36 * scale,
                            decoration: BoxDecoration(
                              color: booking.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12 * scale),
                            ),
                            child: Icon(booking.icon, color: booking.accent, size: 20 * scale),
                          ),
                          SizedBox(width: 12 * scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.title,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF0B1220),
                                    fontSize: 14 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4 * scale),
                                Text(
                                  booking.subtitle,
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
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                            decoration: BoxDecoration(
                              color: _statusColor(booking.status).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(999 * scale),
                            ),
                            child: Text(
                              _statusLabel(booking.status),
                              style: GoogleFonts.inter(
                                color: _statusColor(booking.status),
                                fontSize: 12 * scale,
                              ),
                            ),
                          ),
                          SizedBox(width: 12 * scale),
                          Expanded(
                            child: Text(
                              booking.dateLabel,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 12 * scale,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryGrid extends GetView<BookingController> {
  const _CategoryGrid({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final categories = controller.categories;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Wrap(
        spacing: 14 * scale,
        runSpacing: 16 * scale,
        children: categories
            .map(
              (category) => GestureDetector(
                onTap: () => controller.onCategoryTap(category),
                child: Container(
                  width: 163.5 * scale,
                  height: 250 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12 * scale,
                        offset: Offset(0, 4 * scale),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 96 * scale,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: category.gradient,
                            begin: const Alignment(0.35, 0.35),
                            end: const Alignment(1.06, -0.35),
                          ),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16 * scale)),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Opacity(
                            opacity: 0.2,
                            child: Icon(Icons.sports, color: Colors.white, size: 48 * scale),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16 * scale),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 16 * scale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8 * scale),
                              Text(
                                category.description,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF475569),
                                  fontSize: 13 * scale,
                                  height: 1.4,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                                    decoration: BoxDecoration(
                                      color: category.tagColor.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(999 * scale),
                                    ),
                                    child: Text(
                                      category.tag,
                                      style: GoogleFonts.inter(
                                        color: category.tagColor,
                                        fontSize: 12 * scale,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'Voir',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF176BFF),
                                      fontSize: 14 * scale,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
    );
  }
}

class _RecommendedVenues extends GetView<BookingController> {
  const _RecommendedVenues({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final venues = controller.recommendedVenues;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Établissements recommandés',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => controller.onBookingShortcutsTap(),
                child: Text(
                  'Voir tout',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          ...venues.map((venue) => _RecommendedVenueCard(scale: scale, venue: venue)),
        ],
      ),
    );
  }
}

class _RecommendedVenueCard extends GetView<BookingController> {
  const _RecommendedVenueCard({required this.scale, required this.venue});

  final double scale;
  final RecommendedVenue venue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onVenueTap(venue),
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12 * scale,
              offset: Offset(0, 4 * scale),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64 * scale,
              height: 64 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * scale),
                image: DecorationImage(image: NetworkImage(venue.imageUrl), fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    venue.name,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0B1220),
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    venue.description,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF475569),
                      fontSize: 13 * scale,
                    ),
                  ),
                  SizedBox(height: 10 * scale),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: venue.accent, size: 16 * scale),
                      SizedBox(width: 6 * scale),
                      Text(
                        venue.rating,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0B1220),
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 16 * scale),
                      Text(
                        venue.priceLabel,
                        style: GoogleFonts.inter(
                          color: venue.accent,
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends GetView<BookingController> {
  const _QuickActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final actions = controller.quickActions;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actions rapides',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B1220),
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16 * scale),
          Row(
            children: actions
                .map(
                  (action) => Expanded(
                    child: GestureDetector(
                      onTap: () => controller.onQuickActionTap(action),
                      child: Container(
                        margin: EdgeInsets.only(right: action == actions.last ? 0 : 12 * scale),
                        padding: EdgeInsets.all(16 * scale),
                        decoration: BoxDecoration(
                          color: action.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16 * scale),
                          border: Border.all(color: action.accent.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40 * scale,
                              height: 40 * scale,
                              decoration: BoxDecoration(
                                color: action.accent,
                                borderRadius: BorderRadius.circular(12 * scale),
                              ),
                              child: Icon(action.icon, color: Colors.white, size: 20 * scale),
                            ),
                            SizedBox(width: 12 * scale),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    action.label,
                                    style: GoogleFonts.inter(
                                      color: action.accent,
                                      fontSize: 16 * scale,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4 * scale),
                                  Text(
                                    action.helper,
                                    style: GoogleFonts.inter(
                                      color: action.accent.withValues(alpha: 0.8),
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
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _HistorySection extends GetView<BookingController> {
  const _HistorySection({required this.scale});

  final double scale;

  Color _statusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.completed:
        return const Color(0xFF16A34A);
      case BookingStatus.cancelled:
        return const Color(0xFFEF4444);
      case BookingStatus.confirmed:
        return const Color(0xFF16A34A);
      case BookingStatus.pending:
        return const Color(0xFFF59E0B);
    }
  }

  String _statusLabel(BookingStatus status) {
    switch (status) {
      case BookingStatus.completed:
        return 'Terminé';
      case BookingStatus.cancelled:
        return 'Annulé';
      case BookingStatus.confirmed:
        return 'Confirmé';
      case BookingStatus.pending:
        return 'En attente';
    }
  }

  @override
  Widget build(BuildContext context) {
    final history = controller.history;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historique récent',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B1220),
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: controller.onBookingShortcutsTap,
                child: Text(
                  'Tout voir',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF176BFF),
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          ...history.map(
            (booking) => GestureDetector(
              onTap: () => controller.onHistoryTap(booking),
              child: Container(
                margin: EdgeInsets.only(bottom: 12 * scale),
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10 * scale,
                      offset: Offset(0, 4 * scale),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32 * scale,
                          height: 32 * scale,
                          decoration: BoxDecoration(
                            color: booking.accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                          child: Icon(booking.icon, color: booking.accent, size: 18 * scale),
                        ),
                        SizedBox(width: 12 * scale),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.title,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0B1220),
                                  fontSize: 14 * scale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4 * scale),
                              Text(
                                booking.venue,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF475569),
                                  fontSize: 12 * scale,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                          decoration: BoxDecoration(
                            color: _statusColor(booking.status).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999 * scale),
                          ),
                          child: Text(
                            _statusLabel(booking.status),
                            style: GoogleFonts.inter(
                              color: _statusColor(booking.status),
                              fontSize: 12 * scale,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * scale),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            booking.dateRange,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF475569),
                              fontSize: 12 * scale,
                            ),
                          ),
                        ),
                        Text(
                          booking.price,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0B1220),
                            fontSize: 12 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingCreateButton extends GetView<BookingController> {
  const _FloatingCreateButton({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: controller.onCreateBooking,
          backgroundColor: const Color(0xFF176BFF),
          shape: const CircleBorder(),
          child: Icon(Icons.add_rounded, size: 28 * scale, color: Colors.white),
        ),
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
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, size: 20 * scale, color: const Color(0xFF0B1220)),
      ),
    );
  }
}
