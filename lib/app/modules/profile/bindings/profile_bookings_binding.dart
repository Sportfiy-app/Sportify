import 'package:get/get.dart';

import '../controllers/profile_bookings_controller.dart';

class ProfileBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileBookingsController>(ProfileBookingsController.new);
  }
}

