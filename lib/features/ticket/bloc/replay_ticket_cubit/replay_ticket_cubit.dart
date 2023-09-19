import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'replay_ticket_state.dart';

class ReplayTicketCubit extends Cubit<ReplayTicketInitial> {
  ReplayTicketCubit() : super(ReplayTicketInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> replayTicket(BuildContext context,
      {required String s, required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _replayTicketApi(s: s, id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<String?, String?>> _replayTicketApi(
      {required String s, required int id}) async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
          url: PostUrl.replayTicket,
          body: {"reply": s, "adminId": AppSharedPreference.getMyId, "ticketId": id});

      if (response.statusCode == 200) {
        return Pair(s, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
