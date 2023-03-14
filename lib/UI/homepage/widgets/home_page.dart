import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:garbage_master/map/screens/trucktracking.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/db_helper.dart';
import './data_input_page.dart';
import './waste_segregation.dart';
import './recent_data.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String username = '';
  List<Map<String, dynamic>> wardList = [];
  List<Map<String, dynamic>> notificationList = [];

  @override
  void initState() {
    super.initState();
    getuser();

    final dbHelper = DatabaseHelper();
    dbHelper.getWards().then((value) {
      setState(() {
        wardList = value
            .map((ward) => {"wardName": ward.wardName, "average": ward.average})
            .toList();
      });
    });
    DatabaseHelper().getNotifications().then((notifications) {
      setState(() {
        notificationList = notifications
            .map((notification) => {
                  "date": notification.date,
                  "title": notification.title,
                  "body": notification.body,
                  "messageId": notification.messageId
                })
            .toList();
      });
    });
  }

  String getuser() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        username = prefs.getString('username')!;
      });
    });
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(240, 236, 236, 1),
        body: Column(
          children: [
            _header(context),
            _body(context),
            _footer(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    int notificationCount = notificationList.length;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi $username !',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Today,  ${DateFormat('dd MMM yyy').format(DateTime.now())}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Badge(
            badgeContent: Text('$notificationCount'),
            child: IconButton(
              style: const ButtonStyle(),
              color: Colors.white,
              icon: const Icon(
                Icons.notifications_none_rounded,
                size: 45,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Notify(notificationList: notificationList),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _body(context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Home',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 25,
                children: [
                  HomepageItemWidget(
                    imgSrc: "assets/images/trash-bin.png",
                    title: "Input Garbage Data",
                    tapFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataInputPage(),
                        ),
                      );
                    },
                  ),
                  HomepageItemWidget(
                    imgSrc: "assets/images/recycle-bin.png",
                    title: "Segregation Guideline",
                    tapFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WasteSegregation(),
                        ),
                      );
                    },
                  ),
                  HomepageItemWidget(
                    imgSrc: "assets/images/table.png",
                    title: "History Table",
                    tapFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecentData(),
                        ),
                      );
                    },
                  ),
                  HomepageItemWidget(
                    imgSrc: "assets/images/view-map.png",
                    title: "View Map",
                    tapFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GarbageMap(wardList: wardList),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _footer(context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
    );
  }
}

class HomepageItemWidget extends StatelessWidget {
  final String title;
  final String imgSrc;
  final VoidCallback tapFunc;

  const HomepageItemWidget(
      {Key? key,
      required this.tapFunc,
      required this.imgSrc,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapFunc,
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(imgSrc),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
