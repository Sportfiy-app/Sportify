import 'package:get/get.dart';

import '../controllers/report_confirmation_controller.dart';

class ReportConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportConfirmationController>(ReportConfirmationController.new);
  }
}

