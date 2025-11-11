import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class IntroController extends GetxController {
  void onGetStarted() {
    Get.toNamed(Routes.loginEmail);
  }

  void onLearnMore() {
    // Placeholder for future content navigation.
  }

  void onAlreadyMember() {
    Get.toNamed(Routes.loginEmail);
  }
}
