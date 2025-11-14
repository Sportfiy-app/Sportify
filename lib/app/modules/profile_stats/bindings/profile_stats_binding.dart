import 'package:get/get.dart';

import '../controllers/profile_stats_controller.dart';

class ProfileStatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileStatsController>(ProfileStatsController.new);
  }
}
