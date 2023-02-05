import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './UI/login_&_register/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

late SharedPreferences sharedPreferences;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          backgroundColor: Color(0xffFFD261),
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
