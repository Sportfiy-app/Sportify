import 'package:get/get.dart';

import '../controllers/profile_help_controller.dart';

class ProfileHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileHelpController>(ProfileHelpController.new);
  }
}

