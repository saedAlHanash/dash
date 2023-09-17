import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import 'package:qareeb_models/global.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/government_response.dart';

part 'create_governorate_state.dart';

class CreateGovernmentCubit extends Cubit<CreateGovernmentInitial> {
  CreateGovernmentCubit() : super(CreateGovernmentInitial.initial());

  Future<void> createGovernment(BuildContext context,
      {required GovernmentModel request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createGovernmentApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createGovernmentApi() async {
    late final Response response;
    if (state.request.id == 0) {
      response = await APIService().postApi(
        url: PostUrl.createGovernment,
        body: state.request.toJson(),
      );
    } else {
      response = await APIService().puttApi(
        url: PutUrl.updateGovernment,
        body: state.request.toJson(),
      );
    }

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
