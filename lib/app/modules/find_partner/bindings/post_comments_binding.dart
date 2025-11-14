import 'package:get/get.dart';

import '../controllers/post_comments_controller.dart';

class PostCommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostCommentsController>(PostCommentsController.new);
  }
}
