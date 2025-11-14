import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileFriendsController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxString activeFilter = 'Tous'.obs;
  final RxnString selectedInitial = RxnString();
  final RxList<FriendItem> _friends = <FriendItem>[].obs;

  final List<String> filterOptions = const [
    'Tous',
    'Proches',
    'Récents',
    'Football',
    'Basketball',
    'Running',
    'Tennis',
  ];

  @override
  void onInit() {
    super.onInit();
    _friends.assignAll(_generateFriends());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  List<FriendItem> get allFriends => List.unmodifiable(_friends);

  int get totalFriends => _friends.length;

  int get onlineCount => _friends.where((friend) => friend.isOnline).length;

  int get nearbyCount => _friends.where((friend) => friend.distanceKm <= 5).length;

  int get favoritesCount => _friends.where((friend) => friend.favoriteSports.contains('Football')).length;

  int get activeCount =>
      _friends.where((friend) => DateTime.now().difference(friend.lastActive).inHours <= 6 || friend.isOnline).length;

  List<String> get availableInitials {
    final initials = _friends.map((friend) => friend.initial).toSet().toList()..sort();
    return initials;
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
    } else {
      activeFilter.value = value;
    }
  }

  void selectInitial(String? letter) {
    if (selectedInitial.value == letter) {
      selectedInitial.value = null;
    } else {
      selectedInitial.value = letter;
    }
  }

  void removeFriend(FriendItem friend) {
    _friends.removeWhere((item) => item.id == friend.id);
    Get.snackbar('Ami supprimé', '${friend.name} a été retiré de votre liste.');
  }

  void openFriend(FriendItem friend) {
    Get.toNamed(Routes.findPartnerProfile, arguments: friend.id);
  }

  void addFriend() {
    Get.snackbar('Inviter un ami', 'Recherche d’amis en préparation.');
  }

  List<FriendSection> get sections {
    final filtered = _filteredFriends();
    final grouped = <String, List<FriendItem>>{};
    for (final friend in filtered) {
      grouped.putIfAbsent(friend.initial, () => []).add(friend);
    }
    final keys = grouped.keys.toList()..sort();
    return keys.map((key) {
      final entries = grouped[key]!..sort((a, b) => a.name.compareTo(b.name));
      return FriendSection(letter: key, friends: entries);
    }).toList();
  }

  List<FriendItem> _filteredFriends() {
    final query = searchQuery.value.trim().toLowerCase();
    final filter = activeFilter.value;
    final initial = selectedInitial.value;

    return _friends.where((friend) {
      if (query.isNotEmpty && !friend.name.toLowerCase().contains(query)) {
        return false;
      }
      if (initial != null && friend.initial != initial) {
        return false;
      }
      switch (filter) {
        case 'Proches':
          return friend.distanceKm <= 5;
        case 'Récents':
          return DateTime.now().difference(friend.lastActive).inHours <= 24 || friend.isOnline;
        case 'Football':
        case 'Basketball':
        case 'Running':
        case 'Tennis':
          return friend.favoriteSports.contains(filter);
        default:
          return true;
      }
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  List<FriendItem> _generateFriends() {
    final now = DateTime.now();
    final random = Random(72);
    final data = <FriendItem>[
      FriendItem(
        id: 'f001',
        name: 'Alice Youp',
        avatarUrl: 'https://images.unsplash.com/photo-1521412644187-c49fa049e84d?auto=format&fit=crop&w=400&q=60',
        distanceKm: 2.1,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 5)),
        favoriteSports: const ['Tennis', 'Running'],
      ),
      FriendItem(
        id: 'f002',
        name: 'Antoine Martin',
        avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=400&q=60',
        distanceKm: 4.8,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 2, minutes: 30)),
        favoriteSports: const ['Football', 'Padel'],
      ),
      FriendItem(
        id: 'f003',
        name: 'Amélie Dubois',
        avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=60',
        distanceKm: 1.2,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 12)),
        favoriteSports: const ['Running', 'Yoga'],
      ),
      FriendItem(
        id: 'f004',
        name: 'Benjamin Leroy',
        avatarUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=400&q=60',
        distanceKm: 8.4,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 8)),
        favoriteSports: const ['Basketball', 'Football'],
      ),
      FriendItem(
        id: 'f005',
        name: 'Béatrice Moreau',
        avatarUrl: 'https://images.unsplash.com/photo-1554151228-14d9def656e4?auto=format&fit=crop&w=400&q=60',
        distanceKm: 12.0,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 26)),
        favoriteSports: const ['Natation', 'Running'],
      ),
      FriendItem(
        id: 'f006',
        name: 'Camille Rousseau',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 3.4,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 40)),
        favoriteSports: const ['Basketball', 'Running'],
      ),
      FriendItem(
        id: 'f007',
        name: 'Clara Dupont',
        avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=60',
        distanceKm: 6.2,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 5)),
        favoriteSports: const ['Tennis'],
      ),
      FriendItem(
        id: 'f008',
        name: 'Charles Hubert',
        avatarUrl: 'https://images.unsplash.com/photo-1542300058-59e69da1ee32?auto=format&fit=crop&w=400&q=60',
        distanceKm: 2.7,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 1, minutes: 10)),
        favoriteSports: const ['Football', 'Basketball'],
      ),
      FriendItem(
        id: 'f009',
        name: 'David Laurent',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 6.0,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 15)),
        favoriteSports: const ['Running', 'Cyclisme'],
      ),
      FriendItem(
        id: 'f010',
        name: 'Diana Petit',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 1.5,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 3)),
        favoriteSports: const ['Fitness', 'Yoga'],
      ),
      FriendItem(
        id: 'f011',
        name: 'Emma Rolland',
        avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=400&q=60',
        distanceKm: 9.2,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 3, minutes: 10)),
        favoriteSports: const ['Natation', 'Running'],
      ),
      FriendItem(
        id: 'f012',
        name: 'Élodie Garnier',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=60',
        distanceKm: 0.8,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 8)),
        favoriteSports: const ['Tennis', 'Football'],
      ),
      FriendItem(
        id: 'f013',
        name: 'Florent Bernard',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=60',
        distanceKm: 14.6,
        isOnline: false,
        lastActive: now.subtract(const Duration(days: 1, hours: 3)),
        favoriteSports: const ['Cyclisme'],
      ),
      FriendItem(
        id: 'f014',
        name: 'Gabriel Lefèvre',
        avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=60',
        distanceKm: 4.3,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 9, minutes: 45)),
        favoriteSports: const ['Football', 'Basketball'],
      ),
      FriendItem(
        id: 'f015',
        name: 'Hugo Colin',
        avatarUrl: 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?auto=format&fit=crop&w=400&q=60',
        distanceKm: 3.2,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 27)),
        favoriteSports: const ['Running', 'Cyclisme'],
      ),
      FriendItem(
        id: 'f016',
        name: 'Inès Perrin',
        avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=400&q=60',
        distanceKm: 5.1,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 12)),
        favoriteSports: const ['Basketball', 'Football'],
      ),
      FriendItem(
        id: 'f017',
        name: 'Jade Picard',
        avatarUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=400&q=60',
        distanceKm: 0.5,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 2)),
        favoriteSports: const ['Yoga', 'Natation'],
      ),
      FriendItem(
        id: 'f018',
        name: 'Julien Barthez',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 7.5,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 7)),
        favoriteSports: const ['Football', 'Tennis'],
      ),
      FriendItem(
        id: 'f019',
        name: 'Kenzo Faure',
        avatarUrl: 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=400&q=60',
        distanceKm: 11.3,
        isOnline: false,
        lastActive: now.subtract(const Duration(days: 2)),
        favoriteSports: const ['Basketball'],
      ),
      FriendItem(
        id: 'f020',
        name: 'Léa Fontaine',
        avatarUrl: 'https://images.unsplash.com/photo-1524504373700-1c0231e35318?auto=format&fit=crop&w=400&q=60',
        distanceKm: 2.4,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 16)),
        favoriteSports: const ['Running', 'Cyclisme'],
      ),
      FriendItem(
        id: 'f021',
        name: 'Léo Marin',
        avatarUrl: 'https://images.unsplash.com/photo-1552058544-f2b08422138a?auto=format&fit=crop&w=400&q=60',
        distanceKm: 18.2,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 40)),
        favoriteSports: const ['Football'],
      ),
      FriendItem(
        id: 'f022',
        name: 'Manon Ribeiro',
        avatarUrl: 'https://images.unsplash.com/photo-1502767089025-6572583495b0?auto=format&fit=crop&w=400&q=60',
        distanceKm: 4.0,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 35)),
        favoriteSports: const ['Basketball', 'Running'],
      ),
      FriendItem(
        id: 'f023',
        name: 'Noah Garnier',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 9.7,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 18)),
        favoriteSports: const ['Running', 'Cyclisme'],
      ),
      FriendItem(
        id: 'f024',
        name: 'Océane Vidal',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 1.8,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 6)),
        favoriteSports: const ['Yoga', 'Natation'],
      ),
      FriendItem(
        id: 'f025',
        name: 'Pauline Leblanc',
        avatarUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=60',
        distanceKm: 3.1,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 4)),
        favoriteSports: const ['Football', 'Tennis'],
      ),
      FriendItem(
        id: 'f026',
        name: 'Quentin Maes',
        avatarUrl: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=400&q=60',
        distanceKm: 2.9,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 50)),
        favoriteSports: const ['Basketball', 'Running'],
      ),
      FriendItem(
        id: 'f027',
        name: 'Raphaël Perrot',
        avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=400&q=60',
        distanceKm: 4.6,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 11)),
        favoriteSports: const ['Football', 'Cyclisme'],
      ),
      FriendItem(
        id: 'f028',
        name: 'Sophie Blin',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 13.4,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 55)),
        favoriteSports: const ['Running', 'Yoga'],
      ),
      FriendItem(
        id: 'f029',
        name: 'Thomas Bruneau',
        avatarUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=400&q=60',
        distanceKm: 0.9,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 5)),
        favoriteSports: const ['Football', 'Basketball'],
      ),
      FriendItem(
        id: 'f030',
        name: 'Ugo Delaunay',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 7.1,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 9)),
        favoriteSports: const ['Tennis', 'Running'],
      ),
      FriendItem(
        id: 'f031',
        name: 'Valentine Girard',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 5.6,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 55)),
        favoriteSports: const ['Cyclisme', 'Running'],
      ),
      FriendItem(
        id: 'f032',
        name: 'William Marais',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 10.2,
        isOnline: false,
        lastActive: now.subtract(const Duration(hours: 30)),
        favoriteSports: const ['Basketball'],
      ),
      FriendItem(
        id: 'f033',
        name: 'Xavier Roussel',
        avatarUrl: 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?auto=format&fit=crop&w=400&q=60',
        distanceKm: 16.0,
        isOnline: false,
        lastActive: now.subtract(const Duration(days: 3)),
        favoriteSports: const ['Football', 'Cyclisme'],
      ),
      FriendItem(
        id: 'f034',
        name: 'Yasmine Belaïd',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 2.2,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 21)),
        favoriteSports: const ['Running', 'Yoga'],
      ),
      FriendItem(
        id: 'f035',
        name: 'Zoé Navarro',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=400&q=60',
        distanceKm: 3.7,
        isOnline: true,
        lastActive: now.subtract(const Duration(minutes: 9)),
        favoriteSports: const ['Tennis', 'Football'],
      ),
    ];

    // Add a few procedurally generated names to simulate a larger list.
    const prefixes = ['Anna', 'Brice', 'Celia', 'Dorian', 'Eva', 'Fanny', 'Gaspard', 'Helena', 'Isaac', 'Jules'];
    for (var i = 0; i < 15; i++) {
      final prefix = prefixes[i % prefixes.length];
      final suffix = String.fromCharCode(65 + (i % 18));
      data.add(
        FriendItem(
          id: 'auto_$i',
          name: '$prefix $suffix.',
          avatarUrl:
              'https://images.unsplash.com/photo-${1500000000000 + (i * 12000000)}?auto=format&fit=crop&w=400&q=60',
          distanceKm: 1.0 + random.nextDouble() * 15,
          isOnline: random.nextBool(),
          lastActive: now.subtract(Duration(minutes: random.nextInt(60 * 72))),
          favoriteSports: [
            if (random.nextBool()) 'Football',
            if (random.nextBool()) 'Running',
            if (random.nextBool()) 'Basketball',
            if (random.nextBool()) 'Tennis',
          ].where((sport) => sport.isNotEmpty).toSet().toList(),
        ),
      );
    }

    return data..sort((a, b) => a.name.compareTo(b.name));
  }
}

class FriendSection {
  FriendSection({required this.letter, required this.friends});

  final String letter;
  final List<FriendItem> friends;
}

class FriendItem {
  const FriendItem({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.distanceKm,
    required this.isOnline,
    required this.lastActive,
    required this.favoriteSports,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final double distanceKm;
  final bool isOnline;
  final DateTime lastActive;
  final List<String> favoriteSports;

  String get distanceLabel => 'à ${distanceKm.toStringAsFixed(distanceKm >= 1 ? 0 : 1)} km';

  String get presenceLabel {
    if (isOnline) {
      return 'En ligne maintenant';
    }
    final minutes = DateTime.now().difference(lastActive).inMinutes;
    if (minutes < 60) {
      return 'Vu il y a ${minutes.clamp(1, 59)} min';
    }
    final hours = minutes ~/ 60;
    if (hours < 24) {
      return 'Vu il y a ${hours}h';
    }
    final days = hours ~/ 24;
    return 'Vu il y a ${days}j';
  }

  String get availabilityTag {
    if (isOnline) {
      return 'Disponible pour jouer';
    }
    final hours = DateTime.now().difference(lastActive).inHours;
    if (hours <= 3) {
      return 'Actif récemment';
    }
    if (hours <= 24) {
      return 'Prêt à programmer';
    }
    return 'À recontacter';
  }

  String get initial {
    final value = name.trim();
    if (value.isEmpty) {
      return '#';
    }
    return value[0].toUpperCase();
  }
}

