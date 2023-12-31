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
import '../../data/request/create_point_request.dart';

part 'create_point_state.dart';

class CreatePointCubit extends Cubit<CreatePointInitial> {
  CreatePointCubit() : super(CreatePointInitial.initial());

  Future<void> createPoint(
    BuildContext context, {
    required CreatePointRequest request,
  }) async {

    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _createPointApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createPointApi(
      {required CreatePointRequest request}) async {
    late Response response;

    if (request.id != null) {
      response = await APIService().puttApi(
        url: PutUrl.updatePoint,
        body: request.toJson(),
      );
    } else {
      response = await APIService().postApi(
        url: PostUrl.createPoint,
        body: request.toJson(),
      );
    }


    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
