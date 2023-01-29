import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './UI/login_&_register/widgets/splash_screen.dart';
import './UI/login_&_register/widgets/login_page.dart';
import './UI/login_&_register/widgets/register_page.dart';
import './UI/login_&_register/widgets/forgot_password.dart';
import './UI/login_&_register/widgets/terms_&_condtions.dart';
import './UI/homepage/widgets/home_page.dart';
import './UI/homepage/widgets/data_input_page.dart';
import './UI/homepage/widgets/profile_page.dart';
import 'UI/homepage/widgets/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbage Master',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xff5C964A),
        accentColor: const Color(0xffFFD261),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xffFFD261),
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Color(0xff5C964A),
            fontSize: 22,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
