import 'package:flutter/material.dart';
import 'package:garbage_master/UI/homepage/widgets/main_screen.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    initializedLocationAndSave();
  }

  void initializedLocationAndSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    LocationData locationData = await location.getLocation();
    sharedPreferences.setDouble('latitude', locationData.latitude!);
    sharedPreferences.setDouble('longitude', locationData.longitude!);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        if (username != null) {
          return const MainScreen();
        } else {
          return LoginPage();
        }
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Logo.png', fit: BoxFit.cover),
            const SizedBox(height: 50),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    ));
  }
}
