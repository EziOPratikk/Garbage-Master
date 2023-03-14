import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/db_helper.dart';

class Notify extends StatefulWidget {
  final List<Map<String, dynamic>> notificationList;
  const Notify({super.key, required this.notificationList});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  SharedPreferences? prefs;

  String notificationMsg = "No Notification";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.notificationList.clear();
                    DatabaseHelper().clearNotifications();
                  });
                },
              )
            ],
            centerTitle: true,
            title: const Text('NOTIFICATION'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: widget.notificationList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/sleep.png',
                        height: 200,
                        width: 200,
                      ),
                      Text(notificationMsg),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: widget.notificationList.length,
                  itemBuilder: ((context, index) {
                    final notification = widget.notificationList[index];
                    final date = notification["date"];

                    return Card(
                        child: ExpansionTile(
                      title: Text(notification["title"]),
                      subtitle: Text(
                        DateFormat('dd-MMM-yyyy hh:mm a').format(date),
                      ),
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(notification["body"])),
                      ],
                    ));
                  }))),
    );
  }
}
