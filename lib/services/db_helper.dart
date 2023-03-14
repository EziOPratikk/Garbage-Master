import 'dart:developer';
import 'package:garbage_master/models/notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/WardModel.dart';

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

      await db.execute(
          'CREATE TABLE IF NOT EXISTS wards(id INTEGER PRIMARY KEY AUTOINCREMENT , wardName TEXT, average INTEGER)');
    });
  }

  Future<void> insertWard(WardModel ward) async {
    final db = await getdb();
    // log(ward.wardName);
    // log(ward.average.toString());
    await db.insert('wards', ward.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<WardModel>> getWards() async {
    final db = await getdb();
    final List<Map<String, dynamic>> maps = await db.query('wards');
    return List.generate(maps.length, (i) {
      return WardModel.fromMap(maps[i]);
    });
  }

  Future<WardModel?> getWardByName(String wardName) async {
    final db = await getdb();
    final List<Map<String, dynamic>> results = await db.query('wards',
        where: 'TRIM(wardName) = ?', whereArgs: [wardName.trim()]);
    print('Query results for $wardName: $results');
    if (results.isEmpty) {
      return null;
    } else {
      return WardModel.fromMap(results.first);
    }
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

  Future<void> clearWard() async {
    final db = await getdb();
    await db.delete('wards');
  }
}
