import 'dart:io';

import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "qareeb.db";


  static const table = 'location_table';
  static const tableTrip = 'trip';

  static const columnId = 'id';
  static const location = 'location';
  static const name = 'name';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    // Copy the database file from the assets folder if it doesn't already exist
    bool exists = await databaseExists(path);
    if (!exists) {
      // Make sure the parent directory exists
      await Directory(dirname(path)).create(recursive: true);

      // Copy the file from the assets folder
      ByteData data = await rootBundle.load(join('assets', _databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }

    _db = await openDatabase(
      path,

      // version: 1,
      // onCreate: (db, version) async {
      //   await db.execute(
      //     'CREATE TABLE $table($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $location TEXT, $name TEXT)',
      //   );
      // },
    );
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insert(LocationSqf model) async {
    return await _db.insert(table, model.toJson());
  }
  // Future<int> insertTrip(LocationSqf model) async {
  //   return await _db.insert(table, model.toJson());
  // }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<LocationSqf>> searchWord(String word) async {
    //  Future<List<Map<String, dynamic>>> queryAllRows() async {
    if (word.isEmpty) return [];
    var t = word.split(' ');

    var q = 'SELECT * FROM $table WHERE ';

    for (int i = 0; i < t.length; i++) {
      if (i == 0) {
        q += '$name LIKE \'%${t[i]}%\'';
      } else {
        q += ' AND $name LIKE \'%${t[i]}%\'';
      }
    }

    List<Map<String, dynamic>> map = await _db.rawQuery(q);
    final list = <LocationSqf>[];

    for (int i = 0; i < (map.length > 100 ? 100 : map.length); i++) {
      list.add(LocationSqf.fromJson(map[i]));
    }
    return list;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}

class LocationSqf {
  LocationSqf({
    required this.id,
    required this.location,
    required this.name,
  });

  final int id;
  final String location;
  final String name;

  LatLng get getLatLng {
    final s = location.split(',');
    try {
      var lat = double.parse(s[0]);
      var lng = double.parse(s[1]);
      return LatLng(lat, lng);
    } on Exception {
      return LatLng(0, 0);
    }
  }
//<editor-fold desc="Data Methods">

  LocationSqf copyWith({
    int? id,
    String? location,
    String? name,
  }) {
    return LocationSqf(
      id: id ?? this.id,
      location: location ?? this.location,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'name': name,
    };
  }

  factory LocationSqf.fromJson(Map<String, dynamic> map) {
    return LocationSqf(
      id: map['id'] ?? 0,
      location: map['location'] ?? '',
      name: map['name'] ?? '',
    );
  }

//</editor-fold>
}
