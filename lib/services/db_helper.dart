import 'dart:developer';

import 'package:garbage_master/models/average.dart';
import 'package:garbage_master/models/notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/ward.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static late Database _database;

  DatabaseHelper.internal();
  factory DatabaseHelper() {
    _instance = DatabaseHelper.internal();
    return _instance!;
  }

  Future<Database> getdb() async {
    _database = await initdb();
    return _database;
  }

  Future<Database> initdb() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'notifications.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'Create table notifications(id INTEGER PRIMARY KEY AUTOINCREMENT, title text, body text, date text)');
      await db
          .execute('create table wards(id INTEGER PRIMARY KEY, wardName text');
    });
  }

//ward table
  Future<void> insertWard(WardAvg ward) async {
    final db = await getdb();
    await db.insert('wards', ward.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<WardAvg>> getWards() async {
    final db = await getdb();
    final List<Map<String, dynamic>> maps = await db.query('wards');
    return List.generate(maps.length, (i) {
      return WardAvg.fromMap(maps[i]);
    });
  }

  Future<void> insertNotification(NotificationModel notification) async {
    final db = await getdb();
    log(notification.date.toString());
    await db.insert('notifications', notification.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<NotificationModel>> getNotifications() async {
    final db = await getdb();
    final List<Map<String, dynamic>> maps = await db.query('notifications');
    return List.generate(maps.length, (i) {
      return NotificationModel.fromJson(maps[i]);
    });
  }

  Future<void> clearNotifications() async {
    final db = await getdb();
    await db.delete('notifications');
  }
}
