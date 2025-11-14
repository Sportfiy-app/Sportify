import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePlacesController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxString selectedFilter = 'Tous'.obs;
  final RxBool notificationsEnabled = true.obs;

  List<FavoriteFilterChip> get filters => const [
        FavoriteFilterChip(label: 'Tous', icon: Icons.all_inclusive_rounded),
        FavoriteFilterChip(label: 'Football', icon: Icons.sports_soccer_rounded),
        FavoriteFilterChip(label: 'Basket', icon: Icons.sports_basketball_rounded),
        FavoriteFilterChip(label: 'Running', icon: Icons.directions_run_rounded),
        FavoriteFilterChip(label: 'Tennis', icon: Icons.sports_tennis_rounded),
      ];

  FavoritePlacesSummary get summary => const FavoritePlacesSummary(
        totalPlaces: 12,
        sportsCount: 5,
        averageDistance: 2.4,
      );

  List<RecentFavoritePlace> get recentVisits => const [
        RecentFavoritePlace(
          imageUrl: 'https://images.unsplash.com/photo-1600486913747-55e5470d6f40?auto=format&fit=crop&w=400&q=60',
          name: 'Foot Center',
          sport: 'Football',
          distanceKm: 0.8,
          rating: 4.8,
          lastVisitedLabel: 'Hier 18h',
        ),
        RecentFavoritePlace(
          imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=400&q=60',
          name: 'Basket Arena',
          sport: 'Basketball',
          distanceKm: 1.2,
          rating: 4.2,
          lastVisitedLabel: 'Lundi 20h',
        ),
        RecentFavoritePlace(
          imageUrl: 'https://images.unsplash.com/photo-1508766206392-8bd5cf550d1b?auto=format&fit=crop&w=400&q=60',
          name: 'Tennis Club',
          sport: 'Tennis',
          distanceKm: 2.1,
          rating: 4.9,
          lastVisitedLabel: 'Samedi 14h',
        ),
      ];

  List<FavoritePlaceCard> get favoritePlaces => const [
        FavoritePlaceCard(
          imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=900&q=60',
          sportTag: 'Football',
          distanceKm: 0.8,
          title: 'Complexe Sportif Central',
          address: '15 Rue du Sport, Paris 15e',
          status: FavoritePlaceStatus.open,
          hours: '8h - 23h',
          capacity: '12 max',
          price: '25€/h',
          rating: 4.8,
          badges: ['Disponible', '2 créneaux'],
        ),
        FavoritePlaceCard(
          imageUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=900&q=60',
          sportTag: 'Basketball',
          distanceKm: 1.2,
          title: 'Gymnase Municipal',
          address: '8 Avenue des Sports, Paris 12e',
          status: FavoritePlaceStatus.limited,
          hours: '9h - 21h',
          capacity: '12 max',
          price: '15€/h',
          rating: 4.2,
          badges: ['2 créneaux'],
        ),
        FavoritePlaceCard(
          imageUrl: 'https://images.unsplash.com/photo-1519315901367-f34ff9154487?auto=format&fit=crop&w=900&q=60',
          sportTag: 'Tennis',
          distanceKm: 2.1,
          title: 'Tennis Club Parisien',
          address: '22 Rue Roland Garros, Paris 16e',
          status: FavoritePlaceStatus.open,
          hours: '7h - 22h',
          capacity: 'Vestiaires',
          price: '35€/h',
          rating: 4.9,
          badges: ['7 créneaux'],
        ),
        FavoritePlaceCard(
          imageUrl: 'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?auto=format&fit=crop&w=900&q=60',
          sportTag: 'Piscine',
          distanceKm: 1.8,
          title: 'Piscine Olympique',
          address: '5 Boulevard Aquatique, Paris 13e',
          status: FavoritePlaceStatus.closed,
          hours: '6h - 22h',
          capacity: '27°C • 8€/séance',
          price: '8€/séance',
          rating: 4.6,
          badges: ['Maintenance'],
        ),
      ];

  List<FavoriteCollectionCard> get collections => const [
        FavoriteCollectionCard(color: Color(0xFF176BFF), title: 'Football', subtitle: 'Mes terrains préférés', countLabel: '6 lieux'),
        FavoriteCollectionCard(color: Color(0xFFFFB800), title: 'Basketball', subtitle: 'Gymnases top', countLabel: '3 lieux'),
        FavoriteCollectionCard(color: Color(0xFF16A34A), title: 'Tennis', subtitle: 'Courts premium', countLabel: '2 lieux'),
        FavoriteCollectionCard(color: Color(0xFF2563EB), title: 'Natation', subtitle: 'Piscine préférée', countLabel: '1 lieu'),
      ];

  FavoriteRecommendation get recommendation => const FavoriteRecommendation(
        title: 'Suggestion personnalisée',
        subtitle: 'Basée sur vos préférences',
        suggestion: FavoriteSuggestion(
          imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=600&q=60',
          name: 'Padel Center Paris',
          description: 'Nouveau sport à essayer',
          distanceKm: 1.5,
          rating: 4.7,
        ),
      );

  List<FavoriteActionCard> get actionCards => const [
        FavoriteActionCard(
          iconColor: Color(0xFF176BFF),
          title: 'Exporter mes favoris',
          subtitle: 'Sauvegarder en PDF ou Excel',
        ),
        FavoriteActionCard(
          iconColor: Color(0xFFFFB800),
          title: 'Partager ma liste',
          subtitle: 'Envoyer à mes amis',
        ),
        FavoriteActionCard(
          iconColor: Color(0xFF16A34A),
          title: 'Notifications',
          subtitle: 'Alertes de disponibilité',
          hasToggle: true,
        ),
      ];
}

class FavoriteFilterChip {
  const FavoriteFilterChip({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

class FavoritePlacesSummary {
  const FavoritePlacesSummary({required this.totalPlaces, required this.sportsCount, required this.averageDistance});
  final int totalPlaces;
  final int sportsCount;
  final double averageDistance;
}

class RecentFavoritePlace {
  const RecentFavoritePlace({
    required this.imageUrl,
    required this.name,
    required this.sport,
    required this.distanceKm,
    required this.rating,
    required this.lastVisitedLabel,
  });

  final String imageUrl;
  final String name;
  final String sport;
  final double distanceKm;
  final double rating;
  final String lastVisitedLabel;
}

class FavoritePlaceCard {
  const FavoritePlaceCard({
    required this.imageUrl,
    required this.sportTag,
    required this.distanceKm,
    required this.title,
    required this.address,
    required this.status,
    required this.hours,
    required this.capacity,
    required this.price,
    required this.rating,
    this.badges = const [],
  });

  final String imageUrl;
  final String sportTag;
  final double distanceKm;
  final String title;
  final String address;
  final FavoritePlaceStatus status;
  final String hours;
  final String capacity;
  final String price;
  final double rating;
  final List<String> badges;
}

enum FavoritePlaceStatus { open, limited, closed }

class FavoriteCollectionCard {
  const FavoriteCollectionCard({required this.color, required this.title, required this.subtitle, required this.countLabel});
  final Color color;
  final String title;
  final String subtitle;
  final String countLabel;
}

class FavoriteRecommendation {
  const FavoriteRecommendation({required this.title, required this.subtitle, required this.suggestion});
  final String title;
  final String subtitle;
  final FavoriteSuggestion suggestion;
}

class FavoriteSuggestion {
  const FavoriteSuggestion({required this.imageUrl, required this.name, required this.description, required this.distanceKm, required this.rating});
  final String imageUrl;
  final String name;
  final String description;
  final double distanceKm;
  final double rating;
}

class FavoriteActionCard {
  const FavoriteActionCard({required this.iconColor, required this.title, required this.subtitle, this.hasToggle = false});
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool hasToggle;
}
