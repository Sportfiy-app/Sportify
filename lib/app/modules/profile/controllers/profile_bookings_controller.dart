import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileBookingsController extends GetxController {
  final Rx<BookingTab> activeTab = BookingTab.upcoming.obs;

  final List<BookingCard> upcomingBookings = const [
    BookingCard(
      id: 'b_001',
      venueName: 'Futsal Indoor 06',
      venueSubtitle: 'Terrain synthétique',
      sportLabel: 'Football',
      sportColor: Color(0xFF176BFF),
      dateLabel: 'Réservé le Lundi 15 janvier 2024',
      timeLabel: '14:00 - 16:00',
      durationLabel: 'Durée: 2 heures',
      areaLabel: 'Terrain A',
      priceLabel: '25€',
      status: BookingStatus.accepted,
      participantsLabel: '4 joueurs',
      groupTypeLabel: 'Solo',
      heroImage:
          'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_futsal_06',
      cancellationInfo: 'Annulation gratuite jusqu’à 4h avant le début.',
    ),
    BookingCard(
      id: 'b_002',
      venueName: 'Piscine Municipale Nice',
      venueSubtitle: 'Bassin olympique',
      sportLabel: 'Natation',
      sportColor: Color(0xFF0EA5E9),
      dateLabel: 'Réservé le Mercredi 17 janvier 2024',
      timeLabel: '18:30 - 19:30',
      durationLabel: 'Durée: 1 heure',
      areaLabel: 'Couloir 3',
      priceLabel: '12€',
      status: BookingStatus.accepted,
      participantsLabel: 'Séance libre',
      groupTypeLabel: 'Solo',
      heroImage:
          'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_pool_nice',
      cancellationInfo: 'Annulation gratuite jusqu’à 6h avant.',
    ),
    BookingCard(
      id: 'b_003',
      venueName: 'Basketball Arena',
      venueSubtitle: 'Terrain couvert',
      sportLabel: 'Basketball',
      sportColor: Color(0xFFF59E0B),
      dateLabel: 'Réservé le Samedi 20 janvier 2024',
      timeLabel: '16:00 - 17:30',
      durationLabel: 'Durée: 1h30',
      areaLabel: 'Terrain principal',
      priceLabel: '30€',
      status: BookingStatus.pending,
      participantsLabel: '6 joueurs',
      groupTypeLabel: 'Equipe',
      heroImage:
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_basket_arena',
      allowCancel: false,
      cancellationInfo: 'Annulation indisponible moins de 2h avant le début.',
      cancellationPenalty: 'Cette session commence bientôt. L’annulation n’est plus possible.',
    ),
    BookingCard(
      id: 'b_004',
      venueName: 'Club Tennis Elite',
      venueSubtitle: 'Court en terre battue',
      sportLabel: 'Tennis',
      sportColor: Color(0xFF16A34A),
      dateLabel: 'Réservé le Dimanche 21 janvier 2024',
      timeLabel: '10:00 - 12:00',
      durationLabel: 'Durée: 2 heures',
      areaLabel: 'Court 5',
      priceLabel: '45€',
      status: BookingStatus.accepted,
      participantsLabel: '2 joueurs',
      groupTypeLabel: 'Duo',
      heroImage:
          'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_tennis_elite',
      cancellationInfo: 'Des frais de 10€ peuvent s’appliquer si vous annulez moins de 24h avant.',
      cancellationPenalty:
          'Êtes-vous sûr de vouloir annuler cette réservation ? Des frais de 10€ seront retenus.',
    ),
  ];

  final List<BookingCard> pastBookings = const [
    BookingCard(
      id: 'p_001',
      venueName: 'Futsal Indoor 06',
      venueSubtitle: 'Terrain synthétique',
      sportLabel: 'Football',
      sportColor: Color(0xFF176BFF),
      dateLabel: 'Lundi 3 janvier 2024',
      timeLabel: '14:00 - 15:30',
      durationLabel: 'Durée: 1h30',
      areaLabel: 'Terrain A',
      priceLabel: '20€',
      status: BookingStatus.completed,
      participantsLabel: '4 joueurs',
      groupTypeLabel: 'Solo',
      heroImage:
          'https://images.unsplash.com/photo-1510832842230-87253f48d74d?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_futsal_06',
      rating: 4.9,
      allowRate: true,
      allowRebook: true,
    ),
    BookingCard(
      id: 'p_002',
      venueName: 'Tennis Club Elite',
      venueSubtitle: 'Court en terre battue',
      sportLabel: 'Tennis',
      sportColor: Color(0xFF16A34A),
      dateLabel: 'Samedi 28 décembre 2023',
      timeLabel: '16:00 - 17:00',
      durationLabel: 'Durée: 1 heure',
      areaLabel: 'Court 3',
      priceLabel: '35€',
      status: BookingStatus.completed,
      participantsLabel: '2 joueurs',
      groupTypeLabel: 'Duo',
      heroImage:
          'https://images.unsplash.com/photo-1549921296-3ecf9c4ebc44?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_tennis_elite',
      rating: 4.7,
      allowRate: true,
      allowRebook: true,
    ),
    BookingCard(
      id: 'p_003',
      venueName: 'Basket Arena Pro',
      venueSubtitle: 'Terrain premium',
      sportLabel: 'Basketball',
      sportColor: Color(0xFFF97316),
      dateLabel: 'Vendredi 22 décembre 2023',
      timeLabel: '19:00 - 20:30',
      durationLabel: 'Durée: 1h30',
      areaLabel: 'Terrain B',
      priceLabel: '25€',
      status: BookingStatus.cancelled,
      participantsLabel: '6 joueurs',
      groupTypeLabel: 'Equipe',
      heroImage:
          'https://images.unsplash.com/photo-1491295371433-5f0c9fc15dd1?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_basket_pro',
      refunded: true,
      refundLabel: 'Remboursé',
      allowRebook: true,
    ),
    BookingCard(
      id: 'p_004',
      venueName: 'Padel Central',
      venueSubtitle: 'Terrain extérieur',
      sportLabel: 'Padel',
      sportColor: Color(0xFF22C55E),
      dateLabel: 'Mercredi 20 décembre 2023',
      timeLabel: '18:30 - 20:00',
      durationLabel: 'Durée: 1h30',
      areaLabel: 'Terrain principal',
      priceLabel: '28€',
      status: BookingStatus.completed,
      participantsLabel: '4 joueurs',
      groupTypeLabel: 'Equipe',
      heroImage:
          'https://images.unsplash.com/photo-1600712243347-560a46ba7a14?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_padel_central',
      rating: 5.0,
      allowRate: true,
      allowRebook: true,
    ),
    BookingCard(
      id: 'p_005',
      venueName: 'Squash Club Premium',
      venueSubtitle: 'Salle climatisée',
      sportLabel: 'Squash',
      sportColor: Color(0xFF9333EA),
      dateLabel: 'Dimanche 17 décembre 2023',
      timeLabel: '10:00 - 11:00',
      durationLabel: 'Durée: 1 heure',
      areaLabel: 'Court 2',
      priceLabel: '22€',
      status: BookingStatus.completed,
      participantsLabel: '2 joueurs',
      groupTypeLabel: 'Duo',
      heroImage:
          'https://images.unsplash.com/photo-1540747913346-19e996a6cb88?auto=format&fit=crop&w=1200&q=60',
      venueId: 'venue_squash_premium',
      rating: 4.6,
      allowRate: true,
      allowRebook: true,
    ),
  ];

  final SummaryMetrics upcomingMetrics = const SummaryMetrics(
    upcoming: 4,
    completed: 28,
    totalSpent: 1200,
  );

  final HistoryMetrics historyMetrics = const HistoryMetrics(
    sessions: 47,
    totalHours: 124,
    totalSpent: 890,
    averageRating: 4.8,
  );

  final MonthlySummary monthlySummary = const MonthlySummary(
    monthLabel: 'Décembre 2023',
    reservations: 5,
    totalSpent: 147,
    totalHours: 8.5,
  );

  final List<String> activeFilters = const ['Football', 'Natation', 'Basketball'];

  final List<HistoryQuickAction> historyActions = const [
    HistoryQuickAction(
      icon: Icons.ios_share_rounded,
      label: 'Exporter',
      color: Color(0xFF176BFF),
    ),
    HistoryQuickAction(
      icon: Icons.insights_outlined,
      label: 'Statistiques',
      color: Color(0xFF0B1220),
    ),
    HistoryQuickAction(
      icon: Icons.favorite_border_rounded,
      label: 'Favoris',
      color: Color(0xFF475569),
    ),
  ];

  void switchTab(BookingTab tab) {
    activeTab.value = tab;
  }

  void openVenue(String venueId) {
    Get.toNamed(Routes.bookingPlaceDetail, arguments: venueId);
  }

  void openActions(BookingCard booking, double scale, {required bool isPast}) {
    final isUpcomingBooking = isUpcoming(booking) && !isPast;
    final sheet = isUpcomingBooking
        ? BookingUpcomingActionsSheet(scale: scale, booking: booking, controller: this)
        : BookingActionsSheet(scale: scale, booking: booking, controller: this);

    Get.bottomSheet(
      sheet,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  bool isUpcoming(BookingCard booking) =>
      booking.status == BookingStatus.accepted || booking.status == BookingStatus.pending;

  bool canCancel(BookingCard booking) => booking.allowCancel;

  void addToCalendar(BookingCard booking) {
    Get.back();
    Get.snackbar('Calendrier', 'Ajout de "${booking.venueName}" à votre calendrier bientôt disponible.');
  }

  void contactVenue(BookingCard booking) {
    Get.back();
    Get.snackbar('Contact', 'Nous contactons ${booking.venueName} pour vous.');
  }

  void promptCancellation(BookingCard booking) {
    Get.back();
    final penalty = booking.cancellationPenalty ??
        'Êtes-vous sûr de vouloir annuler cette réservation ? Cette action est irréversible.';
    Get.defaultDialog(
      title: 'Annuler cette réservation ?',
      middleText: penalty,
      textConfirm: 'Annuler',
      textCancel: 'Fermer',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        Get.back();
        _completeCancellation(booking);
      },
      onCancel: () {},
    );
  }

  void _completeCancellation(BookingCard booking) {
    Get.snackbar(
      'Réservation annulée',
      '"${booking.venueName}" a été annulée. Une notification a été envoyée à l’établissement.',
    );
  }

  void rateBooking(BookingCard booking) {
    Get.snackbar('Avis', 'Laissez un avis sur "${booking.venueName}" prochainement.');
  }

  void rebook(BookingCard booking) {
    Get.snackbar('Reprogrammer', 'Nous préparons une nouvelle session pour "${booking.venueName}".');
  }

  void exportHistory() {
    Get.snackbar('Exporter', 'Export de l’historique des réservations en préparation.');
  }

  void openStats() {
    Get.snackbar('Statistiques', 'Analyse détaillée à venir.');
  }

  void openFavorites() {
    Get.snackbar('Favoris', 'Gestion des établissements favoris prochainement.');
  }
}

enum BookingStatus { accepted, pending, cancelled, completed }

enum BookingTab { upcoming, past }

class BookingCard {
  const BookingCard({
    required this.id,
    required this.venueName,
    required this.venueSubtitle,
    required this.sportLabel,
    required this.sportColor,
    required this.dateLabel,
    this.timeLabel,
    required this.durationLabel,
    this.areaLabel,
    required this.priceLabel,
    required this.status,
    required this.participantsLabel,
    required this.groupTypeLabel,
    required this.heroImage,
    required this.venueId,
    this.rating,
    this.refunded = false,
    this.refundLabel,
    this.allowRate = false,
    this.allowRebook = false,
    this.allowCancel = true,
    this.cancellationInfo,
    this.cancellationPenalty,
  });

  final String id;
  final String venueName;
  final String venueSubtitle;
  final String sportLabel;
  final Color sportColor;
  final String dateLabel;
  final String? timeLabel;
  final String durationLabel;
  final String? areaLabel;
  final String priceLabel;
  final BookingStatus status;
  final String participantsLabel;
  final String groupTypeLabel;
  final String heroImage;
  final String venueId;
  final double? rating;
  final bool refunded;
  final String? refundLabel;
  final bool allowRate;
  final bool allowRebook;
  final bool allowCancel;
  final String? cancellationInfo;
  final String? cancellationPenalty;
}

class SummaryMetrics {
  const SummaryMetrics({
    required this.upcoming,
    required this.completed,
    required this.totalSpent,
  });

  final int upcoming;
  final int completed;
  final int totalSpent;
}

class HistoryMetrics {
  const HistoryMetrics({
    required this.sessions,
    required this.totalHours,
    required this.totalSpent,
    required this.averageRating,
  });

  final int sessions;
  final int totalHours;
  final int totalSpent;
  final double averageRating;
}

class MonthlySummary {
  const MonthlySummary({
    required this.monthLabel,
    required this.reservations,
    required this.totalSpent,
    required this.totalHours,
  });

  final String monthLabel;
  final int reservations;
  final int totalSpent;
  final double totalHours;
}

class HistoryQuickAction {
  const HistoryQuickAction({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}

class BookingUpcomingActionsSheet extends StatelessWidget {
  const BookingUpcomingActionsSheet({
    super.key,
    required this.scale,
    required this.booking,
    required this.controller,
  });

  final double scale;
  final BookingCard booking;
  final ProfileBookingsController controller;

  @override
  Widget build(BuildContext context) {
    final canCancel = controller.canCancel(booking);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20 * scale, offset: Offset(0, -10 * scale)),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20 * scale, 12 * scale, 20 * scale, 20 * scale + MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44 * scale,
                height: 4 * scale,
                decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(999)),
              ),
            ),
            SizedBox(height: 16 * scale),
            Text(
              'Gérer la réservation',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF94A3B8),
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16 * scale),
            Container(
              padding: EdgeInsets.all(14 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16 * scale),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoLine(
                    scale: scale,
                    icon: Icons.calendar_today_rounded,
                    label: booking.dateLabel,
                  ),
                  if (booking.timeLabel != null) ...[
                    SizedBox(height: 10 * scale),
                    _InfoLine(
                      scale: scale,
                      icon: Icons.access_time_rounded,
                      label: booking.timeLabel!,
                    ),
                  ],
                  SizedBox(height: 10 * scale),
                  _InfoLine(
                    scale: scale,
                    icon: Icons.timelapse_rounded,
                    label: booking.durationLabel,
                  ),
                ],
              ),
            ),
            if (booking.cancellationInfo != null) ...[
              SizedBox(height: 16 * scale),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded, size: 18 * scale, color: const Color(0xFF64748B)),
                  SizedBox(width: 8 * scale),
                  Expanded(
                    child: Text(
                      booking.cancellationInfo!,
                      style: TextStyle(color: const Color(0xFF64748B), fontSize: 13 * scale, height: 1.4),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 20 * scale),
            FilledButton(
              onPressed: canCancel ? () => controller.promptCancellation(booking) : null,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                disabledBackgroundColor: const Color(0xFFE2E8F0),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14 * scale)),
              ),
              child: Text(
                'Annuler la réservation',
                style: TextStyle(
                  color: canCancel ? Colors.white : const Color(0xFF94A3B8),
                  fontSize: 15 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (!canCancel) ...[
              SizedBox(height: 10 * scale),
              Text(
                booking.cancellationPenalty ?? 'Annulation indisponible à l’approche de la session.',
                style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.5 * scale, height: 1.4),
              ),
            ],
            SizedBox(height: 12 * scale),
            TextButton(
              onPressed: Get.back,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0B1220),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                textStyle: TextStyle(fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
              child: const Text('Annuler'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.scale, required this.icon, required this.label});

  final double scale;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18 * scale, color: const Color(0xFF475569)),
        SizedBox(width: 10 * scale),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class BookingActionsSheet extends StatelessWidget {
  const BookingActionsSheet({
    super.key,
    required this.scale,
    required this.booking,
    required this.controller,
  });

  final double scale;
  final BookingCard booking;
  final ProfileBookingsController controller;

  @override
  Widget build(BuildContext context) {
    final statusColor = bookingStatusColor(booking.status);
    final statusLabel = bookingStatusLabel(booking.status);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28 * scale)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20 * scale, offset: Offset(0, -10 * scale)),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20 * scale, 12 * scale, 20 * scale, 20 * scale + MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44 * scale,
                height: 4 * scale,
                decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(999)),
              ),
            ),
            SizedBox(height: 16 * scale),
            Text('Actions sur la réservation', style: TextStyle(color: const Color(0xFF0B1220), fontSize: 18 * scale, fontWeight: FontWeight.w600)),
            SizedBox(height: 12 * scale),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.venueName, style: TextStyle(color: const Color(0xFF0B1220), fontSize: 14 * scale, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4 * scale),
                      Text(booking.dateLabel, style: TextStyle(color: const Color(0xFF475569), fontSize: 12 * scale)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(999)),
                  child: Text(statusLabel, style: TextStyle(color: statusColor, fontSize: 12 * scale, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(height: 20 * scale),
            _ActionButton(
              scale: scale,
              icon: Icons.edit_calendar_rounded,
              label: 'Modifier la réservation',
              onTap: () {
                Get.back();
                Get.snackbar('Modifier', 'La modification de "${booking.venueName}" sera disponible prochainement.');
              },
            ),
            SizedBox(height: 10 * scale),
            _ActionButton(
              scale: scale,
              icon: Icons.event_available_rounded,
              label: 'Ajouter au calendrier',
              onTap: () => controller.addToCalendar(booking),
            ),
            SizedBox(height: 10 * scale),
            _ActionButton(
              scale: scale,
              icon: Icons.phone_in_talk_rounded,
              label: 'Contacter l’établissement',
              onTap: () => controller.contactVenue(booking),
            ),
            SizedBox(height: 10 * scale),
            _ActionButton(
              scale: scale,
              icon: Icons.cancel_outlined,
              label: 'Annuler la réservation',
              isDestructive: true,
              onTap: () => controller.promptCancellation(booking),
            ),
            SizedBox(height: 12 * scale),
            TextButton(
              onPressed: Get.back,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0B1220),
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                textStyle: TextStyle(fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
              child: const Text('Fermer'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.scale,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final double scale;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? const Color(0xFFEF4444) : const Color(0xFF0B1220);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 14 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(14 * scale),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20 * scale),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: color, fontSize: 14 * scale, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: const Color(0xFF94A3B8), size: 20 * scale),
          ],
        ),
      ),
    );
  }
}

Color bookingStatusColor(BookingStatus status) {
  switch (status) {
    case BookingStatus.accepted:
      return const Color(0xFF16A34A);
    case BookingStatus.pending:
      return const Color(0xFFF59E0B);
    case BookingStatus.cancelled:
      return const Color(0xFFEF4444);
    case BookingStatus.completed:
      return const Color(0xFF176BFF);
  }
}

String bookingStatusLabel(BookingStatus status) {
  switch (status) {
    case BookingStatus.accepted:
      return 'Acceptée';
    case BookingStatus.pending:
      return 'En attente';
    case BookingStatus.cancelled:
      return 'Annulée';
    case BookingStatus.completed:
      return 'Passée';
  }
}

