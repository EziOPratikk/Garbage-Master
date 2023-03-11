import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        final notification = NotificationModel(
          title: event.data['title'] ?? '',
          body: event.data['body'] ?? '',
          date: DateTime.now(),
        );
        DatabaseHelper().insertNotification(notification);
        LocalNotificationService.showNotificationOnForegrouind(event);
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
      LocalNotificationService.showNotificationOnForegrouind(event);
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
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
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
    );
  }
}
