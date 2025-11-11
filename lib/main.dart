import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const SportifyApp());
}

class SportifyApp extends StatelessWidget {
  const SportifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sportify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
