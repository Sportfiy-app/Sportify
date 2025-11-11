import 'package:get/get.dart';

enum HomeQuickActionType { book, meet, play }

class HomeController extends GetxController {
  static const versionLabel = 'Version 1.0.0';
  static const ctaLabel = 'Commencer';

  void onGetStarted() {
    // TODO: Implement navigation to onboarding or authentication.
  }

  void onQuickActionTap(HomeQuickActionType type) {
    // TODO: Implement quick action interactions.
  }
}
