import 'package:get/get.dart';

import '../controllers/profile_annonces_controller.dart';

class ProfileAnnoncesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileAnnoncesController>(ProfileAnnoncesController.new);
  }
}

