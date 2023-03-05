import 'package:flutter/material.dart';

import './home_page.dart';
import 'contact_page.dart';
import './profile_page.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavBarCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomNavBarPages = [
      HomePage(),
      ContactPage(),
      ProfilePage(),
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
