import 'package:get/get.dart';

import '../modules/auth/bindings/login_binding.dart';
import '../modules/auth/views/login_email_view.dart';
import '../modules/auth/views/login_phone_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.splash,
      page: SplashView.new,
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.intro, page: IntroView.new, binding: IntroBinding()),
    GetPage(
      name: Routes.loginEmail,
      page: LoginEmailView.new,
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.loginPhone,
      page: LoginPhoneView.new,
      binding: LoginBinding(),
    ),
    GetPage(name: Routes.home, page: HomeView.new, binding: HomeBinding()),
  ];
}
