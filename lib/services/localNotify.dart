import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    notificationsPlugin.initialize(initializationSettings);
  }

  static void showNotificationOnForegrouind(RemoteMessage message) async {
    const NotificationDetails notification = NotificationDetails(
        android: AndroidNotificationDetails(
      "pushNotifications",
      "pushNotificationChannel",
      importance: Importance.max,
      priority: Priority.high,
    ));
    await notificationsPlugin.show(DateTime.now().microsecond,
        message.data['title'], message.data['body'], notification);
  }
}
