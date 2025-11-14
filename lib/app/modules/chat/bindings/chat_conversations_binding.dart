import 'package:get/get.dart';

import '../controllers/chat_conversations_controller.dart';

class ChatConversationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatConversationsController>(ChatConversationsController.new);
  }
}

