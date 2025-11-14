import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class BookingDetailController extends GetxController {
  final FacilityDetail facility = const FacilityDetail(
    name: 'Futsal Indoor 06',
    address: '125 Avenue des Diables Bleus, 06300 Nice',
    distanceLabel: '4 km • Nice, France',
    rating: 4.8,
    reviewCount: 182,
    priceLabel: '40€/h',
    heroImage:
        'https://images.unsplash.com/photo-1542751110-97427bbecf20?auto=format&fit=crop&w=1200&q=60',
    statusLabel: 'Disponible',
    statusColor: Color(0xFF16A34A),
  );

  final List<String> galleryImages = const [
    'https://images.unsplash.com/photo-1542751110-97427bbecf20?auto=format&fit=crop&w=1200&q=60',
    'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=1200&q=60',
    'https://images.unsplash.com/photo-1518301157678-3cd17226933d?auto=format&fit=crop&w=1200&q=60',
  ];

  final RxInt galleryIndex = 0.obs;

  final List<QuickFact> quickFacts = const [
    QuickFact(icon: Icons.sports_soccer_rounded, label: 'Sport', value: 'Football'),
    QuickFact(icon: Icons.groups_rounded, label: 'Format', value: '5 vs 5'),
    QuickFact(icon: Icons.schedule_rounded, label: 'Horaires', value: '07h - 23h'),
  ];

  final BookingPricing pricing = const BookingPricing(
    priceLabel: '40€',
    priceSuffix: '/heure',
    highlight: 'Réservation instantanée',
    secondary: 'Annulation gratuite jusqu\'à 2h avant',
  );

  List<FacilityAmenity> get amenities => const [
        FacilityAmenity(label: 'Vestiaires', icon: Icons.shopping_bag, color: Color(0xFF176BFF)),
        FacilityAmenity(label: 'Douches', icon: Icons.shower_rounded, color: Color(0xFF176BFF)),
        FacilityAmenity(label: 'Parking', icon: Icons.local_parking_rounded, color: Color(0xFF176BFF)),
        FacilityAmenity(label: 'Wi-Fi', icon: Icons.wifi_rounded, color: Color(0xFF176BFF)),
        FacilityAmenity(label: 'Snack', icon: Icons.local_cafe_rounded, color: Color(0xFF176BFF)),
        FacilityAmenity(label: 'Casiers', icon: Icons.lock_outline_rounded, color: Color(0xFF176BFF)),
      ];

  List<AvailabilitySlot> get dailyAvailabilities => const [
        AvailabilitySlot(time: '18h00', state: AvailabilityState.available),
        AvailabilitySlot(time: '19h00', state: AvailabilityState.available),
        AvailabilitySlot(time: '20h00', state: AvailabilityState.limited),
        AvailabilitySlot(time: '21h00', state: AvailabilityState.full),
        AvailabilitySlot(time: '22h00', state: AvailabilityState.full),
      ];

  final AvailabilityHighlight highlight = const AvailabilityHighlight(
    label: 'Réduction -20% après 20h',
    color: Color(0xFF0EA5E9),
  );

  List<ContactChannel> get contactChannels => const [
        ContactChannel(
          title: 'Téléphone',
          subtitle: 'Appelez directement',
          value: '+33 4 93 12 34 56',
          icon: Icons.phone_rounded,
          background: Color(0x19176BFF),
          actionLabel: 'Appeler',
        ),
        ContactChannel(
          title: 'WhatsApp Business',
          subtitle: 'Réponse rapide',
          value: '+33 6 45 78 90 12',
          icon: Icons.chat_bubble_outline_rounded,
          background: Color(0x1916A34A),
          actionLabel: 'Message',
        ),
        ContactChannel(
          title: 'Adresse',
          subtitle: '123 Avenue des Sports, Nice',
          value: 'Ouvrir la carte',
          icon: Icons.location_on_rounded,
          background: Color(0x19EF4444),
          actionLabel: 'Maps',
        ),
      ];

  List<ActivityHighlight> get recentActivities => const [
        ActivityHighlight(
          icon: Icons.sports_soccer_rounded,
          color: Color(0xFF176BFF),
          title: 'Match organisé demain 19h',
          subtitle: 'par TeamFC06 • 8/10 joueurs',
          actionLabel: 'Rejoindre',
        ),
        ActivityHighlight(
          icon: Icons.emoji_events_rounded,
          color: Color(0xFF16A34A),
          title: 'Tournoi hebdomadaire',
          subtitle: 'Samedi 14h • Inscriptions ouvertes',
          actionLabel: 'S\'inscrire',
        ),
      ];

  final List<BookingAssurance> assurances = const [
        BookingAssurance(icon: Icons.verified_rounded, label: 'Certifié', accent: Color(0xFF16A34A)),
        BookingAssurance(icon: Icons.access_time_rounded, label: '24h/24', accent: Color(0xFF176BFF)),
        BookingAssurance(icon: Icons.support_agent_rounded, label: 'Support', accent: Color(0xFF0EA5E9)),
      ];

  List<FacilityReview> get reviews => const [
        FacilityReview(
          author: 'Thomas M.',
          avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
          rating: 5.0,
          timestamp: 'Il y a 2 jours',
          content:
              "Excellent terrain, très bien entretenu. L'éclairage est parfait et les vestiaires sont propres.",
        ),
        FacilityReview(
          author: 'Marie L.',
          avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
          rating: 4.5,
          timestamp: 'Il y a 1 semaine',
          content:
              'Super accueil, personnel sympa. Le terrain est aux normes et bien climatisé.',
        ),
        FacilityReview(
          author: 'Alex R.',
          avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
          rating: 4.0,
          timestamp: 'Il y a 2 semaines',
          content:
              'Parfait pour les matchs entre amis. Réservation facile et prix correct.',
        ),
      ];

  final FacilityLocation location = const FacilityLocation(
    mapImage:
        'https://images.unsplash.com/photo-1502197996753-841c0e18b08b?auto=format&fit=crop&w=1000&q=60',
    travelInfo: '8 min en voiture • 15 min à pied',
    transitInfo: 'Arrêt "Diables Bleus" - Lignes 12, 23',
  );

  List<FacilityRule> get rules => const [
        FacilityRule(
          title: 'Chaussures de sport obligatoires',
          description: 'Crampons interdits sur le terrain synthétique',
          iconColor: Color(0xFF16A34A),
          icon: Icons.check_circle_rounded,
        ),
        FacilityRule(
          title: 'Annulation gratuite',
          description: 'Jusqu\'à 2h avant le créneau réservé',
          iconColor: Color(0xFFF59E0B),
          icon: Icons.schedule_rounded,
        ),
        FacilityRule(
          title: 'Capacité maximum',
          description: '12 joueurs simultanément sur le terrain',
          iconColor: Color(0xFF0EA5E9),
          icon: Icons.groups_rounded,
        ),
        FacilityRule(
          title: 'Interdictions',
          description: "Alcool, nourriture et boissons autres que l'eau",
          iconColor: Color(0xFFEF4444),
          icon: Icons.block_rounded,
        ),
      ];

  final FacilityContact contact = const FacilityContact(
    phoneLabel: 'Téléphone',
    phoneNumber: '04 93 12 34 56',
    email: 'contact@futsalindoor06.com',
    instagram: '@futsalindoor06',
  );

  List<OpeningHour> get openingHours => const [
        OpeningHour(day: 'Lundi', range: '08h00 - 23h00', isToday: true),
        OpeningHour(day: 'Mardi', range: '08h00 - 23h00'),
        OpeningHour(day: 'Mercredi', range: '08h00 - 23h00'),
        OpeningHour(day: 'Jeudi', range: '08h00 - 23h00'),
        OpeningHour(day: 'Vendredi', range: '08h00 - 00h00'),
        OpeningHour(day: 'Samedi', range: '08h00 - 00h00'),
        OpeningHour(day: 'Dimanche', range: '09h00 - 22h00'),
      ];

  List<SimilarVenue> get similarVenues => const [
        SimilarVenue(
          name: 'Sport Center Nice',
          rating: 4.1,
          distanceLabel: '2.8 km',
          priceLabel: '22€/h',
          imageUrl: 'https://images.unsplash.com/photo-1549388604-817d15aa0110?auto=format&fit=crop&w=600&q=60',
          isAvailable: true,
        ),
        SimilarVenue(
          name: 'Arena Football Club',
          rating: 4.5,
          distanceLabel: '3.2 km',
          priceLabel: '28€/h',
          imageUrl: 'https://images.unsplash.com/photo-1471295253337-3ceaaedca402?auto=format&fit=crop&w=600&q=60',
          isAvailable: true,
        ),
      ];

  void onBack() => Get.back();

  void onToggleFavorite() {
    Get.snackbar('Favori', 'Ajouté à vos favoris.');
  }

  void onShare() {
    Get.snackbar('Partager', 'Lien de l\'établissement copié.');
  }

  void onCall() {
    Get.snackbar('Téléphone', 'Appel vers ${contact.phoneNumber}');
  }

  void onMessage() {
    Get.snackbar('Message', 'Envoi d\'un message via Sportify.');
  }

  void onWhatsapp() {
    Get.snackbar('WhatsApp', 'Ouverture de la conversation WhatsApp.');
  }

  void onDirections() {
    Get.snackbar('Itinéraire', 'Ouverture de votre application de navigation.');
  }

  void onFollow() {
    Get.snackbar('Instagram', 'Vous suivez ${contact.instagram}.');
  }

  void onOpenMaps() {
    Get.snackbar('Maps', 'Ouverture dans Maps.');
  }

  void onReadMore() {
    Get.snackbar('À propos', 'Texte complet bientôt disponible.');
  }

  void onViewAllReviews() {
    Get.snackbar('Avis', 'Tous les avis seront bientôt disponibles.');
  }

  void onViewMoreAvailability() {
    Get.snackbar('Disponibilités', 'Calendrier détaillé à venir.');
  }

  void onViewSimilar() {
    Get.snackbar('Terrains similaires', 'Plus d\'options seront affichées prochainement.');
  }

  void onBook() {
    Get.toNamed(Routes.bookingLoading);
  }

  void onInfo() {
    Get.snackbar('Informations', 'Horaires, équipements et règlement disponibles prochainement.');
  }

  void onSelectActivity(ActivityHighlight activity) {
    Get.snackbar(activity.title, 'Action "${activity.actionLabel}" en préparation.');
  }

  void setGalleryIndex(int index) {
    galleryIndex.value = index;
  }
}

class FacilityDetail {
  const FacilityDetail({
    required this.name,
    required this.address,
    required this.distanceLabel,
    required this.rating,
    required this.reviewCount,
    required this.priceLabel,
    required this.heroImage,
    required this.statusLabel,
    required this.statusColor,
  });

  final String name;
  final String address;
  final String distanceLabel;
  final double rating;
  final int reviewCount;
  final String priceLabel;
  final String heroImage;
  final String statusLabel;
  final Color statusColor;
}

class QuickFact {
  const QuickFact({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;
}

class BookingPricing {
  const BookingPricing({
    required this.priceLabel,
    required this.priceSuffix,
    required this.highlight,
    required this.secondary,
  });

  final String priceLabel;
  final String priceSuffix;
  final String highlight;
  final String secondary;
}

class FacilityAmenity {
  const FacilityAmenity({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;
}

enum AvailabilityState { available, limited, full }

class AvailabilitySlot {
  const AvailabilitySlot({required this.time, this.state = AvailabilityState.available});

  final String time;
  final AvailabilityState state;
}

class AvailabilityHighlight {
  const AvailabilityHighlight({required this.label, required this.color});

  final String label;
  final Color color;
}

class ContactChannel {
  const ContactChannel({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.background,
    required this.actionLabel,
  });

  final String title;
  final String subtitle;
  final String value;
  final IconData icon;
  final Color background;
  final String actionLabel;
}

class ActivityHighlight {
  const ActivityHighlight({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String actionLabel;
}

class BookingAssurance {
  const BookingAssurance({required this.icon, required this.label, required this.accent});

  final IconData icon;
  final String label;
  final Color accent;
}

class FacilityReview {
  const FacilityReview({
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.timestamp,
    required this.content,
  });

  final String author;
  final String avatarUrl;
  final double rating;
  final String timestamp;
  final String content;
}

class FacilityLocation {
  const FacilityLocation({
    required this.mapImage,
    required this.travelInfo,
    required this.transitInfo,
  });

  final String mapImage;
  final String travelInfo;
  final String transitInfo;
}

class FacilityRule {
  const FacilityRule({
    required this.title,
    required this.description,
    required this.iconColor,
    required this.icon,
  });

  final String title;
  final String description;
  final Color iconColor;
  final IconData icon;
}

class FacilityContact {
  const FacilityContact({
    required this.phoneLabel,
    required this.phoneNumber,
    required this.email,
    required this.instagram,
  });

  final String phoneLabel;
  final String phoneNumber;
  final String email;
  final String instagram;
}

class OpeningHour {
  const OpeningHour({required this.day, required this.range, this.isToday = false});

  final String day;
  final String range;
  final bool isToday;
}

class SimilarVenue {
  const SimilarVenue({
    required this.name,
    required this.rating,
    required this.distanceLabel,
    required this.priceLabel,
    required this.imageUrl,
    required this.isAvailable,
  });

  final String name;
  final double rating;
  final String distanceLabel;
  final String priceLabel;
  final String imageUrl;
  final bool isAvailable;
}
