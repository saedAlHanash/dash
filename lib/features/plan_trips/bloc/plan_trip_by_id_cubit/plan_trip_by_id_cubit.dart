import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/plan_trips/data/response/plan_trips_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/plan_trips_response.dart';

part 'plan_trip_by_id_state.dart';

class PlanTripBuIdCubit extends Cubit<PlanTripBuIdInitial> {
  PlanTripBuIdCubit() : super(PlanTripBuIdInitial.initial());

  Future<void> getPlanTripBuId(BuildContext context, {required int id}) async {
    if (id == 0) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getPlanTripBuIdApi(id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<PlanTripModel?, String?>> _getPlanTripBuIdApi({required int id}) async {
    final response =
        await APIService().getApi(url: GetUrl.planTripById, query: {'Id': id});

    if (response.statusCode == 200) {
      return Pair(PlanTripModel.fromJson(response.json['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
