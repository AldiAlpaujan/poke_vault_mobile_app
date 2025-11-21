import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final notificationPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> onNotificationTap(dynamic data) async {}

  static Future<void> handleInteractionOnBackground(
    RemoteMessage event,
  ) async {}

  static Future<void> initNotification() async {
    const initSettingAndroid = AndroidInitializationSettings(
      'mipmap/ic_launcher',
    );

    const initSettingIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSetting = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingIOS,
    );

    await notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()!
        .requestNotificationsPermission();

    await notificationPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          final data = jsonDecode(details.payload!);
          onNotificationTap(data);
        }
      },
    );
  }

  static Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        // TODO : change this name
        'APPLICATION_NAME',
        'APPLICATION_NAME',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static dynamic showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }
}
