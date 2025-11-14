import 'package:get/get.dart';
import '../../routes/app_routes.dart';

enum BottomNavTab {
  home,
  find,
  booking,
  messages,
  profile,
}

class BottomNavController extends GetxController {
  final Rx<BottomNavTab> currentTab = BottomNavTab.home.obs;

  void changeTab(BottomNavTab tab) {
    if (currentTab.value == tab) return;

    currentTab.value = tab;
    _navigateToTab(tab);
    // Update tab after navigation completes
    Future.delayed(const Duration(milliseconds: 100), _updateTabFromRoute);
  }

  void _navigateToTab(BottomNavTab tab) {
    final targetRoute = _getRouteForTab(tab);
    final currentRoute = Get.routing.current;
    
    // Only navigate if we're not already on the target route
    if (currentRoute == targetRoute) return;
    
    // Use smooth transition
    switch (tab) {
      case BottomNavTab.home:
        Get.offNamedUntil(
          Routes.home,
          (route) => route.settings.name == Routes.home,
          arguments: {'fromBottomNav': true},
        );
        break;
      case BottomNavTab.find:
        Get.offNamedUntil(
          Routes.findPartner,
          (route) => route.settings.name == Routes.findPartner,
          arguments: {'fromBottomNav': true},
        );
        break;
      case BottomNavTab.booking:
        Get.offNamedUntil(
          Routes.bookingHome,
          (route) => route.settings.name == Routes.bookingHome,
          arguments: {'fromBottomNav': true},
        );
        break;
      case BottomNavTab.messages:
        Get.offNamedUntil(
          Routes.chatConversations,
          (route) => route.settings.name == Routes.chatConversations,
          arguments: {'fromBottomNav': true},
        );
        break;
      case BottomNavTab.profile:
        Get.offNamedUntil(
          Routes.profile,
          (route) => route.settings.name == Routes.profile,
          arguments: {'fromBottomNav': true},
        );
        break;
    }
  }

  String _getRouteForTab(BottomNavTab tab) {
    switch (tab) {
      case BottomNavTab.home:
        return Routes.home;
      case BottomNavTab.find:
        return Routes.findPartner;
      case BottomNavTab.booking:
        return Routes.bookingHome;
      case BottomNavTab.messages:
        return Routes.chatConversations;
      case BottomNavTab.profile:
        return Routes.profile;
    }
  }

  BottomNavTab getTabFromRoute(String? routeName) {
    if (routeName == null) return BottomNavTab.home;
    
    if (routeName == Routes.home) return BottomNavTab.home;
    if (routeName == Routes.findPartner || routeName.startsWith('/find-partner')) return BottomNavTab.find;
    if (routeName == Routes.bookingHome || routeName.startsWith('/booking')) return BottomNavTab.booking;
    if (routeName == Routes.chatConversations || routeName.startsWith('/chat')) return BottomNavTab.messages;
    if (routeName.startsWith('/profile')) return BottomNavTab.profile;
    
    return BottomNavTab.home;
  }

  @override
  void onInit() {
    super.onInit();
    // Update current tab based on current route
    _updateTabFromRoute();
  }

  void _updateTabFromRoute() {
    final route = Get.routing.current;
    final newTab = getTabFromRoute(route);
    if (currentTab.value != newTab) {
      currentTab.value = newTab;
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Update tab when controller is ready
    _updateTabFromRoute();
  }
}

