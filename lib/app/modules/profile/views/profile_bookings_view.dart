import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_bookings_controller.dart';

class ProfileBookingsView extends GetView<ProfileBookingsController> {
  const ProfileBookingsView({super.key});

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
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 120 * scale),
                        child: Column(
                          children: [
                            _Header(scale: scale),
                            _Tabs(scale: scale),
                            Obx(
                              () {
                                final tab = controller.activeTab.value;
                                if (tab == BookingTab.upcoming) {
                                  return Column(
                                    children: [
                                      _SummaryRow(scale: scale, metrics: controller.upcomingMetrics),
                                      _FilterRow(scale: scale),
                                      _BookingList(scale: scale, isPast: false),
                                    ],
                                  );
                                }
                                return Column(
                                  children: [
                                    _HistorySummary(scale: scale, metrics: controller.historyMetrics),
                                    _HistoryActions(scale: scale),
                                    _BookingList(scale: scale, isPast: true),
                                    _MonthlySummaryCard(scale: scale, summary: controller.monthlySummary),
                                    _HistoryCta(scale: scale),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _BottomNavigation(scale: scale),
                ),
                Positioned(
                  right: 20 * scale,
                  bottom: 96 * scale + MediaQuery.of(context).padding.bottom,
                  child: _FloatingCTA(scale: scale),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          _RoundButton(
            scale: scale,
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: Get.back,
          ),
          SizedBox(width: 12 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mes réservations', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 20 * scale, fontWeight: FontWeight.w700)),
              SizedBox(height: 2 * scale),
              Text('À venir', style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale)),
            ],
          ),
          const Spacer(),
          _RoundButton(
            scale: scale,
            icon: Icons.notifications_none_rounded,
            onTap: () => Get.snackbar('Notifications', 'Vous êtes à jour !'),
          ),
        ],
      ),
    );
  }
}

class _Tabs extends GetView<ProfileBookingsController> {
  const _Tabs({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16 * scale, 14 * scale, 16 * scale, 14 * scale),
      child: Container(
        height: 48 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12 * scale),
        ),
        padding: EdgeInsets.all(4 * scale),
        child: Obx(
          () => Row(
            children: BookingTab.values.map((tab) {
              final isSelected = controller.activeTab.value == tab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.switchTab(tab),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    decoration: BoxDecoration(
                      gradient: isSelected ? const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]) : null,
                      color: isSelected ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(8 * scale),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10 * scale),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_tabIcon(tab), size: 18 * scale, color: isSelected ? Colors.white : const Color(0xFF64748B)),
                        SizedBox(height: 6 * scale),
                        Text(
                          _tabLabel(tab),
                          style: GoogleFonts.inter(
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                            fontSize: 13 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  IconData _tabIcon(BookingTab tab) {
    switch (tab) {
      case BookingTab.upcoming:
        return Icons.calendar_month_rounded;
      case BookingTab.past:
        return Icons.history_rounded;
    }
  }

  String _tabLabel(BookingTab tab) {
    switch (tab) {
      case BookingTab.upcoming:
        return 'À venir';
      case BookingTab.past:
        return 'Passées';
    }
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.scale, required this.metrics});

  final double scale;
  final SummaryMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16 * scale, right: 16 * scale, bottom: 16 * scale),
      child: Row(
        children: [
          Expanded(
            child: _SummaryCard(
              scale: scale,
              gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
              value: metrics.upcoming.toString(),
              label: 'À venir',
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: _SummaryCard(
              scale: scale,
              gradient: const LinearGradient(colors: [Color(0xFF16A34A), Color(0xFF16A34A)]),
              value: metrics.completed.toString(),
              label: 'Réalisées',
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: _SummaryCard(
              scale: scale,
              gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)]),
              value: '${metrics.totalSpent ~/ 1}€',
              label: 'Dépensé',
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.scale, required this.gradient, required this.value, required this.label});

  final double scale;
  final Gradient gradient;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90 * scale,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16 * scale),
      ),
      padding: EdgeInsets.all(16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text(label, style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 12 * scale)),
        ],
      ),
    );
  }
}

class _FilterRow extends GetView<ProfileBookingsController> {
  const _FilterRow({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16 * scale, 14 * scale, 16 * scale, 14 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Filtrer par sport', style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600)),
              const Spacer(),
              TextButton(
                onPressed: () => Get.snackbar('Filtres', 'Effacement des filtres prochainement.'),
                child: Text('Tout effacer', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          SizedBox(
            height: 38 * scale,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.activeFilters.length,
              separatorBuilder: (_, __) => SizedBox(width: 10 * scale),
              itemBuilder: (context, index) {
                final label = controller.activeFilters[index];
                final selected = index == 0;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFF176BFF) : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: selected ? const Color(0xFF176BFF) : const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.sports_soccer_rounded, size: 16 * scale, color: selected ? Colors.white : const Color(0xFF475569)),
                      SizedBox(width: 8 * scale),
                      Text(
                        label,
                        style: GoogleFonts.inter(color: selected ? Colors.white : const Color(0xFF475569), fontSize: 13 * scale, fontWeight: FontWeight.w500),
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

class _BookingList extends GetView<ProfileBookingsController> {
  const _BookingList({required this.scale, required this.isPast});

  final double scale;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final bookings = isPast ? controller.pastBookings : controller.upcomingBookings;

    if (bookings.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 32 * scale),
        child: Column(
          children: [
            Icon(
              isPast ? Icons.history_toggle_off_rounded : Icons.hourglass_empty_rounded,
              color: const Color(0xFF94A3B8),
              size: 48 * scale,
            ),
            SizedBox(height: 12 * scale),
            Text(
              isPast ? 'Aucune réservation passée' : 'Aucune réservation à venir',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 16 * scale, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8 * scale),
            Text(
              isPast
                  ? 'Votre historique apparaîtra ici une fois vos activités terminées.'
                  : 'Planifiez une nouvelle session pour la voir apparaître ici.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 13 * scale, height: 1.5),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 0),
      child: Column(
        children: bookings
            .map(
              (booking) => _BookingCard(
                scale: scale,
                booking: booking,
                isPast: isPast,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.scale, required this.booking, required this.isPast});

  final double scale;
  final BookingCard booking;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileBookingsController>();
    final statusColor = bookingStatusColor(booking.status);
    final isCancelled = booking.status == BookingStatus.cancelled;
    final infoColor = isPast ? const Color(0xFF475569) : booking.sportColor;
    final baseBorderColor = isPast && isCancelled ? const Color(0xFFFECACA) : const Color(0xFFE2E8F0);
    final backgroundColor = isPast && isCancelled ? const Color(0xFFFFF7ED) : Colors.white;

    return Container(
      margin: EdgeInsets.only(bottom: 16 * scale),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(color: baseBorderColor),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12 * scale, offset: Offset(0, 6 * scale)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18 * scale)),
                child: AspectRatio(
                  aspectRatio: 343 / 192,
                  child: Image.network(booking.heroImage, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                left: 16 * scale,
                top: 16 * scale,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(
                    color: booking.sportColor,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white, width: 1 * scale),
                  ),
                  child: Text(
                    booking.sportLabel,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Positioned(
                right: 16 * scale,
                top: 16 * scale,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isPast || !isCancelled)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B1220).withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          booking.priceLabel,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 13 * scale, fontWeight: FontWeight.w600),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              booking.priceLabel,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF475569),
                                fontSize: 13 * scale,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          if (booking.refundLabel != null) ...[
                            SizedBox(height: 6 * scale),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                booking.refundLabel!,
                                style: GoogleFonts.inter(color: const Color(0xFF16A34A), fontSize: 11 * scale, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ],
                      ),
                    SizedBox(height: 8 * scale),
                    _IconBadge(
                      scale: scale,
                      icon: Icons.more_horiz_rounded,
                      onTap: () => controller.openActions(booking, scale, isPast: isPast),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 16 * scale),
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
                          Text(booking.venueName, style: GoogleFonts.poppins(color: const Color(0xFF0B1220), fontSize: 17 * scale, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4 * scale),
                          Text(booking.venueSubtitle, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 13 * scale)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        bookingStatusLabel(booking.status),
                        style: GoogleFonts.inter(color: statusColor, fontSize: 12 * scale, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                if (isPast && booking.rating != null) ...[
                  SizedBox(height: 8 * scale),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: const Color(0xFFFFB800), size: 16 * scale),
                      SizedBox(width: 6 * scale),
                      Text(
                        'Vous avez noté ${booking.rating!.toStringAsFixed(1)}',
                        style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 12.5 * scale, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 12 * scale),
                _InfoRow(
                  scale: scale,
                  icon: Icons.calendar_today_rounded,
                  label: booking.dateLabel,
                  color: infoColor,
                ),
                if (booking.timeLabel != null) ...[
                  SizedBox(height: 8 * scale),
                  _InfoRow(
                    scale: scale,
                    icon: Icons.access_time_rounded,
                    label: booking.timeLabel!,
                    color: infoColor,
                  ),
                ],
                SizedBox(height: 8 * scale),
                _InfoRow(
                  scale: scale,
                  icon: Icons.timelapse_rounded,
                  label: booking.durationLabel,
                  color: infoColor,
                ),
                if (booking.areaLabel != null) ...[
                  SizedBox(height: 8 * scale),
                  _InfoRow(
                    scale: scale,
                    icon: Icons.place_outlined,
                    label: booking.areaLabel!,
                    color: infoColor,
                  ),
                ],
                if (!isPast) ...[
                  SizedBox(height: 16 * scale),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                        decoration: BoxDecoration(
                          color: bookingStatusColor(booking.status).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.group_rounded, size: 16 * scale, color: bookingStatusColor(booking.status)),
                            SizedBox(width: 6 * scale),
                            Text(booking.participantsLabel, style: GoogleFonts.inter(color: bookingStatusColor(booking.status), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline_rounded, size: 16 * scale, color: const Color(0xFF6B7280)),
                            SizedBox(width: 6 * scale),
                            Text(booking.groupTypeLabel, style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  SizedBox(height: 16 * scale),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.group_outlined, size: 16 * scale, color: const Color(0xFF475569)),
                            SizedBox(width: 6 * scale),
                            Text(booking.participantsLabel, style: GoogleFonts.inter(color: const Color(0xFF475569), fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14 * scale, vertical: 8 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline_rounded, size: 16 * scale, color: const Color(0xFF6B7280)),
                            SizedBox(width: 6 * scale),
                            Text(booking.groupTypeLabel, style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12 * scale, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                if (!isPast && booking.cancellationInfo != null) ...[
                  SizedBox(height: 12 * scale),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded, size: 16 * scale, color: const Color(0xFF64748B)),
                      SizedBox(width: 8 * scale),
                      Expanded(
                        child: Text(
                          booking.cancellationInfo!,
                          style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 12.5 * scale, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 20 * scale),
                if (isPast)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => controller.openVenue(booking.venueId),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          icon: Icon(Icons.storefront_rounded, color: const Color(0xFF176BFF), size: 18 * scale),
                          label: Text('Voir l’établissement', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      if (booking.allowRate) ...[
                        SizedBox(width: 12 * scale),
                        TextButton(
                          onPressed: () => controller.rateBooking(booking),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFFFB800),
                            textStyle: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600),
                          ),
                          child: const Text('Noter'),
                        ),
                      ],
                      if (booking.allowRebook) ...[
                        SizedBox(width: 8 * scale),
                        TextButton(
                          onPressed: () => controller.rebook(booking),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF176BFF),
                            textStyle: GoogleFonts.inter(fontSize: 13 * scale, fontWeight: FontWeight.w600),
                          ),
                          child: const Text('Refaire'),
                        ),
                      ],
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => controller.openVenue(booking.venueId),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12 * scale)),
                            side: BorderSide(color: const Color(0xFF176BFF).withValues(alpha: 0.25)),
                          ),
                          icon: Icon(Icons.storefront_rounded, color: const Color(0xFF176BFF), size: 18 * scale),
                          label: Text('Voir l’établissement', style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 13 * scale, fontWeight: FontWeight.w600)),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.scale, required this.icon, required this.label, required this.color});

  final double scale;
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18 * scale),
        SizedBox(width: 10 * scale),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(color: color, fontSize: 13 * scale, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _HistorySummary extends StatelessWidget {
  const _HistorySummary({required this.scale, required this.metrics});

  final double scale;
  final HistoryMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16 * scale, 18 * scale, 16 * scale, 16 * scale),
      child: Row(
        children: [
          _HistoryStatTile(
            scale: scale,
            label: 'Sessions',
            value: metrics.sessions.toString(),
            accent: const Color(0xFF176BFF),
          ),
          SizedBox(width: 12 * scale),
          _HistoryStatTile(
            scale: scale,
            label: 'Temps total',
            value: '${metrics.totalHours}h',
            accent: const Color(0xFF16A34A),
          ),
          SizedBox(width: 12 * scale),
          _HistoryStatTile(
            scale: scale,
            label: 'Dépensé',
            value: '${metrics.totalSpent}€',
            accent: const Color(0xFFFFB800),
          ),
          SizedBox(width: 12 * scale),
          _HistoryStatTile(
            scale: scale,
            label: 'Note moy.',
            value: metrics.averageRating.toStringAsFixed(1),
            accent: const Color(0xFF6366F1),
          ),
        ],
      ),
    );
  }
}

class _HistoryStatTile extends StatelessWidget {
  const _HistoryStatTile({required this.scale, required this.label, required this.value, required this.accent});

  final double scale;
  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90 * scale,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: accent.withValues(alpha: 0.15)),
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(color: accent, fontSize: 20 * scale, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Text(
              label,
              style: GoogleFonts.inter(color: accent.withValues(alpha: 0.8), fontSize: 12 * scale),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryActions extends GetView<ProfileBookingsController> {
  const _HistoryActions({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final actions = controller.historyActions;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16 * scale, 8 * scale, 16 * scale, 16 * scale),
      child: Row(
        children: actions
            .map(
              (action) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6 * scale),
                  child: _HistoryActionButton(scale: scale, action: action),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _HistoryActionButton extends GetView<ProfileBookingsController> {
  const _HistoryActionButton({required this.scale, required this.action});

  final double scale;
  final HistoryQuickAction action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (action.label) {
          case 'Exporter':
            controller.exportHistory();
            break;
          case 'Statistiques':
            controller.openStats();
            break;
          case 'Favoris':
            controller.openFavorites();
            break;
          default:
            Get.snackbar(action.label, 'Fonctionnalité à venir.');
        }
      },
      child: Container(
        height: 52 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14 * scale),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon, color: action.color, size: 18 * scale),
            SizedBox(width: 8 * scale),
            Flexible(
              child: Text(
                action.label,
                style: GoogleFonts.inter(color: const Color(0xFF0B1220), fontSize: 13 * scale, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthlySummaryCard extends StatelessWidget {
  const _MonthlySummaryCard({required this.scale, required this.summary});

  final double scale;
  final MonthlySummary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 12 * scale, 16 * scale, 0),
      child: Container(
        height: 90 * scale,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFB800), Color(0xFFF59E0B)]),
          borderRadius: BorderRadius.circular(18 * scale),
        ),
        padding: EdgeInsets.all(18 * scale),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    summary.monthLabel,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 18 * scale, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    '${summary.reservations} réservations • ${summary.totalSpent}€',
                    style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.9), fontSize: 13 * scale),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${summary.totalHours}h',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 22 * scale, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4 * scale),
                Text('de sport', style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.85), fontSize: 13 * scale)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCta extends StatelessWidget {
  const _HistoryCta({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16 * scale, 16 * scale, 16 * scale, 0),
      child: OutlinedButton.icon(
        onPressed: () => Get.snackbar('Historique', 'Chargement de réservations supplémentaires prochainement.'),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14 * scale),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
          side: const BorderSide(color: Color(0xFF176BFF), width: 1.5),
        ),
        icon: Icon(Icons.history_rounded, color: const Color(0xFF176BFF), size: 18 * scale),
        label: Text(
          'Voir plus de réservations',
          style: GoogleFonts.inter(color: const Color(0xFF176BFF), fontSize: 14 * scale, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 84 * scale + bottomPadding,
      padding: EdgeInsets.only(top: 10 * scale, bottom: 16 * scale + bottomPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavItem(icon: Icons.home_rounded, label: 'Accueil'),
          _NavItem(icon: Icons.search_rounded, label: 'Explorer'),
          _NavItem(icon: Icons.calendar_month_rounded, label: 'Planning'),
          _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
          _NavItem(icon: Icons.person_rounded, label: 'Profil', active: true),
        ],
      ),
    );
  }
}

class _FloatingCTA extends StatelessWidget {
  const _FloatingCTA({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar('Réservation', 'Création d’une nouvelle réservation à venir.'),
      child: Container(
        width: 56 * scale,
        height: 56 * scale,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF176BFF), Color(0xFF0F5AE0)]),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(color: const Color(0x66176BFF), blurRadius: 18 * scale, offset: Offset(0, 10 * scale)),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(Icons.add_rounded, color: Colors.white, size: 28 * scale),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, this.active = false});

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? const Color(0xFF176BFF) : const Color(0xFF475569)),
        SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            color: active ? const Color(0xFF176BFF) : const Color(0xFF475569),
            fontSize: 12,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: active ? 24 : 0,
          height: 3,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF176BFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42 * scale,
        height: 42 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 18 * scale),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.scale, required this.icon, required this.onTap});

  final double scale;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36 * scale,
        height: 36 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: const Color(0xFF475569), size: 18 * scale),
      ),
    );
  }
}


