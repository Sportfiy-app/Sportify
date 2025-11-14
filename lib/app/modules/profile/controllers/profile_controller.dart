import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/users/users_repository.dart';
import '../../../data/api/api_exception.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final UsersRepository _usersRepository = Get.find<UsersRepository>();
  
  final Rx<UserProfile?> profile = Rx<UserProfile?>(null);
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();

  final List<SportSummary> sports = const [
    SportSummary(
      name: 'Football',
      levelLabel: 'Amateur',
      years: 3,
      weeklyHours: 2,
      color: 0xFF16A34A,
      icon: SportIcon.soccer,
    ),
    SportSummary(
      name: 'Fitness',
      levelLabel: 'Amateur',
      years: 1,
      weeklyHours: 5,
      color: 0xFFF97316,
      icon: SportIcon.fitness,
    ),
  ];

  final List<ProfileStat> stats = const [
    ProfileStat(
      label: 'Mes annonces',
      value: '25',
      accent: 0xFF176BFF,
      icon: Icons.campaign_rounded,
      route: Routes.profileAnnonces,
    ),
    ProfileStat(
      label: 'Réservations',
      value: '4',
      accent: 0xFF16A34A,
      icon: Icons.calendar_month_rounded,
      route: Routes.profileBookings,
    ),
    ProfileStat(
      label: 'Favoris',
      value: '12',
      accent: 0xFF0EA5E9,
      icon: Icons.bookmark_rounded,
      route: Routes.profileSavedAnnouncements,
    ),
    ProfileStat(
      label: 'Mes amis',
      value: '512',
      accent: 0xFFFFB800,
      icon: Icons.people_alt_rounded,
      route: Routes.profileFriends,
    ),
  ];

  final List<ActivityPoint> weeklyActivity = const [
    ActivityPoint(label: 'L', value: 4),
    ActivityPoint(label: 'M', value: 3),
    ActivityPoint(label: 'M', value: 6),
    ActivityPoint(label: 'J', value: 4),
    ActivityPoint(label: 'V', value: 5),
    ActivityPoint(label: 'S', value: 2),
    ActivityPoint(label: 'D', value: 0),
  ];

  final List<ProfileBadge> badges = const [
    ProfileBadge(title: 'Premier match', color: 0xFFFFB800),
    ProfileBadge(title: '10 amis', color: 0xFF16A34A),
    ProfileBadge(title: '5 réservations', color: 0xFF176BFF),
    ProfileBadge.locked(),
    ProfileBadge.locked(),
    ProfileBadge.locked(),
  ];

  final List<RatingBreakdown> ratingBreakdown = const [
    RatingBreakdown(stars: 5, percentage: 70, count: 16),
    RatingBreakdown(stars: 4, percentage: 26, count: 5),
    RatingBreakdown(stars: 3, percentage: 8, count: 2),
  ];

  final List<UserComment> comments = const [
    UserComment(
      author: 'Marie',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      message: 'Excellent partenaire de tennis ! Très ponctuel et fair-play.',
      hoursAgo: 2,
      rating: 5,
    ),
    UserComment(
      author: 'Thomas',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      message: 'Match de foot super sympa ! À refaire bientôt.',
      hoursAgo: 5,
      rating: 5,
    ),
  ];

  final List<FriendPreview> friends = const [
    FriendPreview(
      name: 'Marie',
      avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=60',
      statusColor: 0xFF16A34A,
    ),
    FriendPreview(
      name: 'Thomas',
      avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=60',
      statusColor: 0xFFF59E0B,
    ),
    FriendPreview(
      name: 'Sarah',
      avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=60',
      statusColor: 0xFFD1D5DB,
    ),
    FriendPreview(
      name: 'Alex',
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=60',
      statusColor: 0xFF176BFF,
    ),
  ];

  final List<FriendActivity> friendActivities = const [
    FriendActivity(
      author: 'Marie',
      avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=60',
      message: 'a rejoint un match de tennis',
      timeLabel: '2h',
    ),
    FriendActivity(
      author: 'Thomas',
      avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=60',
      message: 'a créé un nouveau groupe Football',
      timeLabel: '5h',
    ),
  ];

  final List<QuickAction> quickActions = const [
    QuickAction(
      icon: SportIcon.history,
      title: 'Mes annonces',
      subtitle: 'Consulter et gérer',
      route: Routes.profileAnnonces,
    ),
    QuickAction(
      icon: SportIcon.bookmark,
      title: 'Favoris',
      subtitle: 'Annonces enregistrées',
      route: Routes.profileSavedAnnouncements,
    ),
    QuickAction(
      icon: SportIcon.eye,
      title: 'Profil public',
      subtitle: 'Voir comme les autres',
    ),
    QuickAction(
      icon: SportIcon.chart,
      title: 'Historique',
      subtitle: 'Mes activités',
    ),
    QuickAction(
      icon: SportIcon.trophy,
      title: 'Statistiques',
      subtitle: 'Mes performances',
    ),
    QuickAction(
      icon: SportIcon.gift,
      title: 'Récompenses',
      subtitle: 'Mes avantages',
    ),
    QuickAction(
      icon: SportIcon.soccer,
      title: 'Mes réservations',
      subtitle: 'Voir à venir',
      route: Routes.profileBookings,
    ),
  ];

  void editProfile() {
    Get.toNamed(Routes.profileEdit);
  }

  void openSettings() {
    Get.snackbar('Paramètres', 'Accès aux paramètres du profil prochainement.');
  }

  void changeAvatar() {
    Get.snackbar('Avatar', 'Sélection d’une nouvelle photo en préparation.');
  }

  void viewPublicProfile() {
    Get.snackbar('Profil public', 'Affichage du profil public à venir.');
  }

  void openQuickAction(QuickAction action) {
    if (action.route != null) {
      Get.toNamed(action.route!);
      return;
    }
    Get.snackbar(action.title, action.subtitle);
  }

  void addSport() {
    Get.snackbar('Sports', 'Ajout d’un nouveau sport prochainement.');
  }

  void viewAllBadges() {
    Get.snackbar('Badges', 'Affichage de tous les badges à venir.');
  }

  void viewAllFriends() {
    Get.toNamed(Routes.profileFriends);
  }

  void filterFriends(String filter) {
    Get.snackbar('Filtre', 'Filtre appliqué : $filter');
  }

  void openStat(ProfileStat stat) {
    if (stat.route != null) {
      Get.toNamed(stat.route!);
    } else {
      Get.snackbar(stat.label, 'Navigation à venir.');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final user = await _usersRepository.getCurrentUser();
      
      // Map backend user to UserProfile
      // Note: Some fields like level, xp, city, age, etc. are not in the backend yet
      // These would need to be added to the backend schema or calculated from other data
      profile.value = UserProfile(
        id: user.id,
        name: user.fullName,
        city: 'Nice, France', // TODO: Add location to backend
        age: 28, // TODO: Add birthDate to backend and calculate age
        level: 2, // TODO: Calculate from XP or add to backend
        xp: 1280, // TODO: Calculate from activities or add to backend
        xpTarget: 2000, // TODO: Add to backend
        avatarUrl: user.avatarUrl ?? 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=60',
        streakDays: 7, // TODO: Calculate from activities
        streakBest: 12, // TODO: Calculate from activities
        ratingAverage: 4.7, // TODO: Calculate from reviews
        ratingCount: 23, // TODO: Count reviews
      );
    } catch (e) {
      errorMessage.value = 'Impossible de charger le profil';
      if (e is ApiException) {
        if (kDebugMode) {
          debugPrint('Error loading profile: ${e.message}');
        }
      }
      // Keep default profile on error for now
      profile.value = const UserProfile(
        id: 'unknown',
        name: 'Utilisateur',
        city: 'Non spécifié',
        age: 0,
        level: 1,
        xp: 0,
        xpTarget: 1000,
        avatarUrl: '',
        streakDays: 0,
        streakBest: 0,
        ratingAverage: 0.0,
        ratingCount: 0,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }
}

class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.city,
    required this.age,
    required this.level,
    required this.xp,
    required this.xpTarget,
    required this.avatarUrl,
    required this.streakDays,
    required this.streakBest,
    required this.ratingAverage,
    required this.ratingCount,
  });

  final String id;
  final String name;
  final String city;
  final int age;
  final int level;
  final int xp;
  final int xpTarget;
  final String avatarUrl;
  final int streakDays;
  final int streakBest;
  final double ratingAverage;
  final int ratingCount;

  double get xpProgress => xpTarget == 0 ? 0 : xp / xpTarget;
  int get xpRemaining => (xpTarget - xp).clamp(0, xpTarget);
}

class SportSummary {
  const SportSummary({
    required this.name,
    required this.levelLabel,
    required this.years,
    required this.weeklyHours,
    required this.color,
    required this.icon,
  });

  final String name;
  final String levelLabel;
  final int years;
  final int weeklyHours;
  final int color;
  final SportIcon icon;
}

class ProfileStat {
  const ProfileStat({
    required this.label,
    required this.value,
    required this.accent,
    this.icon,
    this.route,
  });

  final String label;
  final String value;
  final int accent;
  final IconData? icon;
  final String? route;
}

class ActivityPoint {
  const ActivityPoint({required this.label, required this.value});

  final String label;
  final int value;
}

class ProfileBadge {
  const ProfileBadge({
    required this.title,
    required this.color,
    this.locked = false,
  });

  const ProfileBadge.locked()
      : title = 'Mystère',
        color = 0xFFE5E7EB,
        locked = true;

  final String title;
  final int color;
  final bool locked;
}

class RatingBreakdown {
  const RatingBreakdown({
    required this.stars,
    required this.percentage,
    required this.count,
  });

  final int stars;
  final int percentage;
  final int count;
}

class UserComment {
  const UserComment({
    required this.author,
    required this.avatarUrl,
    required this.message,
    required this.hoursAgo,
    required this.rating,
  });

  final String author;
  final String avatarUrl;
  final String message;
  final int hoursAgo;
  final int rating;
}

class FriendPreview {
  const FriendPreview({
    required this.name,
    required this.avatarUrl,
    required this.statusColor,
  });

  final String name;
  final String avatarUrl;
  final int statusColor;
}

class FriendActivity {
  const FriendActivity({
    required this.author,
    required this.avatarUrl,
    required this.message,
    required this.timeLabel,
  });

  final String author;
  final String avatarUrl;
  final String message;
  final String timeLabel;
}

class QuickAction {
  const QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.route,
  });

  final SportIcon icon;
  final String title;
  final String subtitle;
  final String? route;
}

enum SportIcon {
  soccer,
  fitness,
  trophy,
  chart,
  eye,
  history,
  gift,
  bookmark,
}

