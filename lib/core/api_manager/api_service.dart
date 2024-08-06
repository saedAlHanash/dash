import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:qareeb_models/extensions.dart';

import '../strings/enum_manager.dart';
import '../util/shared_preferences.dart';
import 'api_url.dart';
import 'helpers_api/helper_api_service.dart';
import 'helpers_api/log_api.dart';

// const baseUrl = 'live.qareeb-maas.com';
// const baseUrl = '192.168.1.44:44311';

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

DateTime? _serverDate;

DateTime get getServerDate => _serverDate ?? DateTime.now();

class APIService {

  static APIService _singleton = APIService._internal();

  factory APIService() => _singleton;

  Map<String, String> get innerHeader => {
    'Content-Type': 'application/json',
    // 'Accept': '*/*',
    'origin': 'x-requested-with',
    'X-Frame-Options': 'SAMEORIGIN',
    'x-cors-api-key': 'temp_ddc55961defc6c4343f28eec36c009da',
    'Authorization': 'Bearer ${AppSharedPreference.getToken()}',
    "Access-Control-Allow-Origin": "*",
    'Accept': '*/*'
  };

  APIService._internal();

  Future<http.Response> callApi({
    required String url,
    required ApiType type,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? path,
    String? hostName,
  }) async {
    // if (!await network.isConnected) noInternet;

    fixQuery(query);

    fixBody(body);

    final uri =
    getUri(url: url, query: query, path: path, body: body, type: type);

    try {
      late final http.Response response;

      switch (type) {
        case ApiType.get:
          response = await http
              .get(uri, headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.post:
          response = await http
              .post(uri,
              body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.put:
          response = await http
              .put(uri,
              body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.patch:
          response = await http
              .patch(uri,
              body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
        case ApiType.delete:
          response = await http
              .delete(uri,
              body: jsonEncode(body), headers: (header ?? innerHeader))
              .timeout(connectionTimeOut, onTimeout: () => timeOut);
      }

      logResponse(url: url, response: response, type: type);

      return response;
    } catch (e) {
      loggerObject.e('API service: $e');

      return noInternet;
    }
  }


  // Uri getUri({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  //   String? path,
  //   String? hostName,
  // }) {
  //   if (query != null) query.removeWhere((key, value) => value == null);
  //
  //   innerHeader.addAll(header ?? {});
  //
  //   if (path != null) url = '$url/$path';
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => value == null);
  //     query.forEach((key, value) => query[key] = value.toString());
  //   }
  //
  //   logRequest('${hostName ?? ''}$url', query);
  //
  //   final uri = Uri.https(hostName ?? baseUrl, url, query);
  //
  //   return uri;
  // }
  //


  // Future<http.Response> getApi({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  //   String? path,
  //   String? hostName,
  // }) async {
  //   innerHeader.addAll(header ?? {});
  //
  //   if (path != null) url = '$url/$path';
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //     query.forEach((key, value) => query[key] = value.toString());
  //   }
  //
  //   logRequest('${hostName ?? ''}$url', query);
  //
  //   final uri = Uri.https(hostName ?? baseUrl, url, query);
  //
  //   try {
  //     final response = await http.get(uri, headers: innerHeader).timeout(
  //           const Duration(seconds: 40),
  //           onTimeout: () => http.Response('connectionTimeOut', 481),
  //         );
  //
  //     logResponse(url, response);
  //     _serverDate = getDateTimeFromHeaders(response);
  //
  //     return response;
  //   } catch(e) {
  //     loggerObject.e(e);
  //     return http.Response('{}', 481);
  //   }
  // }
  //
  // Future<http.Response> getApiProxy({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  //   String? path,
  //   String? hostName,
  // }) async {
  //   innerHeader.addAll(header ?? {});
  //
  //   if (path != null) url = '$url/$path';
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //     query.forEach((key, value) => query[key] = value.toString());
  //   }
  //
  //   logRequest('${hostName ?? ''}$url', query);
  //
  //   final uri = Uri.https(hostName ?? baseUrl, url, query);
  //   final proxyUri = Uri.https('api.allorigins.win', 'raw', {'url': uri.toString()});
  //
  //   try {
  //     final response = await http.get(proxyUri, headers: innerHeader).timeout(
  //           const Duration(seconds: 40),
  //           onTimeout: () => http.Response('connectionTimeOut', 481),
  //         );
  //
  //     logResponse(url, response);
  //     _serverDate = getDateTimeFromHeaders(response);
  //     return response;
  //   } catch(e) {
  //     loggerObject.e(e);
  //     return http.Response('{}', 481);
  //   }
  // }
  //
  // Future<http.Response> getApiProxyPayed({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  //   String? path,
  // }) async {
  //   if (path != null) url = '$url/$path';
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //     query.forEach((key, value) => query[key] = value.toString());
  //   }
  //
  //   final uri = Uri.https('proxy.cors.sh', url, query);
  //
  //   try {
  //     final response =
  //         await http.get(uri, headers: innerHeader).timeout(const Duration(seconds: 40));
  //     _serverDate = getDateTimeFromHeaders(response);
  //     return response;
  //   } catch(e) {
  //     loggerObject.e(e);
  //     return http.Response('{}', 481);
  //   }
  // }
  //
  // Future<http.Response> postApi({
  //   required String url,
  //   Map<String, dynamic>? body,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  //   String? hostName,
  // }) async {
  //
  //   if (body != null) body.removeWhere((key, value) => value == null);
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //     query.forEach((key, value) {
  //       if (value is! List) query[key] = value.toString();
  //     });
  //   }
  //
  //   innerHeader.addAll(header ?? {});
  //
  //   final uri = Uri.https(hostName ?? baseUrl, url, query);
  //
  //   logRequest(url, (body ?? {})..addAll(query ?? {}));
  //
  //   try {
  //     final response =
  //         await http.post(uri, body: jsonEncode(body), headers: innerHeader).timeout(
  //               const Duration(seconds: 40),
  //               onTimeout: () => http.Response('connectionTimeOut', 481),
  //             );
  //
  //     logResponse(url, response);
  //     _serverDate = getDateTimeFromHeaders(response);
  //     return response;
  //   } catch(e) {
  //     loggerObject.e(e);
  //     return http.Response('{}', 481);
  //   }
  // }
  //
  // Future<http.Response> puttApi({
  //   required String url,
  //   Map<String, dynamic>? body,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  // }) async {
  //   body?.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //
  //   innerHeader.addAll(header ?? {});
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //     query.forEach((key, value) => query[key] = value.toString());
  //   }
  //
  //   final uri = Uri.https(baseUrl, url, query);
  //
  //   logRequest(url, body);
  //
  //   try {
  //     final response =
  //         await http.put(uri, body: jsonEncode(body), headers: innerHeader).timeout(
  //               const Duration(seconds: 40),
  //               onTimeout: () => http.Response('connectionTimeOut', 481),
  //             );
  //
  //     logResponse(url, response);
  //     _serverDate = getDateTimeFromHeaders(response);
  //     return response;
  //   } catch(e) {
  //     loggerObject.e(e);
  //     return http.Response('{}', 481);
  //   }
  // }
  //
  // Future<http.Response> patchApi({
  //   required String url,
  //   Map<String, dynamic>? body,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  // }) async {
  //   if (body != null) body.removeWhere((key, value) => value == null);
  //
  //   innerHeader.addAll(header ?? {});
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //     query.forEach((key, value) => query[key] = value.toString());
  //   }
  //
  //   final uri = Uri.https(baseUrl, url, query);
  //
  //   logRequest(url, body);
  //
  //   try {
  //     final response =
  //         await http.patch(uri, body: jsonEncode(body), headers: innerHeader).timeout(
  //               const Duration(seconds: 40),
  //               onTimeout: () => http.Response('connectionTimeOut', 481),
  //             );
  //
  //     logResponse(url, response);
  //     _serverDate = getDateTimeFromHeaders(response);
  //     return response;
  //   } catch(e) {
  //     loggerObject.e(e);
  //     return http.Response('{}', 481);
  //   }
  // }
  //
  // Future<http.Response> deleteApi({
  //   required String url,
  //   Map<String, dynamic>? body,
  //   Map<String, dynamic>? query,
  //   Map<String, String>? header,
  // }) async {
  //   if (body != null) body.removeWhere((key, value) => value == null);
  //
  //   if (query != null) {
  //     query.removeWhere((key, value) => (value == null || value.toString().isEmpty));
  //     query.forEach((key, value) => query[key] = value.toString());
  //   }
  //
  //   innerHeader.addAll(header ?? {});
  //
  //   final uri = Uri.https(baseUrl, url, query);
  //
  //   logRequest(url, query);
  //
  //   try {
  //     final response =
  //         await http.delete(uri, body: jsonEncode(body), headers: innerHeader).timeout(
  //               const Duration(seconds: 40),
  //               onTimeout: () => http.Response('connectionTimeOut', 481),
  //             );
  //
  //     logResponse(url, response);
  //     _serverDate = getDateTimeFromHeaders(response);
  //     return response;
  //   } catch(e) {
  //     loggerObject.e(e);
  //     return http.Response('{}', 481);
  //   }
  // }

  Future<http.Response> uploadMultiPart({
    required String url,
    String? path,
    String type = 'POST',
    List<UploadFile?>? files,
    Map<String, dynamic>? fields,
    Map<String, String>? header,
  }) async {

    final uri = getUri(url: url, query: fields, path: path, type: ApiType.post);

    var request = http.MultipartRequest(type, uri);

    for (var uploadFile in (files ?? <UploadFile?>[])) {
      if (uploadFile?.fileBytes == null) continue;

      final multipartFile = http.MultipartFile.fromBytes(
        uploadFile!.nameField,
        uploadFile.fileBytes!,
        filename: '${getRandomString(10)}.jpg',
      );

      request.files.add(multipartFile);
    }

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers.addAll(innerHeader);
    request.fields.addAll(fixFields(fields));

    final stream = await request.send().timeout(
      const Duration(seconds: 40),
      onTimeout: () => http.StreamedResponse(Stream.value([]), 481),
    );

    final response = await http.Response.fromStream(stream);

    logResponse(url: url, response: response, type: ApiType.post);

    return response;
  }

  Future<DateTime> getServerTime() async {
    if (_serverDate != null) return _serverDate!;
    var uri = Uri.https(baseUrl);

    final response = await http.get(uri, headers: innerHeader).timeout(
          const Duration(seconds: 40),
          onTimeout: () => http.Response('connectionTimeOut', 481),
        );

    _serverDate = getDateTimeFromHeaders(response);

    return _serverDate!;
  }
}

DateTime getDateTimeFromHeaders(http.Response response) {
  final headers = response.headers;

  if (headers.containsKey('date')) {
    final dateString = headers['date']!;

    final dateTime = parseGMTDate(dateString);
    return dateTime.addFromNow();
  } else {
    return DateTime.now();
  }
}

DateTime parseGMTDate(String dateString) {
  final formatter = DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'');
  return formatter.parseUTC(dateString);
}

class UploadFile {
  final Uint8List? fileBytes;
  final String nameField;
  final String? initialImage;

  UploadFile({
    required this.fileBytes,
    this.initialImage,
    this.nameField = 'File',
  });

  UploadFile copyWith({
    Uint8List? fileBytes,
    String? nameField,
  }) {
    return UploadFile(
      fileBytes: fileBytes ?? this.fileBytes,
      nameField: nameField ?? this.nameField,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'filelBytes': fileBytes,
      'nameField': nameField,
    };
  }

  factory UploadFile.fromMap(Map<String, dynamic> map) {
    return UploadFile(
      fileBytes: map['filelBytes'] as Uint8List,
      nameField: map['nameField'] as String,
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
