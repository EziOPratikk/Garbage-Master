import 'package:flutter/material.dart';

import './home_page.dart';
import 'contact_page.dart';
import './profile_page.dart';

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
