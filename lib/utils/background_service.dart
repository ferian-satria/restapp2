import 'dart:isolate';
import 'dart:ui';

import 'package:restapp2/main.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/utils/notification_helper.dart';
import 'package:http/http.dart' as http;

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print("alarmmm fireeee !!!!!");
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await getListRestaurants(http.Client());

    print("ada data resultnya gak $result");
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
