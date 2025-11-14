class EventModel {
  final String id;
  final String title;
  final String description;
  final String sport;
  final String location;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime date;
  final String time; // HH:mm format
  final String organizerId;
  final String? organizerFirstName;
  final String? organizerLastName;
  final String? organizerAvatarUrl;
  final int minParticipants;
  final int maxParticipants;
  final int currentParticipants;
  final String status; // UPCOMING, ONGOING, COMPLETED, CANCELLED
  final bool isPublic;
  final double? price;
  final String? priceCurrency;
  final String? difficultyLevel;
  final List<String> tags;
  final String? imageUrl;
  final bool? isUserJoined;
  final bool? isUserInWaitingList;
  final String? userParticipationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<EventParticipantModel>? participants;
  final List<EventParticipantModel>? waitingList;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sport,
    required this.location,
    this.address,
    this.latitude,
    this.longitude,
    required this.date,
    required this.time,
    required this.organizerId,
    this.organizerFirstName,
    this.organizerLastName,
    this.organizerAvatarUrl,
    required this.minParticipants,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.status,
    required this.isPublic,
    this.price,
    this.priceCurrency,
    this.difficultyLevel,
    required this.tags,
    this.imageUrl,
    this.isUserJoined,
    this.isUserInWaitingList,
    this.userParticipationId,
    required this.createdAt,
    required this.updatedAt,
    this.participants,
    this.waitingList,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      sport: json['sport'] as String,
      location: json['location'] as String,
      address: json['address'] as String?,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      organizerId: json['organizerId'] as String,
      organizerFirstName: json['organizer'] != null ? (json['organizer'] as Map<String, dynamic>)['firstName'] as String? : null,
      organizerLastName: json['organizer'] != null ? (json['organizer'] as Map<String, dynamic>)['lastName'] as String? : null,
      organizerAvatarUrl: json['organizer'] != null ? (json['organizer'] as Map<String, dynamic>)['avatarUrl'] as String? : null,
      minParticipants: json['minParticipants'] as int,
      maxParticipants: json['maxParticipants'] as int,
      currentParticipants: () {
        if (json['currentParticipants'] != null) {
          return json['currentParticipants'] as int;
        }
        if (json['participations'] != null) {
          return (json['participations'] as List).length;
        }
        return 0;
      }(),
      status: json['status'] as String,
      isPublic: json['isPublic'] as bool,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      priceCurrency: json['priceCurrency'] as String?,
      difficultyLevel: json['difficultyLevel'] as String?,
      tags: json['tags'] != null ? List<String>.from(json['tags'] as List) : [],
      imageUrl: json['imageUrl'] as String?,
      isUserJoined: json['isUserJoined'] as bool?,
      isUserInWaitingList: json['isUserInWaitingList'] as bool?,
      userParticipationId: json['userParticipationId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      participants: json['participants'] != null
          ? (json['participants'] as List).map((p) => EventParticipantModel.fromJson(p as Map<String, dynamic>)).toList()
          : json['participations'] != null
              ? (json['participations'] as List).map((p) => EventParticipantModel.fromJson(p as Map<String, dynamic>)).toList()
              : null,
      waitingList: json['waitingList'] != null
          ? (json['waitingList'] as List).map((p) => EventParticipantModel.fromJson(p as Map<String, dynamic>)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sport': sport,
      'location': location,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'date': date.toIso8601String(),
      'time': time,
      'organizerId': organizerId,
      'minParticipants': minParticipants,
      'maxParticipants': maxParticipants,
      'currentParticipants': currentParticipants,
      'status': status,
      'isPublic': isPublic,
      'price': price,
      'priceCurrency': priceCurrency,
      'difficultyLevel': difficultyLevel,
      'tags': tags,
      'imageUrl': imageUrl,
      'isUserJoined': isUserJoined,
      'isUserInWaitingList': isUserInWaitingList,
      'userParticipationId': userParticipationId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class EventParticipantModel {
  final String id;
  final String userId;
  final String? userName;
  final String? userAvatar;
  final DateTime? joinedAt;
  final bool? isOrganizer;

  EventParticipantModel({
    required this.id,
    required this.userId,
    this.userName,
    this.userAvatar,
    this.joinedAt,
    this.isOrganizer,
  });

  factory EventParticipantModel.fromJson(Map<String, dynamic> json) {
    return EventParticipantModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['user'] != null ? '${(json['user'] as Map<String, dynamic>)['firstName'] ?? ''} ${(json['user'] as Map<String, dynamic>)['lastName'] ?? ''}'.trim() : null,
      userAvatar: json['user'] != null ? (json['user'] as Map<String, dynamic>)['avatarUrl'] as String? : null,
      joinedAt: json['joinedAt'] != null ? DateTime.parse(json['joinedAt'] as String) : null,
      isOrganizer: json['isOrganizer'] as bool? ?? false,
    );
  }
}

class EventsListResponse {
  final List<EventModel> events;
  final int total;
  final int limit;
  final int offset;

  EventsListResponse({
    required this.events,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory EventsListResponse.fromJson(Map<String, dynamic> json) {
    return EventsListResponse(
      events: (json['events'] as List).map((e) => EventModel.fromJson(e as Map<String, dynamic>)).toList(),
      total: json['total'] as int,
      limit: json['limit'] as int,
      offset: json['offset'] as int,
    );
  }
}

