import 'package:get/get.dart';

import '../controllers/profile_delete_account_controller.dart';

class ProfileDeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileDeleteAccountController>(
      ProfileDeleteAccountController.new,
    );
  }
}

