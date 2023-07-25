import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_temp_trip_request.dart';

part 'create_temp_trip_state.dart';

class CreateTempTripCubit extends Cubit<CreateTempTripInitial> {
  CreateTempTripCubit() : super(CreateTempTripInitial.initial());

  Future<void> createTempTrip(BuildContext context,
      {required CreateTempTripRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createTempTripApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createTempTripApi() async {
    late Response response;

    if (state.request.id != null) {
      response = await APIService().puttApi(
        url: PutUrl.updateTempTrip,
        body: state.request.toJson(),
      );
    } else {
      response = await APIService().postApi(
        url: PostUrl.createTempTrip,
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
