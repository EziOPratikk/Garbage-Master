import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/splash_screen.dart';
import './widgets/login_page.dart';
import './widgets/register_page.dart';
import './widgets/forgot_password.dart';
import './widgets/terms_&_condtions.dart';

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
        primaryColor: Color(0xff5C964A),
        accentColor: Color(0xffFFD261),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.green.withOpacity(0.8),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
