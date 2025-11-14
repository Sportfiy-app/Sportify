import 'package:get/get.dart';

import '../controllers/profile_security_phone_controller.dart';

class ProfileSecurityPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSecurityPhoneController>(ProfileSecurityPhoneController.new);
  }
}

