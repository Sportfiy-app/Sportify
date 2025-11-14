import 'package:get/get.dart';

import '../controllers/profile_payment_controller.dart';

class ProfilePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePaymentController>(ProfilePaymentController.new);
  }
}

