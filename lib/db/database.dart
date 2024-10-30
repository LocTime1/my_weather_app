import 'dart:io';

import 'package:my_weather_app/models/last_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  String table = 'Data';
  String columnId = 'id';
  String columnLat = 'lat';
  String columnLong = 'long';
  String columnCity = 'city';
  String columnCountry = 'country';
  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "LastData.db";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnLat REAL, $columnLong REAL, $columnCity STRING, $columnCountry STRING)');
  }

  Future<LastData?> getLastData() async {
    Database db = await database;
    final List<Map<String, dynamic>> dataMapList = await db.query(table);
    final List<LastData> dataList = [];
    dataMapList.forEach((dataMap) {
      dataList.add(LastData.fromMap(dataMap));
    });
    if (dataList.length != 0) {
      return dataList[dataList.length - 1];
    } else {
      return null;
    }
  }

  Future<LastData> insertData(LastData lastData) async {
    Database db = await database;
    lastData.id = await db.insert(table, lastData.toMap());
    return lastData;
  }

  void deleteAll() async {
    final db = await database;
    db.delete(table);
  }
}
