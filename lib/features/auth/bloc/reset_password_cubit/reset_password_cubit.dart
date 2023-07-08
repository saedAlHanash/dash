import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/reset_password_request.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordInitial> {
  ResetPasswordCubit({required this.network})
      : super(ResetPasswordInitial.initial());

  final NetworkInfo network;

  Future<void> resetPassword(BuildContext context,
      {required ResetPasswordRequest request}) async {

    final pair = await _resetPasswordApi(request: request);



    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      // emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashStateScreen(StateScreen.non);
      AppSharedPreference.cashPhoneNumber('');
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _resetPasswordApi(
      {required ResetPasswordRequest request}) async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: PostUrl.resetPassword,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
