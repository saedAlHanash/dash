import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/notification_request.dart';

part 'notification_state.dart';

class CreateNotificationCubit extends Cubit<CreateNotificationInitial> {
  CreateNotificationCubit() : super(CreateNotificationInitial.initial());

  Future<void> createNotification(BuildContext context, {required NotificationRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading,request: request));

    final pair = await _createNotificationApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createNotificationApi() async {
    final response = await APIService().postApi(
      url: PostUrl.sendNotificaion,
      body: state.request.toMap(),
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
