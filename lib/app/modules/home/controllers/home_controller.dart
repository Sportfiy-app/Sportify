import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/home/home_repository.dart';
import '../../../data/home/models/home_feed_response.dart';

enum HomeFeedTab { recommended, friends, nearby, live }

class HomeController extends GetxController {
  HomeController(this._homeRepository);

  final HomeRepository _homeRepository;

  static const versionLabel = 'Version 1.0.0';

  final Rx<HomeFeedTab> currentTab = HomeFeedTab.recommended.obs;
  final RxString sportFilter = 'Tous les sports'.obs;
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();

  final RxList<HomeStory> _stories = <HomeStory>[].obs;
  final RxList<HomeQuickShortcut> _shortcuts = <HomeQuickShortcut>[].obs;
  final RxList<HomeFeedPost> _feedPosts = <HomeFeedPost>[].obs;
  final Rx<HomeEventHighlight?> _upcomingEvent = Rx<HomeEventHighlight?>(null);
  final Rx<HomeVenueRecommendation?> _venueHighlight = Rx<HomeVenueRecommendation?>(null);
  final Rx<HomeCommunityHighlight?> _communityHighlight = Rx<HomeCommunityHighlight?>(null);

  List<HomeStory> get stories => _stories;
  List<HomeQuickShortcut> get shortcuts => _shortcuts;
  List<HomeFeedPost> get feedPosts => _feedPosts;
  
  // Filtered posts based on current tab and sport filter - reactive getter
  List<HomeFeedPost> get filteredFeedPosts {
    // Access currentTab.value and sportFilter.value to make this reactive
    final activeTab = currentTab.value;
    final selectedSport = sportFilter.value;
    
    return _feedPosts.where((post) {
      try {
        // First filter by tab
        final postTabs = post.tabs;
        final matchesTab = postTabs.isEmpty 
            ? activeTab == HomeFeedTab.recommended
            : postTabs.contains(activeTab);
        
        if (!matchesTab) return false;
        
        // Then filter by sport if not "Tous les sports"
        if (selectedSport == 'Tous les sports') {
          return true;
        }
        
        return post.sportLabel == selectedSport;
      } catch (e) {
        // Safety fallback: if tabs is null or invalid, show in recommended only
        return activeTab == HomeFeedTab.recommended;
      }
    }).toList();
  }
  HomeEventHighlight? get upcomingEvent => _upcomingEvent.value;
  HomeVenueRecommendation? get venueHighlight => _venueHighlight.value;
  HomeCommunityHighlight? get communityHighlight => _communityHighlight.value;

  final List<String> availableSportFilters = const [
    'Tous les sports',
    'Football',
    'Tennis',
    'Running',
    'Basketball',
    'Fitness',
  ];

  @override
  void onInit() {
    super.onInit();
    // Don't set defaults - only show real data from backend
    // _setDefaults(); // Removed - we only want real data
    fetchHome();
  }


  Future<void> fetchHome() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final response = await _homeRepository.fetchHome();
      _stories.assignAll(response.stories.map(_mapStory).toList());
      _shortcuts.assignAll(response.shortcuts.map(_mapShortcut).toList());
      // Map posts and ensure all have tabs
      final mappedPosts = response.posts.map((postModel) {
        final post = _mapPost(postModel);
        // Ensure post has valid tabs (default to recommended if empty)
        if (post.tabs.isEmpty) {
          return HomeFeedPost(
            author: post.author,
            avatarUrl: post.avatarUrl,
            location: post.location,
            distance: post.distance,
            timeAgo: post.timeAgo,
            sportLabel: post.sportLabel,
            sportColor: post.sportColor,
            message: post.message,
            imageUrl: post.imageUrl,
            stats: post.stats,
            hasDirectMessageCta: post.hasDirectMessageCta,
            tabs: [HomeFeedTab.recommended],
          );
        }
        return post;
      }).toList();
      _feedPosts.assignAll(mappedPosts);
      
      // Map event - only set if event has valid data
      if (response.upcomingEvent.title.isNotEmpty && response.upcomingEvent.title != 'Aucun événement à venir') {
        _upcomingEvent.value = _mapEvent(response.upcomingEvent);
      } else {
        _upcomingEvent.value = null;
      }
      
      // Map venue and community - always set (backend provides defaults)
      _venueHighlight.value = _mapVenue(response.venue);
      _communityHighlight.value = _mapCommunity(response.community);
    } catch (error) {
      errorMessage.value = "Impossible de récupérer l'actualité Sportify.";
      // Clear posts on error - don't show mock data
      _feedPosts.clear();
      _stories.clear();
      _shortcuts.clear();
    } finally {
      isLoading.value = false;
    }
  }

  HomeStory _mapStory(HomeStoryModel model) {
    return HomeStory(name: model.name, imageUrl: model.imageUrl, isAddButton: model.isAddButton);
  }

  HomeQuickShortcut _mapShortcut(HomeShortcutModel model) {
    return HomeQuickShortcut(
      label: model.label,
      icon: _mapIcon(model.icon),
      background: _parseHexColor(model.background),
      iconColor: _parseHexColor(model.iconColor),
    );
  }

  HomeFeedPost _mapPost(HomeFeedPostModel model) {
    // Default to recommended tab if no tabs specified from API
    return HomeFeedPost(
      author: model.author,
      avatarUrl: model.avatarUrl,
      location: model.location,
      distance: model.distance,
      timeAgo: model.timeAgo,
      sportLabel: model.sportLabel,
      sportColor: _parseHexColor(model.sportColor),
      message: model.message,
      imageUrl: model.imageUrl,
      stats: HomeFeedStats(
        likes: model.stats.likes,
        comments: model.stats.comments,
        shares: model.stats.shares,
        participants: model.stats.participants,
      ),
      hasDirectMessageCta: model.hasDirectMessageCta,
      tabs: [HomeFeedTab.recommended], // Default to recommended for API posts
    );
  }

  HomeEventHighlight _mapEvent(HomeEventModel model) {
    return HomeEventHighlight(
      title: model.title,
      subtitle: model.subtitle,
      organizer: model.organizer,
      badge: model.badge,
      capacityLabel: model.capacityLabel,
      priceLabel: model.priceLabel,
      id: model.id,
    );
  }

  HomeVenueRecommendation _mapVenue(HomeVenueModel model) {
    return HomeVenueRecommendation(
      name: model.name,
      rating: model.rating,
      distance: model.distance,
      price: model.price,
      imageUrl: model.imageUrl,
    );
  }

  HomeCommunityHighlight _mapCommunity(HomeCommunityModel model) {
    return HomeCommunityHighlight(
      title: model.title,
      subtitle: model.subtitle,
      headline: model.headline,
      message: model.message,
      membersLabel: model.membersLabel,
      matchesLabel: model.matchesLabel,
    );
  }

  Color _parseHexColor(String value) {
    var hex = value.trim();
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    } else if (hex.startsWith('0x')) {
      hex = hex.substring(2);
    }
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  IconData _mapIcon(String iconName) {
    switch (iconName) {
      case 'event_available_outlined':
        return Icons.event_available_outlined;
      case 'location_on_outlined':
        return Icons.location_on_outlined;
      case 'groups_2_outlined':
        return Icons.groups_2_outlined;
      case 'military_tech_outlined':
        return Icons.military_tech_outlined;
      default:
        return Icons.sports_soccer_rounded;
    }
  }

  void changeTab(HomeFeedTab tab) {
    currentTab.value = tab;
  }

  void selectSportFilter(String label) {
    sportFilter.value = label;
    update(); // Update GetBuilder listeners
  }

  // Get icon for a sport
  IconData getSportIcon(String sport) {
    switch (sport) {
      case 'Football':
        return Icons.sports_soccer_rounded;
      case 'Tennis':
        return Icons.sports_tennis_rounded;
      case 'Running':
        return Icons.directions_run_rounded;
      case 'Basketball':
        return Icons.sports_basketball_rounded;
      case 'Fitness':
        return Icons.fitness_center_rounded;
      case 'Tous les sports':
      default:
        return Icons.sports_rounded;
    }
  }

  // Get color for a sport
  Color getSportColor(String sport) {
    switch (sport) {
      case 'Football':
        return const Color(0xFF176BFF);
      case 'Tennis':
        return const Color(0xFF16A34A);
      case 'Running':
        return const Color(0xFF16A34A);
      case 'Basketball':
        return const Color(0xFFFFB800);
      case 'Fitness':
        return const Color(0xFF0EA5E9);
      case 'Tous les sports':
      default:
        return const Color(0xFF176BFF);
    }
  }

  void onSearchTap() {
    Get.snackbar('Recherche', 'Fonction recherche à venir');
  }

  void onNotificationsTap() {
    Get.snackbar('Notifications', 'Vous êtes à jour !');
  }

  void onNewMessageTap() {
    Get.snackbar('Messages', 'Ouverture des messages prochainement');
  }

  void onCreateEventTap() {
    Get.toNamed('/event/create');
  }

  void onQuickShortcutTap(HomeQuickShortcut shortcut) {
    switch (shortcut.label) {
      case 'Créer événement':
        Get.toNamed('/event/create');
        break;
      case 'Terrains proches':
        Get.toNamed('/map/venues');
        break;
      case 'Groupes':
        Get.toNamed('/groups');
        break;
      case 'Tournois':
        Get.snackbar(
          'Tournois',
          'Fonctionnalité à venir',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF0EA5E9).withValues(alpha: 0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          icon: const Icon(Icons.military_tech_rounded, color: Colors.white),
        );
        break;
      default:
        Get.snackbar(shortcut.label, 'Action à venir');
    }
  }

  void onFeedPostAction(HomeFeedPost post) {
    Get.snackbar(post.author, 'Interaction prochainement');
  }

  void onLoadMore() {
    Get.snackbar('À la une', 'Chargement de nouvelles publications');
  }

  void onVenueAction() {
    Get.snackbar('Réservation', 'Réservation du terrain en cours');
  }

  void onCommunityAction() {
    Get.snackbar('Communauté', 'Merci de faire partie de Sportify !');
  }
}

class HomeStory {
  const HomeStory({this.name, this.imageUrl, this.isAddButton = false});

  final String? name;
  final String? imageUrl;
  final bool isAddButton;
}

class HomeQuickShortcut {
  const HomeQuickShortcut({
    required this.label,
    required this.icon,
    required this.background,
    required this.iconColor,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color iconColor;
}

class HomeFeedPost {
  const HomeFeedPost({
    required this.author,
    required this.avatarUrl,
    required this.location,
    required this.distance,
    required this.timeAgo,
    required this.sportLabel,
    required this.sportColor,
    required this.message,
    required this.stats,
    required this.tabs,
    this.imageUrl,
    this.hasDirectMessageCta = false,
  });

  final String author;
  final String avatarUrl;
  final String location;
  final String distance;
  final String timeAgo;
  final String sportLabel;
  final Color sportColor;
  final String message;
  final String? imageUrl;
  final HomeFeedStats stats;
  final bool hasDirectMessageCta;
  final List<HomeFeedTab> tabs; // Which tabs this post should appear in
}

class HomeFeedStats {
  const HomeFeedStats({
    required this.likes,
    required this.comments,
    required this.shares,
    required this.participants,
  });

  final int likes;
  final int comments;
  final int shares;
  final int participants;
}

class HomeEventHighlight {
  const HomeEventHighlight({
    required this.title,
    required this.subtitle,
    required this.organizer,
    required this.badge,
    required this.capacityLabel,
    required this.priceLabel,
    this.id,
  });

  final String title;
  final String subtitle;
  final String organizer;
  final String badge;
  final String capacityLabel;
  final String priceLabel;
  final String? id;
}

class HomeVenueRecommendation {
  const HomeVenueRecommendation({
    required this.name,
    required this.rating,
    required this.distance,
    required this.price,
    required this.imageUrl,
  });

  final String name;
  final String rating;
  final String distance;
  final String price;
  final String imageUrl;
}

class HomeCommunityHighlight {
  const HomeCommunityHighlight({
    required this.title,
    required this.subtitle,
    required this.headline,
    required this.message,
    required this.membersLabel,
    required this.matchesLabel,
  });

  final String title;
  final String subtitle;
  final String headline;
  final String message;
  final String membersLabel;
  final String matchesLabel;
}
