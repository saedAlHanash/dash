import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'change_user_state_state.dart';

class ChangeUserStateCubit extends Cubit<ChangeUserStateInitial> {
  ChangeUserStateCubit() : super(ChangeUserStateInitial.initial());

  Future<void> changeUserState(BuildContext context,
      {required int id, required bool userState}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _changeUserStateApi(userState: userState);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _changeUserStateApi({required bool userState}) async {
    final response = await APIService().postApi(
        url: userState ? PostUrl.activateUser : PostUrl.deactivateUser,
        query: {'userId': state.id});

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
