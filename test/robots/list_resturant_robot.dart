import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ListRestaurant {
  final WidgetTester widgetTester;
  ListRestaurant(this.widgetTester);
  //scroll list restaurant
  Future<void> scrolllistRestaurant({bool scrollUp = false}) async {
    final scrollListRestaurant = find.byKey(const Key('listRestaurant'));
    if (scrollUp) {
      await widgetTester.fling(
          scrollListRestaurant, const Offset(0, 500), 10000);
      await widgetTester.pumpAndSettle();
    } else {
      await widgetTester.fling(
          scrollListRestaurant, const Offset(0, -500), 10000);
      await widgetTester.pumpAndSettle();
    }
  }

  //select restaurant
  Future<void> clickRestaurantItem() async {
    final restaurantItem = find.byKey(const Key('restaurantItem_5'));

    await widgetTester.ensureVisible(restaurantItem);
    await widgetTester.tap(restaurantItem);

    await widgetTester.pumpAndSettle();
  }

  //click fav icon
  Future<void> clickFavIcon() async {
    final favIcon = find.byKey(const Key('favIcon'));

    await widgetTester.ensureVisible(favIcon);
    await widgetTester.tap(favIcon);

    await widgetTester.pumpAndSettle();
  }

  //click setting icon
  Future<void> clickSettingIcon() async {
    final settingIcon = find.byKey(const Key('settingIcon'));

    await widgetTester.ensureVisible(settingIcon);
    await widgetTester.tap(settingIcon);

    await widgetTester.pumpAndSettle();
  }
}
