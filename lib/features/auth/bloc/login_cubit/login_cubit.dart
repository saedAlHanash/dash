import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/login_request.dart';
import '../../data/response/login_response.dart';
import '../../data/response/permission_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginInitial> {
  LoginCubit() : super(LoginInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> login(BuildContext context, {required LoginRequest? request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _loginApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }

      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashToken(pair.first!.accessToken);
      AppSharedPreference.cashMyId(pair.first!.userId);
      AppSharedPreference.cashUser(pair.first!);

      var result = await _getPermissions();

      if (result.first == null) {
        if (context.mounted) {
          NoteMessage.showSnakeBar(message: result.second ?? '', context: context);
          return;
        }
      }
      var s = '';
      for (var e in result.first!.items) {
        s += '${e.name},';
      }
      AppSharedPreference.cashPermissions(s);
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginResult?, String?>> _loginApi() async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: PostUrl.login,
        body: state.request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(LoginResponse.fromJson(response.jsonBody).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  Future<Pair<PermissionsResult?, String?>> _getPermissions() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: PostUrl.getPermissions,
      );

      if (response.statusCode == 200) {
        return Pair(PermissionsResponse.fromJson(response.jsonBody).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
