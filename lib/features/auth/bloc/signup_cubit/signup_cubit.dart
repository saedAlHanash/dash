import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/request/signup_request.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupInitial> {
  SignupCubit({required this.network}) : super(SignupInitial.initial());

  final NetworkInfo network;

  Future<void> signup(BuildContext context,
      {required SignupRequest request}) async {

    final pair = await _signupApi(request: request);


    if (pair.first == null) {
      if (context.mounted) {
        if (pair.second == "302") {
          NoteMessage.showSnakeBar(
              message: AppStringManager.accountExist, context: context);
        } else if (pair.second == "301") {
          NoteMessage.showSnakeBar(
              message: AppStringManager.needActive, context: context);
        } else {
          NoteMessage.showSnakeBar(
              message: pair.second ?? '', context: context);
        }
      }
      // emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashPhoneNumber(request.phoneNumber);
      AppSharedPreference.cashStateScreen(StateScreen.confirmCode);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _signupApi(
      {required SignupRequest request}) async {
    if (await network.isConnected) {
      final response = await APIService()
          .postApi(url: PostUrl.signup, body: request.toJson());

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
