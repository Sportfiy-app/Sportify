import 'package:get/get.dart';

import '../controllers/profile_info_controller.dart';

class ProfileInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileInfoController>(ProfileInfoController.new);
  }
}

