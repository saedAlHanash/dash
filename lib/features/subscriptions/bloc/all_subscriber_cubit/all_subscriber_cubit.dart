import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/response/subscriber_response.dart';

part 'all_subscriber_state.dart';

class AllSubscriberCubit extends Cubit<AllSubscriberInitial> {
  AllSubscriberCubit() : super(AllSubscriberInitial.initial());

  Future<void> getSubscriber(BuildContext context,
      {Command? command, required tId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getSubscriberApi(tId: tId);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<SubscriberResult?, String?>> _getSubscriberApi({required tId}) async {
    final response = await APIService().getApi(
      url: GetUrl.getAllSubscriber,
      query: state.command.toJson()
        ..addAll({
          'templateId': tId,
        }),
    );

    if (response.statusCode == 200) {
      return Pair(SubscriberResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
