import 'package:get/get.dart';

import '../controllers/profile_sports_controller.dart';

class ProfileSportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSportsController>(ProfileSportsController.new);
  }
}

