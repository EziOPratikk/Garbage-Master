import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/WardModel.dart';
import '../../../models/api.services.dart';
import '../../../models/notifications.dart';
import '../../../models/users.dart';
import '../../../services/db_helper.dart';
import '../../../services/localNotify.dart';
import './home_page.dart';
import 'contact_page.dart';
import './profile_page.dart';

Future<Users> getProfileData() async {
  var puser = await SharedPreferences.getInstance();
  puser.getString('username');
  final currentUser = await APIServices.currentUser({
    'username': await SharedPreferences.getInstance()
        .then((value) => value.getString('username') ?? 'no username found'),
  });
  var decode = jsonDecode(currentUser.body);
  Map<String, dynamic> userMap = decode;
  Users profileUser = Users.fromMap(userMap);
  return profileUser;
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavBarCurrentIndex = 0;
  @override
  void initState() {
    setTopic();
    super.initState();
    storeWard();
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        final notification = NotificationModel(
          title: event.data['title'] ?? '',
          body: event.data['body'] ?? '',
          date: DateTime.now(),
        );
        DatabaseHelper().insertNotification(notification);
      }
    });
    //foreground state
    FirebaseMessaging.onMessage.listen((event) {
      final notification = NotificationModel(
        title: event.data['title'] ?? '',
        body: event.data['body'] ?? '',
        date: DateTime.now(),
      );

      DatabaseHelper().insertNotification(notification);
      LocalNotificationService.showNotificationOnForegrouind(event);
    });
    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final notification = NotificationModel(
        title: event.data['title'] ?? '',
        body: event.data['body'] ?? '',
        date: DateTime.now(),
      );
      DatabaseHelper().insertNotification(notification);
    });
  }

  Future<void> storeWard() async {
    final db_handler = DatabaseHelper();
    var response = await APIServices.getWards();
    response.forEach((key, value) {
      String wardName = key.replaceAll('Average', '');
      int wardAverage = value;
      WardModel ward = WardModel(wardName: wardName, average: wardAverage);
      db_handler.insertWard(ward);
    });
  }

  Future<void> setTopic() async {
    Users user = await getProfileData();
    String topic = 'ward${user.Ward}';
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    print('subscribed to $topic');
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarPages = [
      const HomePage(),
      ContactPage(),
      const ProfilePage(),
    ];
    return SafeArea(
      child: Scaffold(
        body: bottomNavBarPages[_bottomNavBarCurrentIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              fixedColor: Theme.of(context).primaryColor,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: 'Contact Us',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
              currentIndex: _bottomNavBarCurrentIndex,
              onTap: (int newIndex) {
                setState(() {
                  _bottomNavBarCurrentIndex = newIndex;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
