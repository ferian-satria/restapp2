import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: 'Channel Desc',
          importance: Importance.max,
          priority: Priority.max,
          color: Colors.blue,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin
        .show(id, title, body, await notificationDetails(), payload: payLoad);
  }

  Future dailyNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.getLocation('Asia/Indonesia'))
          .add(const Duration(seconds: 2)),
      const NotificationDetails(
        // Android details
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: "ashwin",
            importance: Importance.max,
            priority: Priority.max),
        // iOS details
        // iOS: IOSNotificationDetails(
        //   sound: 'default.wav',
        //   presentAlert: true,
        //   presentBadge: true,
        //   presentSound: true,
        // ),
      ),
      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:
          true, //To show notification even when the app is closed
    );
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    // tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    final now = tz.TZDateTime.now(tz.local);
    // final now = DateTime.now();
    final scheduleTime = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        scheduledNotificationDateTime.hour,
        scheduledNotificationDateTime.minute,
        scheduledNotificationDateTime.second);

    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 20)),
        scheduleTime.isBefore(now)
            ? scheduleTime.add(const Duration(days: 1))
            : scheduleTime,
        await notificationDetails(),
        // androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payLoad);
  }
}
