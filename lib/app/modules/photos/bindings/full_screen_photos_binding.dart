import 'package:get/get.dart';

import '../controllers/full_screen_photos_controller.dart';

class FullScreenPhotosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FullScreenPhotosController>(FullScreenPhotosController.new);
  }
}

