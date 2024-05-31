import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Splash {
  final WidgetTester widgetTester;
  Splash(this.widgetTester);
  Future<void> splash() async {
    final splash = find.byKey(const Key('SplashImage'));
    await widgetTester.ensureVisible(splash);

    print('future splash');
    await widgetTester.pumpAndSettle();
  }
}
