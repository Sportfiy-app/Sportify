class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String role;
  final String createdAt;
  final String updatedAt;

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return email.split('@').first;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      role: json['role'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'avatarUrl': avatarUrl,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

