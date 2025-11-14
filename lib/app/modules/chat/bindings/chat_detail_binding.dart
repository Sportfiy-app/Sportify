import 'package:get/get.dart';

import '../../../data/messages/messages_repository.dart';
import '../../../data/users/users_repository.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailController>(
      () => ChatDetailController(
        Get.find<MessagesRepository>(),
        Get.find<UsersRepository>(),
      ),
    );
  }
}

