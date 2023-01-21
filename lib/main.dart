import 'package:flutter/material.dart';
import 'package:garbage_master/UI/splash.dart';

import 'UI/login.dart';
import 'UI/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbage Master',
      theme: ThemeData(primarySwatch:  Colors.green),
      home: SplashScreen(),
    );
  }
}
//this is a branch test