import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/cancel_trip_request.dart';

part 'cancel_trip_state.dart';

class CancelTripCubit extends Cubit<CancelTripInitial> {
  CancelTripCubit() : super(CancelTripInitial.initial());

  Future<void> cancelTrip(BuildContext context,
      {required CancelTripRequest request}) async {

    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _cancelTripApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error));
    } else {
      AppSharedPreference.removeCashedTrip();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _cancelTripApi(
      {required CancelTripRequest request}) async {
    final response = await APIService().postApi(
        url: PostUrl.cancelTrip, body: request.toJson(), query: {'ByAdmin': true});

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
