import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_models/auth/data/response/login_response.dart';
import 'package:qareeb_models/global.dart';
import 'package:universal_html/html.dart';

import '../../../../core/api_manager/api_service.dart'; import 'package:qareeb_dash/core/strings/enum_manager.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/login_request.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginInitial> {
  LoginCubit() : super(LoginInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> login(BuildContext context, {required LoginRequest request}) async {
    AppSharedPreference.cashEmail(request.email!);
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _loginApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      if (pair.first?.isActive == false && context.mounted) {
        NoteMessage.showErrorDialog(
          context,
          text: 'الحساب متوقف يرجى مراجعة الإدارة',
        );
        emit(state.copyWith(statuses: CubitStatuses.error));
        return;
      }
      await AppSharedPreference.cashToken(pair.first!.accessToken);
      await AppSharedPreference.cashMyId(pair.first!.userId);
      await AppSharedPreference.cashAgencyId(pair.first!.agencyId);
      await AppSharedPreference.cashUser(pair.first!);
      await AppSharedPreference.cashRole(pair.first!.roleName);
      await AppSharedPreference.cashEmail(request.email!);
      await AppSharedPreference.cashIdentifier(pair.first?.identifier ?? '');
      await AppSharedPreference.reload();
      var result = await getPermissions(id: pair.first!.userId);

      if (result.first == null) {
        if (context.mounted) {
          NoteMessage.showSnakeBar(message: result.second ?? '', context: context);
        }
        return;
      }
      var s = '';
      for (var e in result.first!) {
        s += '$e,';
      }
      await AppSharedPreference.cashPermissions(s);
      await AppSharedPreference.reload();
      // emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginResult?, String?>> _loginApi() async {
    if (await network.isConnected) {
      final response = await APIService().callApi(type: ApiType.post,
        url: PostUrl.login,
        body: state.request.toJson(),
      );

      if (response.statusCode == 200) {
        final user = LoginResponse.fromJson(response.json).result;
        // if (user.userType != UserType.admin || user.userType != UserType.agencyAdmin) {
        //   return Pair(null, 'المستخدم الحالي غير مصرح له بالدخول');
        // }
        return Pair(LoginResponse.fromJson(response.json).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}

Future<Pair<List<String>?, String?>> getPermissions({required int id}) async {
  final response = await APIService().callApi(type: ApiType.get,
    url: PostUrl.getPermissions,
    query: {'userId': id},
  );

  if (response.statusCode == 200) {
    final json = response.json['result'] ?? <String, dynamic>{};

    return Pair(json == null ? <String>[] : List<String>.from(json!.map((x) => x)), null);
  } else {
    return Pair(null, ErrorManager.getApiError(response));
  }
}

Future<void> refreshPermissions() async {
  if (!AppSharedPreference.isLogin) return;
  var result = await getPermissions(id: AppSharedPreference.getMyId);

  if (result.first == null) {
    return;
  }
  var s = '';
  for (var e in result.first!) {
    s += '$e,';
  }

  await AppSharedPreference.cashPermissions(s);
  await AppSharedPreference.reload();
}

Future<void> shouldLogout() async {
  if (!AppSharedPreference.isLogin) return;
  if (AppSharedPreference.getIdentifier.isEmpty) {
    await AppSharedPreference.logout();
    AppSharedPreference.reload();
    await AppSharedPreference.reload();
    window.location.reload();
    return;
  }
  final response = await APIService().callApi(type: ApiType.post,url: PostUrl.shouldLogout, query: {
    'identifier': AppSharedPreference.getIdentifier,
    'UserId': AppSharedPreference.getMyId,
  });

  if (response.statusCode == 401) {
    await AppSharedPreference.logout();
    AppSharedPreference.reload();
    await AppSharedPreference.reload();
    window.location.reload();
  }
}
