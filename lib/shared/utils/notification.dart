import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Must be a top-level function: FCM runs it in a separate isolate when a
// message arrives while the app is in the background or terminated.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Notification messages are shown by the system in the background.
  // Handle data-only messages here if you need to.
}

class NotificationServices {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Notifications',
    importance: Importance.high,
  );

  static Future<void> initializenotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.requestPermission();

    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // iOS shows foreground notifications itself once this is set.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Android never shows FCM notifications while the app is open,
    // so display them with a local notification.
    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
  }

  static Future<String?> getToken() => FirebaseMessaging.instance.getToken();

  static void _showForegroundNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null ||
        defaultTargetPlatform != TargetPlatform.android) {
      return;
    }

    _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}
