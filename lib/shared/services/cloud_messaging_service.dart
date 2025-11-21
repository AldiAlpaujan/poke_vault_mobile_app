import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project_template/shared/services/notification_service.dart';

class CloudMessagingService {
  // generate token
  static Future<String?> generateToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) print(fcmToken.toString());
      return fcmToken;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  // generate refresh token
  static void generateRefreshToken() {
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {})
        .onError((err) {});
  }

  // Initialize Notification
  static Future<void> initializeMessaging() async {
    await generateToken();
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        NotificationService.showNotification(
          title: notification.title,
          body: notification.body,
          payload: jsonEncode(message.data),
        );
      }
    });
  }
}
