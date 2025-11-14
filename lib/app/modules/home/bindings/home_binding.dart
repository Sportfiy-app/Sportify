import 'package:get/get.dart';

import '../../../data/home/home_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<HomeRepository>()),
    );
  }
}
