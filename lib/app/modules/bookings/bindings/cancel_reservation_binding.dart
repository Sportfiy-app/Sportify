import 'package:get/get.dart';

import '../controllers/cancel_reservation_controller.dart';

class CancelReservationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelReservationController>(CancelReservationController.new);
  }
}

