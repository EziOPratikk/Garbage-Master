import 'package:flutter/material.dart';

import './widgets/splash.dart';
import './widgets/login.dart';
import './widgets/register.dart';
import './widgets/terms_&_condtions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbage Master',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(),
    );
  }
}
