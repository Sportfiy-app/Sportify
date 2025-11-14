import 'package:get/get.dart';

import '../controllers/profile_actions_controller.dart';

class ProfileActionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileActionsController>(ProfileActionsController.new);
  }
}

