import 'package:get/get.dart';

import '../../../data/messages/messages_repository.dart';
import '../../../data/users/users_repository.dart';
import '../controllers/chat_conversations_controller.dart';

class ChatConversationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatConversationsController>(
      () => ChatConversationsController(
        Get.find<MessagesRepository>(),
        Get.find<UsersRepository>(),
      ),
    );
  }
}

