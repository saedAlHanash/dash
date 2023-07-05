import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../util/shared_preferences.dart';

const baseUrl = 'live.qareeb-maas.com';

var loggerObject = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    // number of method calls to be displayed
    errorMethodCount: 0,
    // number of method calls if stacktrace is provided
    lineLength: 300,
    // width of the output
    colors: true,
    // Colorful log messages
    printEmojis: false,
    // Print an emoji for each log message
    printTime: false,
  ),
);

class APIService {
  static APIService _singleton = APIService._internal();

  factory APIService() => _singleton;

  factory APIService.reInitial() {
    AppSharedPreference.reload();
    _singleton = APIService._internal();
    return _singleton;
  }

  final innerHeader = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${AppSharedPreference.getToken()}',
  };

  APIService._internal();

  Future<http.Response> getApi({
    required String url,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? path,
    String? hostName,
  }) async {
    if (query != null) query.removeWhere((key, value) => value == null);

    innerHeader.addAll(header ?? {});

    if (path != null) url = '$url/$path';

    if (query != null) {
      query.removeWhere((key, value) => value == null);
      query.forEach((key, value) => query[key] = value.toString());
    }

    logRequest('${hostName ?? ''}$url', query);

    final uri = Uri.https(hostName ?? baseUrl, url, query);

    final response = await http.get(uri, headers: innerHeader).timeout(
          const Duration(seconds: 40),
          onTimeout: () => http.Response('connectionTimeOut', 481),
        );

    logResponse(url, response);
    return response;
  }

  Future<http.Response> postApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? hostName,
  }) async {
    if (body != null) body.removeWhere((key, value) => value == null);

    if (query != null) {
      query.removeWhere((key, value) => value == null);
      query.forEach((key, value) => query[key] = value.toString());
    }

    innerHeader.addAll(header ?? {});

    final uri = Uri.https(hostName ?? baseUrl, url, query);

    logRequest(url, (body ?? {})..addAll(query ?? {}));

    final response =
        await http.post(uri, body: jsonEncode(body), headers: innerHeader).timeout(
              const Duration(seconds: 40),
              onTimeout: () => http.Response('connectionTimeOut', 481),
            );

    logResponse(url, response);

    return response;
  }

  Future<http.Response> puttApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
  }) async {
    if (body != null) body.removeWhere((key, value) => value == null);
    if (query != null) query.removeWhere((key, value) => value == null);

    innerHeader.addAll(header ?? {});

    if (query != null) {
      query.removeWhere((key, value) => value == null);
      query.forEach((key, value) => query[key] = value.toString());
    }

    final uri = Uri.https(baseUrl, url, query);

    logRequest(url, body);

    final response =
        await http.put(uri, body: jsonEncode(body), headers: innerHeader).timeout(
              const Duration(seconds: 40),
              onTimeout: () => http.Response('connectionTimeOut', 481),
            );

    logResponse(url, response);

    return response;
  }

  Future<http.Response> patchApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
  }) async {
    if (body != null) body.removeWhere((key, value) => value == null);
    if (query != null) query.removeWhere((key, value) => value == null);

    innerHeader.addAll(header ?? {});

    if (query != null) {
      query.removeWhere((key, value) => value == null);
      query.forEach((key, value) => query[key] = value.toString());
    }

    final uri = Uri.https(baseUrl, url, query);

    logRequest(url, body);

    final response =
        await http.patch(uri, body: jsonEncode(body), headers: innerHeader).timeout(
              const Duration(seconds: 40),
              onTimeout: () => http.Response('connectionTimeOut', 481),
            );

    logResponse(url, response);

    return response;
  }

  Future<http.Response> deleteApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
  }) async {
    if (body != null) body.removeWhere((key, value) => value == null);

    if (query != null) {
      query.removeWhere((key, value) => value == null);
      query.forEach((key, value) => query[key] = value.toString());
    }

    innerHeader.addAll(header ?? {});

    final uri = Uri.https(baseUrl, url, query);

    logRequest(url, body);

    final response =
        await http.delete(uri, body: jsonEncode(body), headers: innerHeader).timeout(
              const Duration(seconds: 40),
              onTimeout: () => http.Response('connectionTimeOut', 481),
            );

    logResponse(url, response);

    return response;
  }

  Future<http.Response> uploadMultiPart({
    required String url,
    String? path,
    String type = 'POST',
    String nameFile = 'File',
    List<XFile?>? files,
    Map<String, dynamic>? fields,
    Map<String, String>? header,
  }) async {
    Map<String, String> f = {};
    (fields ?? {}).forEach((key, value) => f[key] = value.toString());

    innerHeader.addAll(header ?? {});
    final uri = Uri.https(baseUrl, '$url/${path ?? ''}');

    var request = http.MultipartRequest(type, uri);

    ///log
    logRequest(url, fields, additional: files?.firstOrNull?.path);

    for (var file in (files ?? <XFile?>[])) {
      if (file == null) continue;

      final multipartFile =
          http.MultipartFile.fromBytes(nameFile, await file.readAsBytes());

      request.files.add(multipartFile);
    }

    request.headers.addAll(innerHeader);

    request.fields.addAll(f);

    final stream = await request.send();

    final response = await http.Response.fromStream(stream);

    ///log
    logResponse(url, response);

    return response;
  }

    Future<DateTime> getServerTime() async {
    var uri = Uri.https(baseUrl);

    final response = await http.get(uri, headers: innerHeader).timeout(
          const Duration(seconds: 40),
          onTimeout: () => http.Response('connectionTimeOut', 481),
        );

    return getDateTimeFromHeaders(response);
  }
}

void logRequest(String url, Map<String, dynamic>? q, {String? additional}) {
  if (url.contains('api.php')) return;
  loggerObject.i('$url \n ${jsonEncode(q)}${additional == null ? '' : '\n$additional'}');
}

void logResponse(String url, http.Response response) {
  if (url.contains('api.php')) return;
  var r = [];
  var res = '';
  if (response.body.length > 800) {
    r = response.body.splitByLength1(800);
    for (var e in r) {
      res += '$e\n';
    }
  } else {
    res = response.body;
  }

  loggerObject.v('${response.statusCode} \n $res');
}


DateTime getDateTimeFromHeaders(http.Response response) {
  final headers = response.headers;

  if (headers.containsKey('date')) {
    final dateString = headers['date']!;
    loggerObject.wtf(dateString);
    final dateTime = parseGMTDate(dateString);
    return dateTime.addFromNow();
  } else {
    loggerObject.wtf('now');
    return DateTime.now();
  }
}

DateTime parseGMTDate(String dateString) {
  final formatter = DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'');
  return formatter.parseUTC(dateString);
}

/*
android {
  testOptions {
    managedDevices {
      devices {
        pixel2api30 (com.android.build.api.dsl.ManagedVirtualDevice) {
          // Use device profiles you typically see in Android Studio.
          device = "Pixel 2"
          // Use only API levels 27 and higher.
          apiLevel = 30
          // To include Google services, use "google".
          systemImageSource = "aosp"
          // Whether the image must be a 64 bit image. Defaults to
          // false, in which case the managed device will use a
          // 32 bit image. Not applicable to arm64 machines.
          require64Bit = false
        }
      }
    }
  }
}

android {
  testOptions {
    managedDevices {
      devices {
        pixel2api30 (com.android.build.api.dsl.ManagedVirtualDevice) {
          // Use device profiles you typically see in Android Studio.
          device = "Pixel 2"
          // ATD currently support only API level 30.
          apiLevel = 30
          // You can also specify "google-atd" if you require Google
          // Play Services.
          systemImageSource = "aosp-atd"
          // Whether the image must be a 64 bit image.
          require64Bit = false
        }
      }
    }
  }
}

 */
