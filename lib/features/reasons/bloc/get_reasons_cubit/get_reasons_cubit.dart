import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/cancel_response.dart';

part 'get_reasons_state.dart';

class GetReasonsCubit extends Cubit<GetReasonsInitial> {
  GetReasonsCubit() : super(GetReasonsInitial.initial());

  Future<void> getReasons(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getReasonsApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Reasons>?, String?>> _getReasonsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.cancelReason,
    );

    if (response.statusCode == 200) {
      return Pair(CancelReasonsResponse.fromJson(response.json).result.items, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
