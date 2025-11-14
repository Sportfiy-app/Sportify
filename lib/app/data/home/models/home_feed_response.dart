class HomeFeedResponse {
  const HomeFeedResponse({
    required this.stories,
    required this.shortcuts,
    required this.posts,
    required this.upcomingEvent,
    required this.venue,
    required this.community,
  });

  final List<HomeStoryModel> stories;
  final List<HomeShortcutModel> shortcuts;
  final List<HomeFeedPostModel> posts;
  final HomeEventModel upcomingEvent;
  final HomeVenueModel venue;
  final HomeCommunityModel community;

  factory HomeFeedResponse.fromJson(Map<String, dynamic> json) {
    return HomeFeedResponse(
      stories: (json['stories'] as List<dynamic>? ?? [])
          .map((item) => HomeStoryModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      shortcuts: (json['shortcuts'] as List<dynamic>? ?? [])
          .map((item) => HomeShortcutModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      posts: (json['posts'] as List<dynamic>? ?? [])
          .map((item) => HomeFeedPostModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      upcomingEvent: HomeEventModel.fromJson(json['upcomingEvent'] as Map<String, dynamic>),
      venue: HomeVenueModel.fromJson(json['venue'] as Map<String, dynamic>),
      community: HomeCommunityModel.fromJson(json['community'] as Map<String, dynamic>),
    );
  }
}

class HomeStoryModel {
  const HomeStoryModel({this.name, this.imageUrl, this.isAddButton = false});

  final String? name;
  final String? imageUrl;
  final bool isAddButton;

  factory HomeStoryModel.fromJson(Map<String, dynamic> json) {
    return HomeStoryModel(
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isAddButton: (json['isAddButton'] as bool?) ?? false,
    );
  }
}

class HomeShortcutModel {
  const HomeShortcutModel({
    required this.label,
    required this.icon,
    required this.background,
    required this.iconColor,
  });

  final String label;
  final String icon;
  final String background;
  final String iconColor;

  factory HomeShortcutModel.fromJson(Map<String, dynamic> json) {
    return HomeShortcutModel(
      label: json['label'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      background: json['background'] as String? ?? '#FFFFFF',
      iconColor: json['iconColor'] as String? ?? '#000000',
    );
  }
}

class HomeFeedPostModel {
  const HomeFeedPostModel({
    required this.author,
    required this.avatarUrl,
    required this.location,
    required this.distance,
    required this.timeAgo,
    required this.sportLabel,
    required this.sportColor,
    required this.message,
    required this.stats,
    this.imageUrl,
    this.hasDirectMessageCta = false,
  });

  final String author;
  final String avatarUrl;
  final String location;
  final String distance;
  final String timeAgo;
  final String sportLabel;
  final String sportColor;
  final String message;
  final String? imageUrl;
  final HomeFeedStatsModel stats;
  final bool hasDirectMessageCta;

  factory HomeFeedPostModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedPostModel(
      author: json['author'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      location: json['location'] as String? ?? '',
      distance: json['distance'] as String? ?? '',
      timeAgo: json['timeAgo'] as String? ?? '',
      sportLabel: json['sportLabel'] as String? ?? '',
      sportColor: json['sportColor'] as String? ?? '#176BFF',
      message: json['message'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      stats: HomeFeedStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
      hasDirectMessageCta: (json['hasDirectMessageCta'] as bool?) ?? false,
    );
  }
}

class HomeFeedStatsModel {
  const HomeFeedStatsModel({
    required this.likes,
    required this.comments,
    required this.shares,
    required this.participants,
  });

  final int likes;
  final int comments;
  final int shares;
  final int participants;

  factory HomeFeedStatsModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedStatsModel(
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as num?)?.toInt() ?? 0,
      shares: (json['shares'] as num?)?.toInt() ?? 0,
      participants: (json['participants'] as num?)?.toInt() ?? 0,
    );
  }
}

class HomeEventModel {
  const HomeEventModel({
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

  factory HomeEventModel.fromJson(Map<String, dynamic> json) {
    return HomeEventModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      organizer: json['organizer'] as String? ?? '',
      badge: json['badge'] as String? ?? '',
      capacityLabel: json['capacityLabel'] as String? ?? '',
      priceLabel: json['priceLabel'] as String? ?? '',
      id: json['id'] as String?,
    );
  }
}

class HomeVenueModel {
  const HomeVenueModel({
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

  factory HomeVenueModel.fromJson(Map<String, dynamic> json) {
    return HomeVenueModel(
      name: json['name'] as String? ?? '',
      rating: json['rating'] as String? ?? '',
      distance: json['distance'] as String? ?? '',
      price: json['price'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}

class HomeCommunityModel {
  const HomeCommunityModel({
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

  factory HomeCommunityModel.fromJson(Map<String, dynamic> json) {
    return HomeCommunityModel(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      headline: json['headline'] as String? ?? '',
      message: json['message'] as String? ?? '',
      membersLabel: json['membersLabel'] as String? ?? '',
      matchesLabel: json['matchesLabel'] as String? ?? '',
    );
  }
}
