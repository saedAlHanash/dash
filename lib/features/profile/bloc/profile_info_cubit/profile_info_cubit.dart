import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../../core/strings/enum_manager.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/profile_info_response.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoInitial> {
  ProfileInfoCubit() : super(ProfileInfoInitial.initial());

  Future<void> getProfileInfo(BuildContext context, {bool newData = false}) async {
    if (state.result.id > 0 && !newData) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await getProfileInfoApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashProfileInfo(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

 static Future<Pair<ProfileInfoResult?, String?>> getProfileInfoApi() async {

   final network = sl<NetworkInfo>();

   if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getProfileInfo,
      );

      if (response.statusCode == 200) {
        final data = ProfileInfoResponse.fromJson(jsonDecode(response.body)).result;
        return Pair(data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

// void setImage(String filePath) {
//   emit(state.copyWith(
//     result: state.result.copyWith(avatar: 'file$filePath'),
//     statuses: CubitStatuses.done,
//   ));
// }
}
