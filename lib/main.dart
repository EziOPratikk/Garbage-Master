import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garbage Master',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(),
    );
  }
}
//this is a branch test