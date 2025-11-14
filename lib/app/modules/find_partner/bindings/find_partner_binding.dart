import 'package:get/get.dart';

import '../../../data/friends/friends_repository.dart';
import '../../../data/messages/messages_repository.dart';
import '../../../data/users/users_repository.dart';
import '../controllers/find_partner_controller.dart';

class FindPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindPartnerController>(
      () => FindPartnerController(
        Get.find<FriendsRepository>(),
        Get.find<MessagesRepository>(),
        Get.find<UsersRepository>(),
      ),
    );
  }
}
