import 'package:get/get.dart';

import '../controllers/profile_language_controller.dart';

class ProfileLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileLanguageController>(ProfileLanguageController.new);
  }
}

