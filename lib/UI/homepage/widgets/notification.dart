import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:garbage_master/services/localNotify.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/notifications.dart';
import '../../../services/db_helper.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  SharedPreferences? prefs;
  List<Map<String, dynamic>> notificationList = [];
  String notificationMsg = "No Notification";
  @override
  void initState() {
    super.initState();

    DatabaseHelper().getNotifications().then((notifications) {
      setState(() {
        notificationList = notifications
            .map((notification) => {
                  "date": notification.date,
                  "title": notification.title,
                  "body": notification.body
                })
            .toList();
      });
    });

    //terminated state
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          final notification = NotificationModel(
            title: event.notification!.title ?? '',
            body: event.notification!.body ?? '',
            date: DateTime.now(),
          );
          DatabaseHelper().insertNotification(notification);
        });
      }
    });
    //foreground state
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForegrouind(event);
      if (mounted) {
        setState(() {
          final notification = NotificationModel(
            title: event.notification!.title ?? '',
            body: event.notification!.body ?? '',
            date: DateTime.now(),
          );

          DatabaseHelper().insertNotification(notification);
        });
      }
    });
    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        final notification = NotificationModel(
          title: event.notification!.title ?? '',
          body: event.notification!.body ?? '',
          date: DateTime.now(),
        );
        DatabaseHelper().insertNotification(notification);
      });
    });
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
                    notificationList.clear();
                    DatabaseHelper().clearNotifications();
                  });
                },
              )
            ],
            title: const Text('Notification'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: notificationList.isEmpty
              ? Center(
                  child: Text(notificationMsg),
                )
              : ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: ((context, index) {
                    final notification = notificationList[index];
                    final date = notification["date"];

                    return Card(
                        child: ExpansionTile(
                      title: Text(notification["title"]),
                      subtitle: Text(
                        DateFormat('dd-MMM-yyyy hh:mm a').format(date),
                      ),
                      children: [
                        Text(notification["body"]),
                      ],
                    ));
                  }))),
    );
  }
}
