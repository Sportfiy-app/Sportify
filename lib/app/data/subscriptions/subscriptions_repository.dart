import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/subscription_model.dart';

class SubscriptionsRepository {
  SubscriptionsRepository(this._apiClient);

  final ApiClient _apiClient;

  /// Get user subscription
  Future<SubscriptionModel?> getSubscription() async {
    try {
      final response = await _apiClient.get(
        '/subscriptions',
        requireAuth: true,
      );
      final subscription = response['subscription'];
      if (subscription == null) return null;
      return SubscriptionModel.fromJson(subscription as Map<String, dynamic>);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la récupération de l\'abonnement: ${e.toString()}');
    }
  }

  /// Check if user is premium
  Future<bool> isPremium() async {
    try {
      final response = await _apiClient.get(
        '/subscriptions/premium',
        requireAuth: true,
      );
      return response['isPremium'] as bool? ?? false;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la vérification du statut premium: ${e.toString()}');
    }
  }

  /// Create subscription
  Future<SubscriptionModel> createSubscription({
    required String plan,
    String? stripeId,
  }) async {
    try {
      final body = <String, dynamic>{
        'plan': plan,
      };
      if (stripeId != null) {
        body['stripeId'] = stripeId;
      }

      final response = await _apiClient.post(
        '/subscriptions',
        body: body,
        requireAuth: true,
      );
      return SubscriptionModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la création de l\'abonnement: ${e.toString()}');
    }
  }

  /// Cancel subscription
  Future<SubscriptionModel> cancelSubscription(String subscriptionId) async {
    try {
      final response = await _apiClient.post(
        '/subscriptions/$subscriptionId/cancel',
        body: {},
        requireAuth: true,
      );
      return SubscriptionModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de l\'annulation de l\'abonnement: ${e.toString()}');
    }
  }
}

