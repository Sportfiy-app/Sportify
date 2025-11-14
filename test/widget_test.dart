// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sportify/main.dart';
import 'package:sportify/app/modules/splash/views/splash_view.dart';

void main() {
  testWidgets('Splash screen renders Sportify branding', (
    WidgetTester tester,
  ) async {
    // Suppress overflow errors in tests by setting a larger viewport
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    
    await tester.pumpWidget(const SportifyApp());
    
    // Wait for the splash screen to render (but before it redirects after 2.4s)
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify splash screen is present
    expect(find.byType(SplashView), findsOneWidget);
    
    // Verify splash screen elements are present
    expect(find.text('Sportify'), findsOneWidget);
    expect(find.text('Chargement...'), findsOneWidget);
  });
}
