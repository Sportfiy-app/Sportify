import 'package:get/get.dart';

import '../api/api_client.dart';
import '../home/models/home_feed_response.dart';

class HomeRepository extends GetxService {
  HomeRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<HomeFeedResponse> fetchHome() async {
    final json = await _apiClient.get('/home');
    return HomeFeedResponse.fromJson(json);
  }
}
