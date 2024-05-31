import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ListFavorite {
  final WidgetTester widgetTester;
  ListFavorite(this.widgetTester);

  Future<void> removeFav() async {
    final restaurantItem = find.byKey(const Key('removeRestaurant_0'));

    await widgetTester.ensureVisible(restaurantItem);
    await widgetTester.tap(restaurantItem);

    await widgetTester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await widgetTester.pageBack();
    await widgetTester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
