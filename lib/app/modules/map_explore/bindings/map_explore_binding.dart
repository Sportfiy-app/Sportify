import 'package:get/get.dart';

import '../controllers/map_explore_controller.dart';

class MapExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapExploreController>(MapExploreController.new);
  }
}

