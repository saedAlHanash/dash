import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/governorate_response.dart';

part 'create_governorate_state.dart';


class CreateGovernorateCubit extends Cubit<CreateGovernorateInitial> {
  CreateGovernorateCubit() : super(CreateGovernorateInitial.initial());

  Future<void> createGovernorate(BuildContext context,
      {required GovernorateModel request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createGovernorateApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createGovernorateApi() async {
    late final Response response;
    if (state.request.id == 0) {
      response = await APIService().postApi(
        url: PostUrl.createGovernorate,
        body: state.request.toJson(),
      );
    } else {
      response = await APIService().puttApi(
        url: PutUrl.updateGovernorate,
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
