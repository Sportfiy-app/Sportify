import 'package:get/get.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/friend_model.dart';

class FriendsRepository extends GetxService {
  FriendsRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<FriendRequestModel> sendFriendRequest(String addresseeId) async {
    try {
      final response = await _apiClient.post(
        '/friends/request',
        body: {
          'addresseeId': addresseeId,
        },
        requireAuth: true,
      );
      return FriendRequestModel.fromJson(response);
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> respondToFriendRequest({
    required String friendshipId,
    required String action, // 'accept', 'reject', 'block'
  }) async {
    try {
      final response = await _apiClient.post(
        '/friends/respond',
        body: {
          'friendshipId': friendshipId,
          'action': action,
        },
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    }
  }

  Future<FriendsListResponse> getFriends({
    String? status, // 'PENDING', 'ACCEPTED', 'BLOCKED'
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (status != null) {
        queryParams['status'] = status;
      }

      final queryString = queryParams.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');

      final response = await _apiClient.get(
        '/friends?$queryString',
        requireAuth: true,
      );
      return FriendsListResponse.fromJson(response);
    } on ApiException {
      rethrow;
    }
  }

  Future<List<FriendRequestModel>> getFriendRequests({
    String type = 'received', // 'sent' or 'received'
  }) async {
    try {
      final response = await _apiClient.get(
        '/friends/requests?type=$type',
        requireAuth: true,
      );
      return (response['requests'] as List<dynamic>)
          .map((item) => FriendRequestModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getFriendshipStatus(String userId) async {
    try {
      final response = await _apiClient.get(
        '/friends/status/$userId',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> removeFriend(String friendshipId) async {
    try {
      final response = await _apiClient.delete(
        '/friends/$friendshipId',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    }
  }
}

