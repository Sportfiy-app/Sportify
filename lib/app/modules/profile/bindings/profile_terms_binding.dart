import 'package:get/get.dart';

import '../controllers/profile_terms_controller.dart';

class ProfileTermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileTermsController>(ProfileTermsController.new);
  }
}

