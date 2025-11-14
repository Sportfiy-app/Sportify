import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/user_sport_model.dart';

class UserSportsRepository {
  UserSportsRepository(this._apiClient);

  final ApiClient _apiClient;

  /// Get user's sports
  Future<List<UserSportModel>> getUserSports() async {
    try {
      final response = await _apiClient.get(
        '/users/sports',
        requireAuth: true,
      );
      final sports = (response['sports'] as List<dynamic>)
          .map((json) => UserSportModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return sports;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la récupération des sports: ${e.toString()}');
    }
  }

  /// Add a sport
  Future<UserSportModel> addSport({
    required String sport,
    String? level,
    String? ranking,
  }) async {
    try {
      final body = <String, dynamic>{
        'sport': sport,
      };
      if (level != null && level.isNotEmpty) {
        body['level'] = level;
      }
      if (ranking != null && ranking.isNotEmpty) {
        body['ranking'] = ranking;
      }

      final response = await _apiClient.post(
        '/users/sports',
        body: body,
        requireAuth: true,
      );
      return UserSportModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de l\'ajout du sport: ${e.toString()}');
    }
  }

  /// Update a sport
  Future<UserSportModel> updateSport(String sportId, {String? level, String? ranking}) async {
    try {
      final body = <String, dynamic>{};
      if (level != null) body['level'] = level;
      if (ranking != null) body['ranking'] = ranking;

      final response = await _apiClient.patch(
        '/users/sports/$sportId',
        body: body,
        requireAuth: true,
      );
      return UserSportModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la mise à jour du sport: ${e.toString()}');
    }
  }

  /// Remove a sport
  Future<void> removeSport(String sportId) async {
    try {
      await _apiClient.delete(
        '/users/sports/$sportId',
        requireAuth: true,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la suppression du sport: ${e.toString()}');
    }
  }
}

