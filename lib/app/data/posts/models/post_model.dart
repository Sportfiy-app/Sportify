class PostModel {
  final String id;
  final String authorId;
  final String? authorFirstName;
  final String? authorLastName;
  final String? authorAvatarUrl;
  final String type; // TEXT, IMAGE, EVENT
  final String content;
  final String? imageUrl;
  final String? sport;
  final String? location;
  final double? latitude;
  final double? longitude;
  final double? distance;
  final String? eventId;
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.authorId,
    this.authorFirstName,
    this.authorLastName,
    this.authorAvatarUrl,
    required this.type,
    required this.content,
    this.imageUrl,
    this.sport,
    this.location,
    this.latitude,
    this.longitude,
    this.distance,
    this.eventId,
    required this.isLiked,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorFirstName: json['author'] != null ? (json['author'] as Map<String, dynamic>)['firstName'] as String? : null,
      authorLastName: json['author'] != null ? (json['author'] as Map<String, dynamic>)['lastName'] as String? : null,
      authorAvatarUrl: json['author'] != null ? (json['author'] as Map<String, dynamic>)['avatarUrl'] as String? : null,
      type: json['type'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      sport: json['sport'] as String?,
      location: json['location'] as String?,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      distance: json['distance'] != null ? (json['distance'] as num).toDouble() : null,
      eventId: json['eventId'] as String?,
      isLiked: json['isLiked'] as bool? ?? false,
      likesCount: json['_count'] != null ? (json['_count'] as Map<String, dynamic>)['likes'] as int? ?? 0 : 0,
      commentsCount: json['_count'] != null ? (json['_count'] as Map<String, dynamic>)['comments'] as int? ?? 0 : 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'type': type,
      'content': content,
      'imageUrl': imageUrl,
      'sport': sport,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'eventId': eventId,
      'isLiked': isLiked,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class PostsListResponse {
  final List<PostModel> posts;
  final int total;
  final int limit;
  final int offset;

  PostsListResponse({
    required this.posts,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory PostsListResponse.fromJson(Map<String, dynamic> json) {
    return PostsListResponse(
      posts: (json['posts'] as List).map((p) => PostModel.fromJson(p as Map<String, dynamic>)).toList(),
      total: json['total'] as int,
      limit: json['limit'] as int,
      offset: json['offset'] as int,
    );
  }
}

