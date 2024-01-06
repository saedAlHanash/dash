import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/pair_class.dart';

class InsertFirebaseTokenService {
  insertFirebaseToken() async {
    FirebaseMessaging.instance.requestPermission();
    loggerObject.wtf('start send FCM token');
    final token = await FirebaseMessaging.instance.getToken(
      vapidKey:
          "BExhANsTR4Ef4IJ8A6mcXgsJQcP3s1JU43-TtLiEKNwO34iKaCWTsTFV_0TUUpxfayVhN71zfMtk9TiWsDiKhSg",
    );

    if (token == null) return;
    final pair = await _insertFirebaseTokenApi(token: token);

    if (pair.first == null) {
      Timer(
        const Duration(seconds: 40),
        () => insertFirebaseToken(),
      );
    } else {
      loggerObject.wtf('done Done Fire token \n$token');
      // emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _insertFirebaseTokenApi({required String token}) async {
    final response = await APIService().postApi(
      url: PostUrl.insertFireBaseToken,
      body: {'token': token},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
