import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/user_model.dart';

class UsersRepository {
  UsersRepository(this._apiClient);

  final ApiClient _apiClient;

  /// Get current user profile
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _apiClient.get(
        '/users/me',
        requireAuth: true,
      );
      return UserModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la récupération du profil utilisateur: ${e.toString()}');
    }
  }

  /// Update user profile
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? avatarUrl,
    String? dateOfBirth,
    String? gender,
    String? city,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (firstName != null) body['firstName'] = firstName;
      if (lastName != null) body['lastName'] = lastName;
      if (phone != null) body['phone'] = phone;
      if (avatarUrl != null) body['avatarUrl'] = avatarUrl;
      if (dateOfBirth != null) body['dateOfBirth'] = dateOfBirth;
      if (gender != null) body['gender'] = gender;
      if (city != null) body['city'] = city;

      final response = await _apiClient.patch(
        '/users/profile',
        body: body,
        requireAuth: true,
      );
      return UserModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la mise à jour du profil: ${e.toString()}');
    }
  }

  /// Upload avatar image
  Future<UserModel> uploadAvatar(String imageUrl) async {
    try {
      final response = await _apiClient.post(
        '/users/avatar',
        body: {'imageUrl': imageUrl},
        requireAuth: true,
      );
      return UserModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de l\'upload de l\'avatar: ${e.toString()}');
    }
  }
}

