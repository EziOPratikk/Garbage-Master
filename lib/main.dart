import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbage_master/services/localNotify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './UI/login_&_register/widgets/splash_screen.dart';

late SharedPreferences sharedPreferences;

Future main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  //print(fcmToken);
  LocalNotificationService.initialize();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbage Master',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xff5C964A),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.green,
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Color(0xff5C964A),
            fontSize: 22,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: const Color(0xffFFD261)),
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print("This is from background handler");
  // print(message.data.toString());
  // print(message.notification!.title);
}


//keytool -list -v \-alias androiddebugkey -keystore C:\Users\kumal\.android\debug.keystore