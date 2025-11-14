import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'login_email_view.dart';

class LoginPhoneView extends GetView<LoginController> {
  const LoginPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginEmailView();
  }
}
