import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordInitial> {
  ForgotPasswordCubit({required this.network})
      : super(ForgotPasswordInitial.initial());

  final NetworkInfo network;

  Future<void> forgotPassword(BuildContext context,
      {required String phone}) async {

    final pair = await _forgotPasswordApi(phone: phone);


    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      // emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {

      AppSharedPreference.cashStateScreen(StateScreen.passwordCode);
      AppSharedPreference.cashPhoneNumber(phone);

      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _forgotPasswordApi(
      {required String phone}) async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: PostUrl.forgotPassword,
        body: {'phoneNumber': phone},
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
