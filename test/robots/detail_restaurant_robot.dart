import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class DetailRestaurant {
  final WidgetTester widgetTester;
  DetailRestaurant(this.widgetTester);
  Future<void> clickFavIcon() async {
    final favIcon = find.byKey(const Key('favIcon'));

    await widgetTester.ensureVisible(favIcon);
    await widgetTester.tap(favIcon);

    await widgetTester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await widgetTester.pageBack();
    await widgetTester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
