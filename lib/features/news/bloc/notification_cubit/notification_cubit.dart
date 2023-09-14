import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'notification_state.dart';

class CreateNotificationCubit extends Cubit<CreateNotificationInitial> {
  CreateNotificationCubit() : super(CreateNotificationInitial.initial());

  Future<void> createNotification(BuildContext context, {required String policy}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _createNotificationApi(policy: policy);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createNotificationApi({required String policy}) async {
    final response = await APIService().postApi(
      url: PostUrl.sendNotificaion,
      query: {'UserType': 0},
      body: {"title": "إعلان", "body": policy},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
