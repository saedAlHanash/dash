import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/messages_response.dart';

part 'all_messages_state.dart';

class AllMessagesCubit extends Cubit<AllMessagesInitial> {
  AllMessagesCubit() : super(AllMessagesInitial.initial());

  Future<void> getAllMessages(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAllMessagesApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<MessageModel>?, String?>> _getAllMessagesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getAllMessages,
    );

    if (response.statusCode == 200) {
      return Pair(MessagesResponse.fromJson(response.jsonBody).result.items, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
