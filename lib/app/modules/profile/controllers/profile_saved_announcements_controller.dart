import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileSavedAnnouncementsController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxString activeFilter = 'Tous'.obs;
  final RxList<SavedAnnouncement> _saved = <SavedAnnouncement>[].obs;

  final List<String> filterOptions = const [
    'Tous',
    'Récentes',
    'Proximité',
    'Sports',
    'Actives',
    'Expirées',
  ];

  final SavedSummary summary = const SavedSummary(total: 12, contacted: 8, participations: 5);

  @override
  void onInit() {
    super.onInit();
    _saved.assignAll(_generateAnnouncements());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  List<SavedAnnouncement> get savedAnnouncements => List.unmodifiable(_saved);

  List<SavedAnnouncement> get filteredAnnouncements {
    final query = searchQuery.value.trim().toLowerCase();
    final filter = activeFilter.value;

    var result = _saved.where((announcement) {
      final matchesQuery = query.isEmpty ||
          announcement.authorName.toLowerCase().contains(query) ||
          announcement.message.toLowerCase().contains(query) ||
          announcement.tags.any((tag) => tag.toLowerCase().contains(query));

      if (!matchesQuery) {
        return false;
      }

      switch (filter) {
        case 'Actives':
          return announcement.status == SavedStatus.active || announcement.status == SavedStatus.expiring;
        case 'Expirées':
          return announcement.status == SavedStatus.expired;
        case 'Sports':
          return announcement.tags.any((tag) => tag.isNotEmpty);
        default:
          return true;
      }
    }).toList();

    switch (filter) {
      case 'Récentes':
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Proximité':
        result.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        break;
      case 'Actives':
        result.sort((a, b) => a.status.index.compareTo(b.status.index));
        break;
      case 'Expirées':
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      default:
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return result;
  }

  void setSearchQuery(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  void selectFilter(String value) {
    if (activeFilter.value == value) {
      activeFilter.value = 'Tous';
      return;
    }
    if (value == 'Sports') {
      Get.snackbar('Filtres', 'Sélection de sport personnalisée à venir.');
    }
    activeFilter.value = value;
  }

  void openAnnouncement(SavedAnnouncement announcement) {
    Get.toNamed(Routes.postDetails, arguments: announcement.id);
  }

  void messageAuthor(SavedAnnouncement announcement) {
    Get.toNamed(Routes.chatDetail, arguments: announcement.authorName);
  }

  void toggleBookmark(SavedAnnouncement announcement) {
    _saved.removeWhere((item) => item.id == announcement.id);
    Get.snackbar('Favoris', '"${announcement.authorName}" a été retiré de vos annonces enregistrées.');
  }

  void clearAll() {
    if (_saved.isEmpty) {
      Get.snackbar('Favoris', 'Aucune annonce enregistrée à effacer.');
      return;
    }
    Get.defaultDialog(
      title: 'Tout supprimer ?',
      middleText: 'Voulez-vous retirer toutes vos annonces enregistrées ?',
      textCancel: 'Annuler',
      textConfirm: 'Supprimer',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        _saved.clear();
        Get.back();
        Get.snackbar('Favoris', 'Vos annonces enregistrées ont été supprimées.');
      },
    );
  }

  List<SavedAnnouncement> _generateAnnouncements() {
    final now = DateTime.now();
    return [
      SavedAnnouncement(
        id: 'saved_001',
        authorName: 'David Doe',
        authorAvatar:
            'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
        distanceKm: 4,
        city: 'Nice, France',
        message: 'Je cherche quelqu’un pour aller courir mardi 23, qui est dispo ?',
        likes: 12,
        comments: 25,
        savedCount: 1,
        participants: 3,
        timeAgoLabel: 'il y a 20 min',
        status: SavedStatus.active,
        tags: const ['Running', 'Intermédiaire'],
        createdAt: now.subtract(const Duration(minutes: 20)),
      ),
      SavedAnnouncement(
        id: 'saved_002',
        authorName: 'Sophie Martin',
        authorAvatar:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=60',
        distanceKm: 2,
        city: 'Cannes, France',
        message: 'Match de tennis demain matin 9h au club de Cannes. Niveau intermédiaire recherché !',
        likes: 18,
        comments: 12,
        savedCount: 1,
        participants: 8,
        timeAgoLabel: 'il y a 2h',
        status: SavedStatus.expiring,
        tags: const ['Tennis', 'Intermédiaire', '15€/personne'],
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      SavedAnnouncement(
        id: 'saved_003',
        authorName: 'Marc Dubois',
        authorAvatar:
            'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=200&q=60',
        distanceKm: 7,
        city: 'Antibes, France',
        message:
            'Session de musculation ce soir 19h à la Basic Fit d’Antibes. Cherche partenaire d’entraînement motivé !',
        likes: 5,
        comments: 8,
        savedCount: 1,
        participants: 2,
        timeAgoLabel: 'il y a 5h',
        status: SavedStatus.expiring,
        tags: const ['Fitness', 'Intense', 'Ce soir 19h'],
        createdAt: now.subtract(const Duration(hours: 5)),
        coverImage:
            'https://images.unsplash.com/photo-1517832207067-4db24a2ae47c?auto=format&fit=crop&w=1200&q=60',
      ),
      SavedAnnouncement(
        id: 'saved_004',
        authorName: 'Emma Leroy',
        authorAvatar:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
        distanceKm: 1,
        city: 'Nice, France',
        message:
            'Cours de yoga en plein air dimanche matin au Parc Phoenix. Tous niveaux bienvenus ! 🧘‍♀️',
        likes: 24,
        comments: 31,
        savedCount: 1,
        participants: 6,
        timeAgoLabel: 'il y a 1 jour',
        status: SavedStatus.active,
        tags: const ['Yoga', 'Tous niveaux', 'Dimanche 10h'],
        createdAt: now.subtract(const Duration(days: 1)),
        coverImage:
            'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=1200&q=60',
      ),
      SavedAnnouncement(
        id: 'saved_005',
        authorName: 'Lucas Bernard',
        authorAvatar:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=60',
        distanceKm: 3,
        city: 'Monaco, Monaco',
        message: 'Partie de foot à 5 samedi après-midi au stade Louis II. Il nous manque 2 joueurs !',
        likes: 18,
        comments: 24,
        savedCount: 1,
        participants: 7,
        timeAgoLabel: 'il y a 8h',
        status: SavedStatus.active,
        tags: const ['Football', 'Samedi 14h', '3/5 joueurs'],
        createdAt: now.subtract(const Duration(hours: 8)),
      ),
      SavedAnnouncement(
        id: 'saved_006',
        authorName: 'Chloé Vidal',
        authorAvatar:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
        distanceKm: 6,
        city: 'Cagnes-sur-Mer, France',
        message:
            'Balade à vélo le long du littoral dimanche. Rythme tranquille, objectif 25 km. Quelqu’un intéressé ?',
        likes: 9,
        comments: 5,
        savedCount: 1,
        participants: 4,
        timeAgoLabel: 'il y a 3 jours',
        status: SavedStatus.expired,
        tags: const ['Cyclisme', 'Loisir'],
        createdAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }
}

enum SavedStatus { active, expiring, expired }

class SavedAnnouncement {
  const SavedAnnouncement({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.distanceKm,
    required this.city,
    required this.message,
    required this.likes,
    required this.comments,
    required this.savedCount,
    required this.participants,
    required this.timeAgoLabel,
    required this.status,
    required this.tags,
    required this.createdAt,
    this.coverImage,
  });

  final String id;
  final String authorName;
  final String authorAvatar;
  final double distanceKm;
  final String city;
  final String message;
  final int likes;
  final int comments;
  final int savedCount;
  final int participants;
  final String timeAgoLabel;
  final SavedStatus status;
  final List<String> tags;
  final DateTime createdAt;
  final String? coverImage;

  bool get isExpired => status == SavedStatus.expired;

  String get distanceLabel =>
      'à ${distanceKm >= 1 ? distanceKm.toStringAsFixed(0) : distanceKm.toStringAsFixed(1)} km - $city';

  String get statusLabel {
    switch (status) {
      case SavedStatus.active:
        return 'Active';
      case SavedStatus.expiring:
        return 'Bientôt expirée';
      case SavedStatus.expired:
        return 'Expirée';
    }
  }

  Color get statusColor {
    switch (status) {
      case SavedStatus.active:
        return const Color(0xFF16A34A);
      case SavedStatus.expiring:
        return const Color(0xFFF59E0B);
      case SavedStatus.expired:
        return const Color(0xFF6B7280);
    }
  }
}

class SavedSummary {
  const SavedSummary({
    required this.total,
    required this.contacted,
    required this.participations,
  });

  final int total;
  final int contacted;
  final int participations;
}

