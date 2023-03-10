import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    notificationsPlugin.initialize(initializationSettings);
  }

  static void showNotificationOnForegrouind(RemoteMessage message) {
    notificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        const NotificationDetails(
            android: AndroidNotificationDetails(
          "pushNotifications",
          "pushNotificationChannel",
          importance: Importance.max,
          priority: Priority.high,
        )));
  }
}
