import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final String userName = 'Anna';
  final String userAvatar = 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60';

  List<BookingMetric> get metrics => const [
        BookingMetric(label: 'Réservations', value: '12', accent: Color(0xFF16A34A)),
        BookingMetric(label: 'Partenaires', value: '8', accent: Color(0xFFFFB800)),
        BookingMetric(label: 'Matchs', value: '24', accent: Color(0xFF0EA5E9)),
      ];

  List<BookingCard> get recentBookings => const [
        BookingCard(
          title: 'Terrain de Football',
          subtitle: 'Complexe Sportif Central',
          status: BookingStatus.confirmed,
          dateLabel: "Aujourd'hui 18h",
          icon: Icons.sports_soccer_rounded,
          accent: Color(0xFF16A34A),
        ),
        BookingCard(
          title: 'Court de Basket',
          subtitle: 'Salle Municipale Nord',
          status: BookingStatus.pending,
          dateLabel: 'Demain 20h',
          icon: Icons.sports_basketball_rounded,
          accent: Color(0xFFF59E0B),
        ),
      ];

  List<BookingCategory> get categories => const [
        BookingCategory(
          name: 'Football',
          description: '24 établissements disponibles',
          tag: 'Populaire',
          tagColor: Color(0xFF16A34A),
          gradient: [Color(0xFF16A34A), Color(0xFF15803D)],
        ),
        BookingCategory(
          name: 'Basket',
          description: '18 établissements disponibles',
          tag: 'Nouveau',
          tagColor: Color(0xFF0EA5E9),
          gradient: [Color(0xFFF59E0B), Color(0xFFD97706)],
        ),
        BookingCategory(
          name: 'Danse',
          description: '12 studios disponibles',
          tag: 'Trending',
          tagColor: Color(0xFFEC4899),
          gradient: [Color(0xFFEC4899), Color(0xFFDB2777)],
        ),
        BookingCategory(
          name: 'Tennis de table',
          description: '15 salles disponibles',
          tag: 'Standard',
          tagColor: Color(0xFF4B5563),
          gradient: [Color(0xFFEF4444), Color(0xFFDC2626)],
        ),
        BookingCategory(
          name: 'Natation',
          description: '8 piscines disponibles',
          tag: 'Premium',
          tagColor: Color(0xFF3B82F6),
          gradient: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
        ),
        BookingCategory(
          name: 'Tennis',
          description: '20 courts disponibles',
          tag: 'Elite',
          tagColor: Color(0xFFA855F7),
          gradient: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
        ),
      ];

  List<RecommendedVenue> get recommendedVenues => const [
        RecommendedVenue(
          name: 'FitZone Premium',
          description: 'Centre de fitness complet • 2.5 km',
          rating: '4.8',
          priceLabel: 'À partir de 15€/h',
          accent: Color(0xFF16A34A),
          imageUrl: 'https://images.unsplash.com/photo-1558611848-73f7eb4001a1?auto=format&fit=crop&w=800&q=60',
        ),
        RecommendedVenue(
          name: 'Aqua Center',
          description: 'Piscine olympique • 1.8 km',
          rating: '4.6',
          priceLabel: 'À partir de 12€/h',
          accent: Color(0xFF0EA5E9),
          imageUrl: 'https://images.unsplash.com/photo-1505849864904-01c3173b8249?auto=format&fit=crop&w=800&q=60',
        ),
      ];

  List<HistoricalBooking> get history => const [
        HistoricalBooking(
          title: 'Football - Terrain A',
          venue: 'SportCity Complex',
          status: BookingStatus.completed,
          dateRange: '15 Nov 2024 • 18h00-20h00',
          price: '45€',
          icon: Icons.sports_soccer_rounded,
          accent: Color(0xFF16A34A),
        ),
        HistoricalBooking(
          title: 'Basket - Court Central',
          venue: 'Gymnase Municipal',
          status: BookingStatus.cancelled,
          dateRange: '12 Nov 2024 • 20h00-22h00',
          price: '30€',
          icon: Icons.sports_basketball_rounded,
          accent: Color(0xFFF59E0B),
        ),
      ];

  List<QuickBookingAction> get quickActions => const [
        QuickBookingAction(
          label: 'Créer un événement',
          helper: 'Organisez votre match',
          accent: Color(0xFF176BFF),
          icon: Icons.upcoming_rounded,
        ),
        QuickBookingAction(
          label: 'Trouver partenaires',
          helper: 'Rejoignez une équipe',
          accent: Color(0xFFFFB800),
          icon: Icons.groups_rounded,
        ),
      ];

  List<BottomShortcut> get bottomShortcuts => const [
        BottomShortcut(label: 'À la une', icon: Icons.home_filled),
        BottomShortcut(label: 'Trouver', icon: Icons.search_rounded),
        BottomShortcut(label: 'Réserver', icon: Icons.calendar_month_rounded, isActive: true),
        BottomShortcut(label: 'Messages', icon: Icons.chat_bubble_outline_rounded),
        BottomShortcut(label: 'Profil', icon: Icons.person_outline_rounded),
      ];

  void onSearchTap() {
    Get.snackbar('Recherche', 'Bientôt vous pourrez filtrer les établissements.');
  }

  void onNotificationTap() {
    Get.snackbar('Notifications', 'Aucune nouvelle notification.');
  }

  void onBookingShortcutsTap() {
    Get.snackbar('Historique', 'Vos réservations récentes arrivent bientôt.');
  }

  void onCreateBooking() {
    Get.snackbar('Nouvelle réservation', 'Démarrer une nouvelle réservation dans une prochaine version.');
  }

  void onQuickActionTap(QuickBookingAction action) {
    Get.snackbar(action.label, action.helper);
  }

  void onCategoryTap(BookingCategory category) {
    Get.snackbar(category.name, 'Ouverture des établissements ${category.name} prochainement.');
  }

  void onVenueTap(RecommendedVenue venue) {
    Get.snackbar(venue.name, 'Détails de ${venue.name} à venir.');
  }

  void onHistoryTap(HistoricalBooking booking) {
    Get.snackbar(booking.title, 'Détails de la réservation en cours de préparation.');
  }

  void onBottomShortcutTap(BottomShortcut shortcut) {
    Get.snackbar(shortcut.label, 'Navigation vers ${shortcut.label}.');
  }
}

class BookingMetric {
  const BookingMetric({required this.label, required this.value, required this.accent});

  final String label;
  final String value;
  final Color accent;
}

enum BookingStatus { confirmed, pending, completed, cancelled }

class BookingCard {
  const BookingCard({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.dateLabel,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final BookingStatus status;
  final String dateLabel;
  final IconData icon;
  final Color accent;
}

class BookingCategory {
  const BookingCategory({
    required this.name,
    required this.description,
    required this.tag,
    required this.tagColor,
    required this.gradient,
  });

  final String name;
  final String description;
  final String tag;
  final Color tagColor;
  final List<Color> gradient;
}

class RecommendedVenue {
  const RecommendedVenue({
    required this.name,
    required this.description,
    required this.rating,
    required this.priceLabel,
    required this.accent,
    required this.imageUrl,
  });

  final String name;
  final String description;
  final String rating;
  final String priceLabel;
  final Color accent;
  final String imageUrl;
}

class HistoricalBooking {
  const HistoricalBooking({
    required this.title,
    required this.venue,
    required this.status,
    required this.dateRange,
    required this.price,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String venue;
  final BookingStatus status;
  final String dateRange;
  final String price;
  final IconData icon;
  final Color accent;
}

class QuickBookingAction {
  const QuickBookingAction({
    required this.label,
    required this.helper,
    required this.accent,
    required this.icon,
  });

  final String label;
  final String helper;
  final Color accent;
  final IconData icon;
}

class BottomShortcut {
  const BottomShortcut({required this.label, required this.icon, this.isActive = false});

  final String label;
  final IconData icon;
  final bool isActive;
}
