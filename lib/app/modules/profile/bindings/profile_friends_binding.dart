import 'package:get/get.dart';

import '../controllers/profile_friends_controller.dart';

class ProfileFriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileFriendsController>(ProfileFriendsController.new);
  }
}

