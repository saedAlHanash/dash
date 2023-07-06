import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'create_state.dart';

class CreateReasonCubit extends Cubit<CreateReasonInitial> {
  CreateReasonCubit() : super(CreateReasonInitial.initial());

  Future<void> createReason(BuildContext context, {required String reason}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _createReasonApi(reason: reason);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createReasonApi({required String reason}) async {
    final response =
        await APIService().postApi(url: PostUrl.createReason, body: {'name': reason});

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
