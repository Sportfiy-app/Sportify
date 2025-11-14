class UserSportModel {
  const UserSportModel({
    required this.id,
    required this.userId,
    required this.sport,
    this.level,
    this.ranking,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String sport;
  final String? level;
  final String? ranking;
  final String createdAt;
  final String updatedAt;

  factory UserSportModel.fromJson(Map<String, dynamic> json) {
    return UserSportModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      sport: json['sport'] as String,
      level: json['level'] as String?,
      ranking: json['ranking'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'sport': sport,
      'level': level,
      'ranking': ranking,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

