import 'package:get/get.dart';

import '../controllers/profile_security_password_controller.dart';

class ProfileSecurityPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSecurityPasswordController>(ProfileSecurityPasswordController.new);
  }
}

