import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './data_input_page.dart';
import './waste_segregation.dart';
import './recent_data.dart';
import '../../../map/screens/WardMap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                const Text(
                  'Hi User !',
                  style: TextStyle(
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
          IconButton(
            style: const ButtonStyle(),
            color: Colors.white,
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 32,
            ),
            onPressed: () {},
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
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                children: [
                  HomepageItemWidget(
                    imgSrc: "assets/images/input data.png",
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
                    imgSrc: "assets/images/waste.png",
                    title: "Waste Segregation Guideline",
                    tapFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WasteSegregation(),
                        ),
                      );
                    },
                  ),
                  HomepageItemWidget(
                    imgSrc: "assets/images/wastedata.png",
                    title: "Recent Data",
                    tapFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecentData(),
                        ),
                      );
                    },
                  ),
                  HomepageItemWidget(
                    imgSrc: "assets/images/map.png",
                    title: "View Map",
                    tapFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GarbageMap(),
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
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(imgSrc),
              ),
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
