import 'package:get/get.dart';

import '../../data/api/api_client.dart';
import '../../data/auth/auth_repository.dart';
import '../../data/auth/auth_session.dart';
import '../../data/auth/verification_repository.dart';
import '../../data/home/home_repository.dart';
import '../../data/events/events_repository.dart';
import '../../data/posts/posts_repository.dart';
import '../../data/users/users_repository.dart';
import '../../data/users/user_sports_repository.dart';
import '../../data/subscriptions/subscriptions_repository.dart';
import '../../widgets/bottom_navigation/bottom_nav_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiClient>(ApiClient(), permanent: true);
    Get.put<AuthSession>(AuthSession(), permanent: true);
    Get.put<AuthRepository>(AuthRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<VerificationRepository>(VerificationRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<HomeRepository>(HomeRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<EventsRepository>(EventsRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<PostsRepository>(PostsRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<UsersRepository>(UsersRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<UserSportsRepository>(UserSportsRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<SubscriptionsRepository>(SubscriptionsRepository(Get.find<ApiClient>()), permanent: true);
    Get.put<BottomNavController>(BottomNavController(), permanent: true);
  }
}
