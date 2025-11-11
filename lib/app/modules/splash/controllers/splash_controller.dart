import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  Timer? _timer;

  @override
  void onReady() {
    super.onReady();
    _startRedirectTimer();
  }

  void _startRedirectTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (Get.currentRoute == Routes.splash) {
        Get.offNamed(Routes.intro);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
