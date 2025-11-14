import 'package:get/get.dart';

import '../../../data/auth/auth_repository.dart';
import '../../../data/auth/auth_session.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        Get.find<AuthRepository>(),
        Get.find<AuthSession>(),
      ),
    );
  }
}
