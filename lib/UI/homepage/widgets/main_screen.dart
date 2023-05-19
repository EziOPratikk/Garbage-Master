import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/WardModel.dart';
import '../../../models/api.services.dart';
import '../../../services/db_helper.dart';
import './home_page.dart';
import 'contact_page.dart';
import './profile_page.dart';
import 'driver_homepage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String username = '';
  int _bottomNavBarCurrentIndex = 0;
  final driverUser = 'anilkumal1';

  late List<Widget> bottomNavBarPages = [];

  @override
  void initState() {
    super.initState();
    storeWard();
    getuser();
  }

  Future getuser() async {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        username = prefs.getString('username')!;
        if (username == driverUser) {
          bottomNavBarPages = [
            const DhomePage(),
            ContactPage(),
            const ProfilePage(),
          ];
        } else {
          bottomNavBarPages = [
            const HomePage(),
            ContactPage(),
            const ProfilePage()
          ];
        }
      });
    });
  }

  Future<void> storeWard() async {
    final dbhandler = DatabaseHelper();
    var response = await APIServices.getWards();
    response.forEach((key, value) {
      String wardName = key.replaceAll('Average', '');
      int wardAverage = value;
      WardModel ward = WardModel(wardName: wardName, average: wardAverage);
      dbhandler.insertWard(ward);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: bottomNavBarPages.isEmpty
          ? Scaffold()
          : Scaffold(
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
