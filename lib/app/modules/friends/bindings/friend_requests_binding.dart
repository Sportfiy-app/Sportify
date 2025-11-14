import 'package:get/get.dart';

import '../../../data/friends/friends_repository.dart';
import '../controllers/friend_requests_controller.dart';

class FriendRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendRequestsController>(
      () => FriendRequestsController(
        Get.find<FriendsRepository>(),
      ),
    );
  }
}

