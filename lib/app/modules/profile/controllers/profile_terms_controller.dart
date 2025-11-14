import 'package:get/get.dart';

class ProfileTermsController extends GetxController {
  ProfileTermsController() {
    tabs = const [
      TermsTab(id: 'terms', label: 'Conditions', isActive: true),
      TermsTab(id: 'privacy', label: 'Confidentialité'),
      TermsTab(id: 'data', label: 'Données'),
      TermsTab(id: 'cookies', label: 'Cookies'),
      TermsTab(id: 'rights', label: 'Vos droits'),
    ];
  }

  late final List<TermsTab> tabs;
  final RxString activeTabId = 'terms'.obs;

  void setActiveTab(String id) {
    activeTabId.value = id;
  }
}

class TermsTab {
  const TermsTab({required this.id, required this.label, this.isActive = false});

  final String id;
  final String label;
  final bool isActive;
}

