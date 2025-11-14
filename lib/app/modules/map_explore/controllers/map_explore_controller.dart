import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapExploreController extends GetxController {
  final RxBool filtersOpened = false.obs;
  final RxBool showListPane = true.obs;
  final Rx<MapVenue?> selectedVenue = Rx<MapVenue?>(null);

  List<MapVenue> get venues => const [
        MapVenue(
          name: 'Stade Pierre Mauroy',
          sports: ['Football', 'Athlétisme'],
          priceLabel: '25€/h',
          ratingLabel: '4.8',
          reviewCount: 128,
          availabilityLabel: 'Disponible',
          availabilityColor: Color(0xFF16A34A),
          distanceLabel: '1.4 km',
          coordinate: Offset(0.28, 0.32),
          gradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          icon: Icons.sports_soccer_rounded,
          slots: ['18h00', '19h30', '21h00'],
        ),
        MapVenue(
          name: 'Tennis Club Elite',
          sports: ['Tennis', 'Padel'],
          priceLabel: '32€/h',
          ratingLabel: '4.9',
          reviewCount: 201,
          availabilityLabel: 'Bientôt complet',
          availabilityColor: Color(0xFFF59E0B),
          distanceLabel: '2.8 km',
          coordinate: Offset(0.62, 0.42),
          gradient: [Color(0xFFFFB800), Color(0xFFF97316)],
          icon: Icons.sports_tennis_rounded,
          slots: ['17h00', '18h30'],
        ),
        MapVenue(
          name: 'Gymnase Central',
          sports: ['Basketball', 'Volley'],
          priceLabel: '18€/h',
          ratingLabel: '4.3',
          reviewCount: 156,
          availabilityLabel: 'Disponible',
          availabilityColor: Color(0xFF16A34A),
          distanceLabel: '0.9 km',
          coordinate: Offset(0.46, 0.58),
          gradient: [Color(0xFF16A34A), Color(0xFF0EA5E9)],
          icon: Icons.sports_basketball_rounded,
          slots: ['20h00', '22h00'],
        ),
        MapVenue(
          name: 'Piscine Odyssée',
          sports: ['Natation'],
          priceLabel: '12€/session',
          ratingLabel: '4.6',
          reviewCount: 89,
          availabilityLabel: 'Complet',
          availabilityColor: Color(0xFFEF4444),
          distanceLabel: '4.3 km',
          coordinate: Offset(0.18, 0.68),
          gradient: [Color(0xFF0EA5E9), Color(0xFF38BDF8)],
          icon: Icons.pool_rounded,
          slots: ['Demain 07h', 'Demain 09h'],
        ),
        MapVenue(
          name: 'Club de CrossFit 16',
          sports: ['Fitness', 'CrossFit'],
          priceLabel: '28€/séance',
          ratingLabel: '4.7',
          reviewCount: 63,
          availabilityLabel: 'Disponible',
          availabilityColor: Color(0xFF16A34A),
          distanceLabel: '3.5 km',
          coordinate: Offset(0.76, 0.25),
          gradient: [Color(0xFFEC4899), Color(0xFFDB2777)],
          icon: Icons.fitness_center_rounded,
          slots: ['Demain 18h', 'Demain 19h30'],
        ),
      ];

  List<MapFilterCategory> get sidebarFilters => const [
        MapFilterCategory(
          title: 'Type de sport',
          options: [
            MapFilterOption(label: 'Football', isActive: true, icon: Icons.sports_soccer_rounded),
            MapFilterOption(label: 'Basketball', isActive: false, icon: Icons.sports_basketball_rounded),
            MapFilterOption(label: 'Tennis', isActive: false, icon: Icons.sports_tennis_rounded),
            MapFilterOption(label: 'Fitness', isActive: false, icon: Icons.fitness_center_rounded),
            MapFilterOption(label: 'Natation', isActive: false, icon: Icons.pool_rounded),
            MapFilterOption(label: 'Rugby', isActive: false, icon: Icons.sports_rugby_rounded),
          ],
        ),
        MapFilterCategory(
          title: 'Disponibilité',
          options: [
            MapFilterOption(label: 'Maintenant', isActive: true),
            MapFilterOption(label: 'Aujourd\'hui'),
            MapFilterOption(label: 'Cette semaine'),
            MapFilterOption(label: 'Flexible'),
          ],
        ),
        MapFilterCategory(
          title: 'Type de lieu',
          options: [
            MapFilterOption(label: 'Stade', isActive: true),
            MapFilterOption(label: 'Gymnase', isActive: true),
            MapFilterOption(label: 'Parc'),
            MapFilterOption(label: 'Club privé', isActive: true),
            MapFilterOption(label: 'Piscine'),
          ],
        ),
      ];

  List<String> get priceSteps => const ['10€/h', '50€/h', '100€/h'];
  List<String> get radiusOptions => const ['5 km', '10 km', '20 km'];

  void toggleFilters() {
    filtersOpened.value = !filtersOpened.value;
  }

  void toggleListPane() {
    showListPane.value = !showListPane.value;
  }

  void onVenueTap(MapVenue venue) {
    selectedVenue.value = venue;
    showListPane.value = true;
  }

  void closeVenuePreview() {
    selectedVenue.value = null;
  }

  void useMyLocation() {
    Get.snackbar('Localisation', 'Détection de votre position en cours...');
  }

  void openFilters() {
    filtersOpened.value = true;
  }

  void applyFilters() {
    filtersOpened.value = false;
    Get.snackbar('Filtres', 'Les filtres ont été appliqués.');
  }

  void resetFilters() {
    Get.snackbar('Filtres', 'Filtres réinitialisés.');
  }

  void openVenueDetails(MapVenue venue) {
    Get.snackbar(venue.name, 'Ouverture de la fiche détaillée prochainement.');
  }

  void bookVenue(MapVenue venue) {
    Get.snackbar('Réservation', 'Choisissez votre créneau chez ${venue.name}.');
  }
}

class MapVenue {
  const MapVenue({
    required this.name,
    required this.sports,
    required this.priceLabel,
    required this.ratingLabel,
    required this.reviewCount,
    required this.availabilityLabel,
    required this.availabilityColor,
    required this.distanceLabel,
    required this.coordinate,
    required this.gradient,
    required this.icon,
    required this.slots,
  });

  final String name;
  final List<String> sports;
  final String priceLabel;
  final String ratingLabel;
  final int reviewCount;
  final String availabilityLabel;
  final Color availabilityColor;
  final String distanceLabel;
  final Offset coordinate; // values between 0 and 1 for map positioning
  final List<Color> gradient;
  final IconData icon;
  final List<String> slots;
}

class MapFilterCategory {
  const MapFilterCategory({required this.title, required this.options});

  final String title;
  final List<MapFilterOption> options;
}

class MapFilterOption {
  const MapFilterOption({required this.label, this.isActive = false, this.icon});

  final String label;
  final bool isActive;
  final IconData? icon;
}

