import 'package:get/get.dart';

import '../controllers/profile_security_phone_verify_controller.dart';

class ProfileSecurityPhoneVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSecurityPhoneVerifyController>(ProfileSecurityPhoneVerifyController.new);
  }
}

