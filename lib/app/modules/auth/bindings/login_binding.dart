import 'package:get/get.dart';

import '../../../data/auth/auth_repository.dart';
import '../../../data/auth/auth_session.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<AuthRepository>(), Get.find<AuthSession>()),
    );
  }
}
