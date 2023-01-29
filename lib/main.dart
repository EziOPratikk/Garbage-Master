import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './UI/login_&_register/widgets/splash_screen.dart';

late SharedPreferences sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
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
          backgroundColor: Color(0xff5C964A).withOpacity(0.8),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: Color(0xff5C964A)),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
