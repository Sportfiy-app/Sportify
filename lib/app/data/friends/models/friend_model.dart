class FriendModel {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String? email;
  final String? city;
  final String friendshipId;
  final String status; // PENDING, ACCEPTED, BLOCKED
  final DateTime createdAt;

  FriendModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.email,
    this.city,
    required this.friendshipId,
    required this.status,
    required this.createdAt,
  });

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return email ?? 'Utilisateur';
  }

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String?,
      city: json['city'] as String?,
      friendshipId: json['friendshipId'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class FriendRequestModel {
  final String id;
  final FriendModel requester;
  final FriendModel addressee;
  final String status;
  final DateTime createdAt;

  FriendRequestModel({
    required this.id,
    required this.requester,
    required this.addressee,
    required this.status,
    required this.createdAt,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      id: json['id'] as String,
      requester: FriendModel.fromJson(json['requester'] as Map<String, dynamic>),
      addressee: FriendModel.fromJson(json['addressee'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class FriendsListResponse {
  final List<FriendModel> friends;
  final int total;
  final int limit;
  final int offset;

  FriendsListResponse({
    required this.friends,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory FriendsListResponse.fromJson(Map<String, dynamic> json) {
    return FriendsListResponse(
      friends: (json['friends'] as List<dynamic>)
          .map((item) => FriendModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      limit: json['limit'] as int,
      offset: json['offset'] as int,
    );
  }
}

