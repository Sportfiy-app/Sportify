import '../api/api_client.dart';
import '../api/api_exception.dart';

class VerificationRepository {
  VerificationRepository(this._apiClient);

  final ApiClient _apiClient;

  /// Send SMS verification code
  Future<Map<String, dynamic>> sendSmsCode(String phone) async {
    try {
      final response = await _apiClient.post(
        '/auth/verification/sms/send',
        body: {'phone': phone},
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de l\'envoi du code SMS: ${e.toString()}');
    }
  }

  /// Verify SMS code
  Future<Map<String, dynamic>> verifySmsCode(String phone, String code) async {
    try {
      final response = await _apiClient.post(
        '/auth/verification/sms/verify',
        body: {
          'phone': phone,
          'code': code,
        },
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la vérification du code SMS: ${e.toString()}');
    }
  }

  /// Send email verification
  Future<Map<String, dynamic>> sendEmailVerification(String email) async {
    try {
      final response = await _apiClient.post(
        '/auth/verification/email/send',
        body: {'email': email},
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de l\'envoi de l\'email de vérification: ${e.toString()}');
    }
  }

  /// Verify email token
  Future<Map<String, dynamic>> verifyEmail(String token) async {
    try {
      final response = await _apiClient.post(
        '/auth/verification/email/verify',
        body: {'token': token},
        requireAuth: false, // Can verify without auth
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la vérification de l\'email: ${e.toString()}');
    }
  }
}

