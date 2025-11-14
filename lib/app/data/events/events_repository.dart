import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/event_model.dart';

class EventsRepository extends GetxService {
  EventsRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<EventModel> createEvent(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post(
        '/events',
        body: data,
        requireAuth: true,
      );
      return EventModel.fromJson(response);
    } on ApiException {
      // Re-throw API exceptions with their original status code and message
      rethrow;
    } catch (e, stackTrace) {
      // Log the actual error for debugging (only in debug mode)
      if (kDebugMode) {
        debugPrint('Error creating event: $e');
        debugPrint('Stack trace: $stackTrace');
        debugPrint('Event data: $data');
      }
      throw ApiException(0, 'Erreur lors de la création de l\'événement: ${e.toString()}');
    }
  }

  Future<EventsListResponse> getEvents({
    String? sport,
    String? status,
    int limit = 20,
    int offset = 0,
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    try {
      final queryParams = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (sport != null && sport.isNotEmpty) queryParams['sport'] = sport;
      if (status != null && status.isNotEmpty) queryParams['status'] = status;
      if (latitude != null) queryParams['latitude'] = latitude.toString();
      if (longitude != null) queryParams['longitude'] = longitude.toString();
      if (radius != null) queryParams['radius'] = radius.toString();

      final queryString = queryParams.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');

      final response = await _apiClient.get(
        '/events?$queryString',
        requireAuth: false, // Events can be public
      );
      return EventsListResponse.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la récupération des événements');
    }
  }

  Future<EventModel> getEventById(String eventId) async {
    try {
      final response = await _apiClient.get(
        '/events/$eventId',
        requireAuth: false, // Events can be public
      );
      return EventModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la récupération de l\'événement');
    }
  }

  Future<EventModel> updateEvent(String eventId, Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.patch(
        '/events/$eventId',
        body: data,
        requireAuth: true,
      );
      return EventModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la mise à jour de l\'événement');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _apiClient.delete(
        '/events/$eventId',
        requireAuth: true,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la suppression de l\'événement');
    }
  }

  Future<Map<String, dynamic>> joinEvent(String eventId) async {
    try {
      final response = await _apiClient.post(
        '/events/$eventId/join',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la participation à l\'événement');
    }
  }

  Future<Map<String, dynamic>> leaveEvent(String eventId) async {
    try {
      final response = await _apiClient.post(
        '/events/$eventId/leave',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la sortie de l\'événement');
    }
  }
}

