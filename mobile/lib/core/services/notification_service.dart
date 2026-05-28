import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // request permission
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // get FCM token
    final token = await _messaging.getToken();
    if (kDebugMode) print('[FCM] token: $token');

    // handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print('[FCM] foreground: ${message.notification?.title}');
      }
      // TODO: show in-app snackbar
    });

    // handle background tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print('[FCM] opened from notification: ${message.data}');
      }
      // TODO: navigate to manga detail
    });
  }

  static Future<String?> getToken() => _messaging.getToken();
}
