import 'package:flutter/material.dart';
import 'package:garbage_master/UI/homepage/widgets/data_input_page.dart';
import 'package:intl/intl.dart';

import '../../../map/mapDart.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavBarCurrentIndex = 0;
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
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi User !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Today,  ${DateFormat('dd MMM yyy').format(DateTime.now())}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            style: ButtonStyle(),
            color: Colors.white,
            icon: Icon(
              Icons.notifications_none_rounded,
              size: 32,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  int itemCOunt() {
    return 1;
  }

  _body(context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              'Home',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                children: [
                  HomepageItemWidget(
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataInputPage(),
                        ),
                      );
                    },
                    imgSrc: "assets/images/input data.png",
                    title: "Input Garbage Data",
                  ),
                  HomepageItemWidget(
                    func: () {},
                    imgSrc: "assets/images/event.png",
                    title: "Events",
                  ),
                  HomepageItemWidget(
                    func: () {},
                    imgSrc: "assets/images/wastedata.png",
                    title: "Network Data",
                  ),
                  HomepageItemWidget(
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GarbageMap(),
                        ),
                      );
                    },
                    imgSrc: "assets/images/map.png",
                    title: "View Map",
                  ),
                ],
              ),
            ),
            //   Card(
            //     child: Container(
            //       width: MediaQuery.of(context).size.height * 0.15,
            //       child: Column(
            //         children: [
            //           Image.asset(
            //             'assets/images/waste.png',
            //             fit: BoxFit.cover,
            //           ),
            //           Text('Waste'),
            //         ],
            //       ),
            //     ),
            //   ),
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
      child: BottomNavigationBar(
        elevation: 10,
        fixedColor: Theme.of(context).primaryColor,
        items: [
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
    );
  }
}

class HomepageItemWidget extends StatelessWidget {
  final String title;
  final String imgSrc;
  final VoidCallback func;

  const HomepageItemWidget(
      {Key? key, required this.func, required this.imgSrc, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(child: Image.asset(imgSrc)),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
