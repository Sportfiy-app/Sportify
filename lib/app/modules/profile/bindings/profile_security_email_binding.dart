import 'package:get/get.dart';

import '../controllers/profile_security_email_controller.dart';

class ProfileSecurityEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSecurityEmailController>(ProfileSecurityEmailController.new);
  }
}

