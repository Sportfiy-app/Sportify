import 'package:get/get.dart';

import '../controllers/find_partner_controller.dart';

class FindPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindPartnerController>(FindPartnerController.new);
  }
}
