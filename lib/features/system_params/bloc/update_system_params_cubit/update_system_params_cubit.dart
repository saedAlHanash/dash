import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/features/system_params/data/response/system_params_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'update_system_params_state.dart';

class UpdateParamsCubit extends Cubit<UpdateParamsInitial> {
  UpdateParamsCubit() : super(UpdateParamsInitial.initial());

  Future<void> updateParams(
    BuildContext context, {
    required SystemParam request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _updateParamsApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _updateParamsApi({required SystemParam request}) async {
    late Response response;

    response = await APIService().puttApi(
      url: PutUrl.updateParams,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
