import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbage_master/services/db_helper.dart';
import 'package:garbage_master/services/local_notify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './UI/login_&_register/widgets/splash_screen.dart';
import 'models/notifications.dart';

late SharedPreferences sharedPreferences;

Future main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  //print(fcmToken);
  LocalNotificationService.initialize();
  // FirebaseMessaging.instance.subscribeToTopic('ward1');
  sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FireBaseHelper.instance.firebaseHelp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbage Master',
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: Colors.green,
        primaryColor: const Color(0xff5C964A),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.green,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xff5C964A),
            fontFamily: 'Rubik',
            fontSize: 22,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: const Color(0xffFFD261)),
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  // print("This is from background handler");

  LocalNotificationService.showNotificationOnForegrouind(message);
  final notification = NotificationModel(
    title: message.data['title'] ?? '',
    body: message.data['body'] ?? '',
    date: DateTime.now(),
    messageId: message.data['messageId'] ?? '',
  );
  DatabaseHelper().insertNotification(notification);

  // print(message.data.toString());
  // print(message.notification!.title);
}

class FireBaseHelper {
  static final FireBaseHelper _instance = FireBaseHelper._();
  static FireBaseHelper get instance => _instance;
  FireBaseHelper._();
  Future<void> firebaseHelp() async {
    FirebaseMessaging.instance.getInitialMessage();
    //foreground state
    FirebaseMessaging.onMessage.listen((event) async {
      String? messageId = event.messageId;

      bool exists = await DatabaseHelper().notificationExists(messageId!);
      if (!exists) {
        final notification = NotificationModel(
          title: event.data['title'] ?? '',
          body: event.data['body'] ?? '',
          date: DateTime.now(),
          messageId: messageId,
        );
        LocalNotificationService.showNotificationOnForegrouind(event);
        DatabaseHelper().insertNotification(notification);
      }
    });
    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      String messageId = event.data['message_id'];
      bool exists = await DatabaseHelper().notificationExists(messageId);
      if (!exists) {
        final notification = NotificationModel(
          title: event.data['title'] ?? '',
          body: event.data['body'] ?? '',
          date: DateTime.now(),
          messageId: messageId,
        );
        DatabaseHelper().insertNotification(notification);
      }
    });
  }
}

//keytool -list -v \-alias androiddebugkey -keystore C:\Users\kumal\.android\debug.keystore

