import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Setting {
  final WidgetTester widgetTester;
  Setting(this.widgetTester);

  Future<void> clickToggle() async {
    final setNotification = find.byKey(const Key('setNotification'));

    await widgetTester.ensureVisible(setNotification);
    await widgetTester.tap(setNotification);

    await widgetTester.pumpAndSettle();
  }

  Future<void> setTime() async {
    // final setTime = find.byKey(const Key('time-picker-dial'));
    final setTime = find.byType(TimePickerDialog);

    var center = widgetTester.getCenter(setTime);
    // print('setTime1');
    await widgetTester.ensureVisible(setTime);
    print('setTime2');
    await widgetTester.tapAt(Offset(center.dx - 9, center.dy));
    // await widgetTester.tap(setTime);
    print('setTime3');
    await widgetTester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await widgetTester.pageBack();
    await widgetTester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
