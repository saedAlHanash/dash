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
import '../../../roles/data/response/permission_response.dart';

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
      AppSharedPreference.cashToken(pair.first!.accessToken);
      AppSharedPreference.cashMyId(pair.first!.userId);
      AppSharedPreference.cashInstitutionId(pair.first!.institutionId);
      AppSharedPreference.cashUser(pair.first!);
      AppSharedPreference.cashEmail(request.email!);

      loggerObject.e(AppSharedPreference.getInstitutionId);
      var result = await _getPermissions(id: pair.first!.userId);

      if (result.first == null) {
        if (context.mounted) {
          NoteMessage.showSnakeBar(message: result.second ?? '', context: context);
          return;
        }
      }
      var s = '';
      for (var e in result.first!) {
        s += '${e},';
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

  Future<Pair<List<String>?, String?>> _getPermissions({required int id}) async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: PostUrl.getPermissions,
        query: {'userId': id},
      );

      if (response.statusCode == 200) {
        final json = response.jsonBody['result'] ?? <String, dynamic>{};

        return Pair(
            json == null
                ? <String>[]
                : List<String>.from(json!.map((x) => x)),
            null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
