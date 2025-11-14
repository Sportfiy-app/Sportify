import 'package:get/get.dart';

import '../controllers/profile_saved_announcements_controller.dart';

class ProfileSavedAnnouncementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSavedAnnouncementsController>(ProfileSavedAnnouncementsController.new);
  }
}

