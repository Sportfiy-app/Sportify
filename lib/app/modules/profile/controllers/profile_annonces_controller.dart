import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAnnoncesController extends GetxController {
  final List<AnnonceCard> annonces = const [
    AnnonceCard(
      id: 'a_001',
      title: 'Match de football ce samedi',
      subtitle: 'Moi • 4 km - Nice, France',
      timeAgo: 'Il y a 2 heures',
      description:
          '🏈 Match de football ce samedi à 15h au stade municipal ! Recherche 2 joueurs niveau intermédiaire. Ambiance décontractée et fair-play garantis. Qui est chaud ? 💪',
      imageUrl: 'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?auto=format&fit=crop&w=1200&q=60',
      stats: AnnonceStats(likes: 24, comments: 8, shares: 3, views: 156),
      status: AnnonceStatus.active,
      badges: ['En vedette'],
    ),
    AnnonceCard(
      id: 'a_002',
      title: 'Partenaire tennis recherché',
      subtitle: 'Moi • 2 km - Nice, France',
      timeAgo: 'Il y a 1 jour',
      description: '🎾 Partenaire de tennis recherché ! Niveau débutant/intermédiaire pour sessions régulières. Court disponible au club local.',
      imageUrl: 'https://images.unsplash.com/photo-1502877338535-766e1452684a?auto=format&fit=crop&w=1200&q=60',
      stats: AnnonceStats(likes: 12, comments: 5, shares: 1, views: 134),
      status: AnnonceStatus.expiring,
      badges: ['Expire bientôt'],
    ),
    AnnonceCard(
      id: 'a_003',
      title: 'Course matinale au parc',
      subtitle: 'Moi • 6 km - Cannes, France',
      timeAgo: 'Il y a 3 jours',
      description: '🏃‍♂️ Course matinale au parc Phoenix ! Préparation semi-marathon. Rythme 5:30 min/km. Rdv 6h30 entrée principale.',
      imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=1200&q=60',
      stats: AnnonceStats(likes: 18, comments: 12, shares: 7, views: 298),
      status: AnnonceStatus.active,
      badges: [],
    ),
    AnnonceCard(
      id: 'a_004',
      title: 'Séances de yoga en plein air',
      subtitle: 'Moi • 1 km - Nice, France',
      timeAgo: 'Il y a 5 jours',
      description: '🧘‍♀️ Séances de yoga en plein air ! Détente et bien-être au programme. Tous niveaux, matériel fourni.',
      imageUrl: 'https://images.unsplash.com/photo-1552196563-55cd4e45efb3?auto=format&fit=crop&w=1200&q=60',
      stats: AnnonceStats(likes: 42, comments: 28, shares: 9, views: 387),
      status: AnnonceStatus.active,
      badges: [],
    ),
  ];

  final List<ActivityLog> activities = const [
    ActivityLog(
      message: 'Marie L. a aimé votre annonce "Match de football"',
      timeAgo: 'Il y a 2 minutes',
      tone: ActivityTone.primary,
    ),
    ActivityLog(
      message: 'Thomas R. a commenté votre annonce "Tennis"',
      timeAgo: 'Il y a 15 minutes',
      tone: ActivityTone.success,
    ),
    ActivityLog(
      message: 'Sophie M. a partagé votre annonce "Yoga"',
      timeAgo: 'Il y a 1 heure',
      tone: ActivityTone.warning,
    ),
  ];

  final SummaryMetrics summary = const SummaryMetrics(
    total: 25,
    active: 18,
    views: 1200,
    likes: 89,
    newViews: 156,
    newLikes: 28,
    engagementDelta: 8.5,
  );

  final Rx<AnnonceFilter> filter = AnnonceFilter.all.obs;

  List<AnnonceCard> get filteredAnnonces {
    return annonces.where((annonce) {
      switch (filter.value) {
        case AnnonceFilter.all:
          return true;
        case AnnonceFilter.active:
          return annonce.status == AnnonceStatus.active || annonce.status == AnnonceStatus.expiring;
        case AnnonceFilter.expired:
          return annonce.status == AnnonceStatus.expired;
        case AnnonceFilter.draft:
          return annonce.status == AnnonceStatus.draft;
      }
    }).toList();
  }

  void setFilter(AnnonceFilter value) {
    filter.value = value;
  }

  void editAnnonce(AnnonceCard annonce) {
    Get.back();
    Get.snackbar('Modifier l’annonce', 'Ouverture du formulaire pour "${annonce.title}" à venir.');
  }

  void duplicateAnnonce(AnnonceCard annonce) {
    Get.back();
    Get.snackbar('Dupliquer', 'Duplication de "${annonce.title}" en préparation.');
  }

  void confirmDeletion(AnnonceCard annonce) {
    Get.back();
    Get.defaultDialog(
      title: 'Supprimer cette annonce ?',
      middleText: 'Cette action est irréversible. Voulez-vous vraiment supprimer "${annonce.title}" ?',
      textConfirm: 'Supprimer',
      textCancel: 'Annuler',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        Get.back();
        Get.snackbar('Annonce supprimée', '"${annonce.title}" a été supprimée.');
      },
      onCancel: () {},
    );
  }

  void loadMore() {
    Get.snackbar('Annonces', 'Chargement de nouvelles annonces à venir.');
  }
}

enum AnnonceStatus {
  active,
  expiring,
  expired,
  draft,
}

class AnnonceCard {
  const AnnonceCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.description,
    required this.imageUrl,
    required this.stats,
    required this.status,
    this.badges = const [],
  });

  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final String description;
  final String imageUrl;
  final AnnonceStats stats;
  final AnnonceStatus status;
  final List<String> badges;
}

class AnnonceStats {
  const AnnonceStats({
    required this.likes,
    required this.comments,
    required this.shares,
    required this.views,
  });

  final int likes;
  final int comments;
  final int shares;
  final int views;
}

class SummaryMetrics {
  const SummaryMetrics({
    required this.total,
    required this.active,
    required this.views,
    required this.likes,
    required this.newViews,
    required this.newLikes,
    required this.engagementDelta,
  });

  final int total;
  final int active;
  final int views;
  final int likes;
  final int newViews;
  final int newLikes;
  final double engagementDelta;
}

class ActivityLog {
  const ActivityLog({
    required this.message,
    required this.timeAgo,
    required this.tone,
  });

  final String message;
  final String timeAgo;
  final ActivityTone tone;
}

enum ActivityTone {
  primary,
  success,
  warning,
}

enum AnnonceFilter { all, active, expired, draft }

