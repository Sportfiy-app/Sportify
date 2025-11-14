import 'package:get/get.dart';

import '../controllers/personal_stats_controller.dart';

class PersonalStatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalStatsController>(PersonalStatsController.new);
  }
}
