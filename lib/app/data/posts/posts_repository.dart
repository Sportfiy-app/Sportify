import 'package:get/get.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/post_model.dart';

class PostsRepository extends GetxService {
  PostsRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<PostModel> createPost(Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.post(
        '/posts',
        body: data,
        requireAuth: true,
      );
      return PostModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la création du post');
    }
  }

  Future<PostsListResponse> getPosts({
    String? sport,
    String? type,
    String? authorId,
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
      if (type != null && type.isNotEmpty) queryParams['type'] = type;
      if (authorId != null && authorId.isNotEmpty) queryParams['authorId'] = authorId;
      if (latitude != null) queryParams['latitude'] = latitude.toString();
      if (longitude != null) queryParams['longitude'] = longitude.toString();
      if (radius != null) queryParams['radius'] = radius.toString();

      final queryString = queryParams.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');

      final response = await _apiClient.get(
        '/posts?$queryString',
        requireAuth: false, // Posts can be public
      );
      return PostsListResponse.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la récupération des posts');
    }
  }

  Future<PostModel> getPostById(String postId) async {
    try {
      final response = await _apiClient.get(
        '/posts/$postId',
        requireAuth: false, // Posts can be public
      );
      return PostModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la récupération du post');
    }
  }

  Future<PostModel> updatePost(String postId, Map<String, dynamic> data) async {
    try {
      final response = await _apiClient.patch(
        '/posts/$postId',
        body: data,
        requireAuth: true,
      );
      return PostModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la mise à jour du post');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _apiClient.delete(
        '/posts/$postId',
        requireAuth: true,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de la suppression du post');
    }
  }

  Future<Map<String, dynamic>> likePost(String postId) async {
    try {
      final response = await _apiClient.post(
        '/posts/$postId/like',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors du like du post');
    }
  }

  Future<Map<String, dynamic>> unlikePost(String postId) async {
    try {
      final response = await _apiClient.delete(
        '/posts/$postId/like',
        requireAuth: true,
      );
      return response;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(0, 'Erreur lors de l\'unlike du post');
    }
  }
}

