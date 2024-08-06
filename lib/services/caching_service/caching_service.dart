import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qareeb_models/extensions.dart';

import '../../core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';

const latestUpdateBox = 'latestUpdateBox';

class CachingService {
  static var timeInterval = 30;

  static Future<void> initial() async {
    await Hive.initFlutter();
  }

  static Future<void> updateLatestUpdateBox(String name) async {
    final boxUpdate = await getBox(latestUpdateBox);

    await boxUpdate.put(name, DateTime.now().toIso8601String());
  }

  static Future<void> sortData({
    required dynamic data,
    required String name,
    String filter = '',
  }) async {
    await updateLatestUpdateBox(name);

    final haveId = _getIdParam(data).isNotEmpty;

    final key = CacheKey(
      id: '',
      filter: filter,
      version: 0,
    );

    final box = await getBox(name);

    if (data is List) {
      await clearKeysId(box: box, filter: key);

      for (var e in data) {
        await box.put(
            key.copyWith(id: haveId ? _getIdParam(e) : '').jsonString, jsonEncode(e));
      }
      return;
    }

    await box.put(
        key.copyWith(id: haveId ? _getIdParam(data) : '').jsonString, jsonEncode(data));
  }

  static Future<Iterable<dynamic>?> addOrUpdate({
    required List<dynamic> data,
    required String name,
    required String filter,
  }) async {
    final key = CacheKey(
      id: getIdFromData(data),
      filter: filter,
      version: 0,
    );

    if (key.id.isEmpty) return null;

    final box = await getBox(name);

    for (var d in data) {
      final keys = box.keys.where((e) => jsonDecode(e)['id'] == d.id);

      final item = jsonEncode(d);

      final mapUpdate = Map.fromEntries(keys.map((key) => MapEntry(key, item)));

      //if not found the operation is add
      if (mapUpdate.isEmpty) mapUpdate[key.jsonString] = item;

      await box.putAll(mapUpdate);
    }

    return await getList(name, filter: filter);
  }

  static Future<Iterable<dynamic>?> delete({
    required List<String> data,
    required String name,
    required String filter,
  }) async {
    if (getIdFromData(data).isEmpty) return null;

    final box = await getBox(name);

    for (var id in data) {
      final keys = box.keys.where((e) {
        loggerObject.w(jsonDecode(e)['id']);
        return jsonDecode(e)['id'] == id;
      });

      await box.deleteAll(keys);
    }

    return await getList(name, filter: filter);
  }

  static Future<void> clearKeysId({
    required Box<String> box,
    required CacheKey filter,
  }) async {
    try {
      final keys = box.keys.where((e) {
        final keyCache = jsonDecode(e);
        return keyCache['filter'] == filter.filter;
      });

      await box.deleteAll(keys);
    } catch (e) {
      await (box).clear();
      loggerObject.e('clearKeysId ${box.name} $e');
    }
  }

  static Future<Iterable<dynamic>> getList(
    String name, {
    String filter = '',
  }) async {
    final key = CacheKey(
      id: '',
      filter: filter,
      version: 0,
    );

    final box = await getBox(name);

    final f = box.keys
        .where((e) => jsonDecode(e)['filter'] == key.filter)
        .map((e) => jsonDecode(box.get(e) ?? '{}'));

    return f;
  }

  static Future<dynamic> getData(
    String name, {
    String filter = '',
  }) async {
    final key = CacheKey(
      id: '',
      filter: filter,
      version: 0,
    );

    final box = await getBox(name);

    final keyBox =
        box.keys.firstWhereOrNull((e) => jsonDecode(e)['filter'] == key.filter);

    if (keyBox == null) return null;
    final dataByKey = box.get(keyBox);

    if (dataByKey == null) return null;

    return jsonDecode(dataByKey);
  }

  static Future<Box<String>> getBox(String name) async {
    return Hive.isBoxOpen(name)
        ? Hive.box<String>(name)
        : await Hive.openBox<String>(name);
  }

  static Future<NeedUpdateEnum> needGetData(
    String name, {
    String filter = '',
    int? timeInterval,
  }) async {
    try {
      final key = CacheKey(
        id: '',
        filter: filter,
        version: 0,
      );

      final box = await getBox(name);

      final keyFounded =
          box.keys.firstWhereOrNull((e) => jsonDecode(e)['filter'] == key.filter);

      if (keyFounded == null) {
        return NeedUpdateEnum.withLoading;
      }

      final latest = DateTime.tryParse((await getBox(latestUpdateBox)).get(name) ?? '');

      if (latest == null) {
        return NeedUpdateEnum.withLoading;
      }

      final d = DateTime.now().difference(latest).inSeconds.abs();

      if (d > (timeInterval ?? CachingService.timeInterval)) {
        return NeedUpdateEnum.noLoading;
      }

      return NeedUpdateEnum.no;
    } catch (e) {
      await (await getBox(name)).clear();
      loggerObject.e('needGetData $name $e');
      return NeedUpdateEnum.withLoading;
    }
  }

  static String getIdFromData(dynamic data) {
    return _getIdParam(data);
  }

  static String _getIdParam(dynamic data) {
    try {
      if (data is List) {
        if (data.first is String) return data.first;

        return (data.first.id.toString().isBlank) ? '' : data.first.id.toString();
      } else {
        return (!(data.id.toString().isBlank)) ? '' : data.id.toString();
      }
    } catch (e) {
      return '';
    }
  }
}

class CacheKey {
  CacheKey({
    required this.id,
    required this.filter,
    required this.version,
    this.date,
  }) {
    date = DateTime.now().millisecondsSinceEpoch;
    filter = filter.replaceAll('null', '');
  }

  final String id;
  String filter;
  final num version;
  int? date;

  factory CacheKey.fromJson(Map<String, dynamic> json) {
    return CacheKey(
      id: json["id"] ?? "",
      filter: json["filter"] ?? "",
      version: json["version"] ?? 0,
      date: json["date"] ?? 0,
    );
  }

  bool isMatchFilter(CacheKey key) {
    return filter == key.filter;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "filter": filter,
        "version": version,
        "date": date,
      };

  String get jsonString => jsonEncode(this);

  CacheKey copyWith({
    String? id,
    String? filter,
    num? version,
  }) {
    return CacheKey(
      id: id ?? this.id,
      filter: filter ?? this.filter,
      version: version ?? this.version,
      date: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
