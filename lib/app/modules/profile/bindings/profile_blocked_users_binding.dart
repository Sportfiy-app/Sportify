import 'package:get/get.dart';

import '../controllers/profile_blocked_users_controller.dart';

class ProfileBlockedUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileBlockedUsersController>(ProfileBlockedUsersController.new);
  }
}

