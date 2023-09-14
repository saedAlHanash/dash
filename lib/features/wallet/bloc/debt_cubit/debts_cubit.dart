import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/debt_response.dart';

part 'debts_state.dart';

class DebtsCubit extends Cubit<DebtsInitial> {
  DebtsCubit() : super(DebtsInitial.initial());

  Future<void> getDebts(BuildContext context, {int? id, Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command, id: id));
    final pair = await _getDebtsApi(id: id ?? state.id);

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

  Future<Pair<DebtsResult?, String?>> _getDebtsApi({required int id}) async {
    final response = await APIService().getApi(
      url: GetUrl.debt,
      query: {'driverId': id}..addAll(state.command.toJson()),
    );

    if (response.statusCode == 200) {
      return Pair(DebtsResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
