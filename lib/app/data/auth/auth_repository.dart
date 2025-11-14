import 'package:get/get.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/auth_tokens.dart';

class AuthRepository extends GetxService {
  AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<AuthTokens> loginWithEmail({required String email, required String password}) async {
    final response = await _apiClient.post(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );
    return AuthTokens.fromJson(response);
  }

  Future<AuthTokens> register({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? phone,
    String? dateOfBirth,
    String? gender,
    String? city,
  }) async {
    final body = <String, dynamic>{
      'email': email,
      'password': password,
      if (firstName != null && firstName.isNotEmpty) 'firstName': firstName,
      if (lastName != null && lastName.isNotEmpty) 'lastName': lastName,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      if (dateOfBirth != null && dateOfBirth.isNotEmpty) 'dateOfBirth': dateOfBirth,
      if (gender != null && gender.isNotEmpty) 'gender': gender,
      if (city != null && city.isNotEmpty) 'city': city,
    };

    final response = await _apiClient.post('/auth/register', body: body);
    return AuthTokens.fromJson(response);
  }

  Future<AuthTokens> refresh(String refreshToken) async {
    final response = await _apiClient.post('/auth/refresh', body: {'refreshToken': refreshToken});
    return AuthTokens.fromJson(response);
  }

  Future<void> logout(String accessToken) async {
    try {
      await _apiClient.post(
        '/auth/logout',
        headers: {'Authorization': 'Bearer $accessToken'},
      );
    } on ApiException catch (error) {
      // Ignore 401/403 when logging out – token might already be invalidated.
      if (error.statusCode != 401 && error.statusCode != 403) {
        rethrow;
      }
    }
  }
}
