import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SearchResultsController extends GetxController {
  final TextEditingController searchController = TextEditingController(text: 'Mark');

  final RxString query = 'Mark'.obs;

  final List<String> availableSports = const [
    'Football',
    'Basketball',
    'Tennis',
    'Running',
    'Padel',
    'Volley',
    'Natation',
  ];

  final RxSet<String> selectedSports = <String>{'Football', 'Basketball'}.obs;

  final Rx<RangeValues> distanceRange = const RangeValues(0, 5).obs;

  final List<String> availableSorts = const ['Récent', 'Populaire', 'Distance'];
  final RxString selectedSort = 'Récent'.obs;

  final List<String> availableAvailabilities = const [
    'Disponible maintenant',
    'Ce soir',
    'Cette semaine',
    'Ce weekend',
  ];
  final RxString selectedAvailability = 'Disponible maintenant'.obs;

  final List<String> availableLevels = const [
    'Débutant',
    'Intermédiaire',
    'Avancé',
    'Niveau Pro',
  ];
  final RxString selectedLevel = 'Niveau Pro'.obs;

  final Rx<RangeValues> priceRange = const RangeValues(10, 35).obs;
  final Rx<RangeValues> ageRange = const RangeValues(18, 40).obs;

  final List<String> availableAmenities = const [
    'Parking gratuit',
    'Vestiaires',
    'Douches',
    'Location équipement',
    'Eclairage LED',
    'Accès PMR',
  ];
  final RxSet<String> selectedAmenities = <String>{'Parking gratuit', 'Vestiaires'}.obs;

  final RxBool showOnlyVerified = true.obs;
  final RxBool showOnlyWithSpots = true.obs;

  List<ActiveFilterChip> get activeFilters {
    final chips = <ActiveFilterChip>[];

    final sportList = selectedSports.toList(growable: false);
    for (final sport in sportList.take(3)) {
      chips.add(
        ActiveFilterChip(
          label: sport,
          color: const Color(0xFF176BFF),
          icon: Icons.sports_soccer_rounded,
        ),
      );
    }

    chips.add(
      ActiveFilterChip(
        label: '${distanceRange.value.end.round()} km',
        color: const Color(0xFF16A34A),
        icon: Icons.location_on_rounded,
      ),
    );

    chips.add(
      ActiveFilterChip(
        label: selectedSort.value,
        color: const Color(0xFFFFB800),
        icon: Icons.flash_on_rounded,
      ),
    );

    chips.add(
      ActiveFilterChip(
        label: selectedLevel.value,
        color: const Color(0xFF0EA5E9),
        icon: Icons.workspace_premium_rounded,
      ),
    );

    chips.add(
      ActiveFilterChip(
        label: selectedAvailability.value,
        color: const Color(0xFF16A34A),
        icon: Icons.event_available_rounded,
      ),
    );

    chips.add(
      ActiveFilterChip(
        label: '${priceRange.value.start.round()}-'
            '${priceRange.value.end.round()}€',
        color: const Color(0xFF176BFF),
        icon: Icons.payments_rounded,
      ),
    );

    chips.add(
      ActiveFilterChip(
        label: '${ageRange.value.start.round()}-'
            '${ageRange.value.end.round()} ans',
        color: const Color(0xFFFFB800),
        icon: Icons.cake_rounded,
      ),
    );

    final amenity = selectedAmenities.isNotEmpty ? selectedAmenities.first : null;
    if (amenity != null) {
      chips.add(
        ActiveFilterChip(
          label: amenity,
          color: const Color(0xFF0EA5E9),
          icon: Icons.check_circle_outline_rounded,
        ),
      );
    }

    if (showOnlyVerified.isTrue) {
      chips.add(
        ActiveFilterChip(
          label: 'Utilisateurs vérifiés',
          color: const Color(0xFF16A34A),
          icon: Icons.verified_user_rounded,
        ),
      );
    }

    if (showOnlyWithSpots.isTrue) {
      chips.add(
        ActiveFilterChip(
          label: 'Places disponibles',
          color: const Color(0xFF176BFF),
          icon: Icons.event_available_rounded,
        ),
      );
    }

    return chips;
  }

  List<SearchPlayerResult> get playerResults => const [
        SearchPlayerResult(
          name: 'Mark Johnson',
          avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
          distanceLabel: '2.3 km',
          ratingLabel: '4.9 • 127 matchs',
          levelBadge: 'Pro',
          levelColor: Color(0xFFFFB800),
          online: true,
          messageCta: 'Message',
        ),
        SearchPlayerResult(
          name: 'Marcus Silva',
          avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=60',
          distanceLabel: '1.8 km',
          ratingLabel: '4.7 • 98 matchs',
          levelBadge: 'Avancé',
          levelColor: Color(0xFF0EA5E9),
          online: false,
          messageCta: 'Message',
        ),
        SearchPlayerResult(
          name: 'Mark Thompson',
          avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
          distanceLabel: '3.1 km',
          ratingLabel: '4.5 • 76 matchs',
          levelBadge: 'Intermédiaire',
          levelColor: Color(0xFFF59E0B),
          online: true,
          messageCta: 'Message',
        ),
      ];

  SearchVenueHighlight get venueHighlight => const SearchVenueHighlight(
        title: 'Complexe Sportif Mark',
        subtitle: 'Terrain de football synthétique',
        pricePerHour: '25€',
        distanceLabel: '1.2 km',
        capacityLabel: '22 joueurs max',
        amenityLabel: 'Parking gratuit',
        sports: ['Football', 'Basket'],
        ratingLabel: '4.8',
        availabilityLabel: 'Disponible maintenant',
        gradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
      );

  SearchVenueHighlight get venueSecondary => const SearchVenueHighlight(
        title: 'Arena Mark Sport',
        subtitle: 'Salle multisports couverte',
        pricePerHour: '30€',
        distanceLabel: '2.8 km',
        capacityLabel: '16 joueurs max',
        amenityLabel: 'Climatisé',
        sports: ['Volley', 'Tennis'],
        ratingLabel: '4.6',
        availabilityLabel: 'Presque complet',
        gradient: [Color(0xFF16A34A), Color(0xFF059669)],
      );

  List<SearchAnnouncement> get announcements => const [
        SearchAnnouncement(
          author: 'Mark Davis',
          avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
          headline: 'Match de football ce soir - 2 places libres!',
          description:
              'Salut les amis! On organise un match de foot ce soir à 19h au stade Mark. '
              'Il nous manque 2 joueurs, niveau intermédiaire/avancé. Ambiance garantie! 🔥',
          distance: '1.5 km',
          participants: '8/10 joueurs',
          price: 'Gratuit',
          schedule: 'Aujourd\'hui 19h',
          tags: ['Organisateur', 'Football'],
          ctaLabel: 'Rejoindre',
        ),
        SearchAnnouncement(
          author: 'Mark Wilson',
          avatarUrl: 'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?auto=format&fit=crop&w=200&q=60',
          headline: 'Cours de tennis privé - Tous niveaux',
          description:
              'Coach diplômé propose des cours de tennis individuels ou en petit groupe. '
              'Technique, tactique, préparation physique. Premier cours d\'essai offert! 🎾',
          distance: '3.2 km',
          participants: 'Coach Pro',
          price: '35€/h',
          schedule: 'Planning flexible',
          tags: ['Coach Pro', 'Tennis'],
          ctaLabel: 'Contacter',
          extraActions: ['28', '15', 'Partager'],
        ),
        SearchAnnouncement(
          author: 'Mark Garcia',
          avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
          headline: 'Tournoi de basket 3v3 ce weekend!',
          description:
              'Tournoi amical de basketball 3 contre 3 samedi prochain. Inscription gratuite, lots à gagner! '
              'Venez nombreux, tous niveaux bienvenus 🏀',
          distance: '2.1 km',
          participants: 'Samedi 14h',
          price: 'Lots à gagner',
          schedule: 'Clôture demain',
          tags: ['Capitaine', 'Basket'],
          ctaLabel: 'S\'inscrire',
        ),
      ];

  List<QuickSearchAction> get quickActions => const [
        QuickSearchAction(
          title: 'Affiner la recherche',
          icon: Icons.tune_rounded,
          background: Color(0xFF176BFF),
        ),
        QuickSearchAction(
          title: 'Vue carte',
          icon: Icons.map_rounded,
          background: Color(0xFF16A34A),
        ),
        QuickSearchAction(
          title: 'Sauvegarder',
          icon: Icons.bookmark_outline_rounded,
          background: Color(0xFFFFB800),
        ),
        QuickSearchAction(
          title: 'Historique',
          icon: Icons.history_rounded,
          background: Color(0xFF0EA5E9),
        ),
      ];

  List<SearchSuggestion> get suggestionBuckets => const [
        SearchSuggestion(
          icon: Icons.sports_soccer_rounded,
          title: 'Matchs de football près de vous',
          subtitle: '15 matchs cette semaine',
        ),
        SearchSuggestion(
          icon: Icons.people_alt_rounded,
          title: 'Joueurs de votre niveau',
          subtitle: '32 joueurs intermédiaires',
        ),
        SearchSuggestion(
          icon: Icons.schedule_rounded,
          title: 'Créneaux disponibles aujourd\'hui',
          subtitle: '8 terrains libres',
        ),
      ];

  List<String> get similarSearches => const [
        'Mark + Football',
        'Joueurs proches',
        'Terrains Mark',
        'Matchs ce soir',
        'Niveau intermédiaire',
        'Gratuit',
      ];

  String get resultsSummary => '127 résultats trouvés pour';

  int get shownResults => 20;

  List<SearchPlayerResult> get visiblePlayers => playerResults;

  List<SearchAnnouncement> get visibleAnnouncements => announcements;

  void toggleSport(String sport) {
    if (selectedSports.contains(sport)) {
      selectedSports.remove(sport);
    } else {
      selectedSports.add(sport);
    }
  }

  void setDistanceRange(RangeValues values) {
    distanceRange.value = values;
  }

  void setSort(String value) {
    selectedSort.value = value;
  }

  void setAvailability(String value) {
    selectedAvailability.value = value;
  }

  void setLevel(String value) {
    selectedLevel.value = value;
  }

  void setPriceRange(RangeValues values) {
    priceRange.value = values;
  }

  void setAgeRange(RangeValues values) {
    ageRange.value = values;
  }

  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
  }

  void resetFilters() {
    selectedSports
      ..clear()
      ..addAll({'Football', 'Basketball'});
    distanceRange.value = const RangeValues(0, 5);
    selectedSort.value = 'Récent';
    selectedAvailability.value = 'Disponible maintenant';
    selectedLevel.value = 'Niveau Pro';
    priceRange.value = const RangeValues(10, 35);
    ageRange.value = const RangeValues(18, 40);
    selectedAmenities
      ..clear()
      ..addAll({'Parking gratuit', 'Vestiaires'});
    showOnlyVerified.value = true;
    showOnlyWithSpots.value = true;
  }

  void applyFilters() {
    Get.back();
  }

  List<PrimaryFilterOption> get primaryFilters => const [
        PrimaryFilterOption(label: 'Proximité', icon: Icons.near_me_rounded, isHighlighted: true),
        PrimaryFilterOption(label: 'Mieux notés', icon: Icons.star_rounded),
        PrimaryFilterOption(label: 'Prix', icon: Icons.euro_rounded),
        PrimaryFilterOption(label: 'Disponible', icon: Icons.event_available_rounded),
      ];

  List<FilterVenueResult> get filterVenueResults => const [
        FilterVenueResult(
          title: 'Complexe Sportif Central',
          sports: ['Football', 'Tennis', 'Basketball'],
          priceLabel: '25€/h',
          availabilityLabel: 'Disponible',
          availabilityColor: Color(0xFF16A34A),
          distanceLabel: '2.1 km',
          ratingLabel: '4.8',
          reviewCount: 124,
          gradient: [Color(0xFF176BFF), Color(0xFF0F5AE0)],
          imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=1200&q=60',
          isBookable: true,
        ),
        FilterVenueResult(
          title: 'Stade Municipal',
          sports: ['Football', 'Athlétisme'],
          priceLabel: '18€/h',
          availabilityLabel: 'Complet',
          availabilityColor: Color(0xFFF59E0B),
          distanceLabel: '0.8 km',
          ratingLabel: '4.6',
          reviewCount: 89,
          gradient: [Color(0xFF16A34A), Color(0xFF0EA5E9)],
          imageUrl: 'https://images.unsplash.com/photo-1518604775537-3471ae8c5f86?auto=format&fit=crop&w=1200&q=60',
          isBookable: false,
        ),
        FilterVenueResult(
          title: 'Tennis Club Elite',
          sports: ['Tennis', 'Padel'],
          priceLabel: '35€/h',
          availabilityLabel: 'Disponible',
          availabilityColor: Color(0xFF16A34A),
          distanceLabel: '3.4 km',
          ratingLabel: '4.9',
          reviewCount: 201,
          gradient: [Color(0xFFFFB800), Color(0xFFF59E0B)],
          imageUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=1200&q=60',
          isBookable: true,
        ),
      ];

  List<FilterBottomShortcut> get filterShortcuts => const [
        FilterBottomShortcut(icon: Icons.home_rounded, label: 'Accueil'),
        FilterBottomShortcut(icon: Icons.search_rounded, label: 'Rechercher', isActive: true),
        FilterBottomShortcut(icon: Icons.calendar_month_rounded, label: 'Réserver'),
        FilterBottomShortcut(icon: Icons.chat_bubble_outline_rounded, label: 'Messages'),
        FilterBottomShortcut(icon: Icons.person_outline_rounded, label: 'Profil'),
      ];

  String get filterResultsSummary => '147 établissements trouvés';

  void openMapView() {
    Get.toNamed(Routes.mapVenues);
  }

  void loadMoreFilterResults() {
    Get.snackbar('Résultats', 'Chargement de résultats supplémentaires...');
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class ActiveFilterChip {
  const ActiveFilterChip({
    required this.label,
    required this.color,
    this.icon,
  });

  final String label;
  final Color color;
  final IconData? icon;
}

class SearchPlayerResult {
  const SearchPlayerResult({
    required this.name,
    required this.avatarUrl,
    required this.distanceLabel,
    required this.ratingLabel,
    required this.levelBadge,
    required this.levelColor,
    required this.online,
    required this.messageCta,
  });

  final String name;
  final String avatarUrl;
  final String distanceLabel;
  final String ratingLabel;
  final String levelBadge;
  final Color levelColor;
  final bool online;
  final String messageCta;
}

class SearchVenueHighlight {
  const SearchVenueHighlight({
    required this.title,
    required this.subtitle,
    required this.pricePerHour,
    required this.distanceLabel,
    required this.capacityLabel,
    required this.amenityLabel,
    required this.sports,
    required this.ratingLabel,
    required this.availabilityLabel,
    required this.gradient,
  });

  final String title;
  final String subtitle;
  final String pricePerHour;
  final String distanceLabel;
  final String capacityLabel;
  final String amenityLabel;
  final List<String> sports;
  final String ratingLabel;
  final String availabilityLabel;
  final List<Color> gradient;
}

class SearchAnnouncement {
  const SearchAnnouncement({
    required this.author,
    required this.avatarUrl,
    required this.headline,
    required this.description,
    required this.distance,
    required this.participants,
    required this.price,
    required this.schedule,
    required this.tags,
    required this.ctaLabel,
    this.extraActions,
  });

  final String author;
  final String avatarUrl;
  final String headline;
  final String description;
  final String distance;
  final String participants;
  final String price;
  final String schedule;
  final List<String> tags;
  final String ctaLabel;
  final List<String>? extraActions;
}

class QuickSearchAction {
  const QuickSearchAction({
    required this.title,
    required this.icon,
    required this.background,
  });

  final String title;
  final IconData icon;
  final Color background;
}

class SearchSuggestion {
  const SearchSuggestion({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

class PrimaryFilterOption {
  const PrimaryFilterOption({
    required this.label,
    required this.icon,
    this.isHighlighted = false,
  });

  final String label;
  final IconData icon;
  final bool isHighlighted;
}

class FilterVenueResult {
  const FilterVenueResult({
    required this.title,
    required this.sports,
    required this.priceLabel,
    required this.availabilityLabel,
    required this.availabilityColor,
    required this.distanceLabel,
    required this.ratingLabel,
    required this.reviewCount,
    required this.gradient,
    required this.imageUrl,
    required this.isBookable,
  });

  final String title;
  final List<String> sports;
  final String priceLabel;
  final String availabilityLabel;
  final Color availabilityColor;
  final String distanceLabel;
  final String ratingLabel;
  final int reviewCount;
  final List<Color> gradient;
  final String imageUrl;
  final bool isBookable;
}

class FilterBottomShortcut {
  const FilterBottomShortcut({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final bool isActive;
}

