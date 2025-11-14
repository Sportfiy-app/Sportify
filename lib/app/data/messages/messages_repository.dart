import 'package:get/get.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/message_model.dart';

class MessagesRepository extends GetxService {
  MessagesRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<MessageModel> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    try {
      final response = await _apiClient.post(
        '/messages',
        body: {
          'receiverId': receiverId,
          'content': content,
        },
        requireAuth: true,
      );
      return MessageModel.fromJson(response);
    } on ApiException {
      rethrow;
    }
  }

  Future<MessagesListResponse> getMessages({
    String? userId, // Filter by conversation with specific user
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };
      if (userId != null) {
        queryParams['userId'] = userId;
      }

      final queryString = queryParams.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');

      final response = await _apiClient.get(
        '/messages?$queryString',
        requireAuth: true,
      );
      return MessagesListResponse.fromJson(response);
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getConversations({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, String>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      final queryString = queryParams.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');

      final response = await _apiClient.get(
        '/messages/conversations?$queryString',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> markAsRead(List<String> messageIds) async {
    try {
      final response = await _apiClient.patch(
        '/messages/read',
        body: {
          'messageIds': messageIds,
        },
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUnreadCount() async {
    try {
      final response = await _apiClient.get(
        '/messages/unread/count',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteMessage(String messageId) async {
    try {
      final response = await _apiClient.delete(
        '/messages/$messageId',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    }
  }
}

