import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';


import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/bus_trips_response.dart';


part 'bus_trip_by_id_state.dart';

class BusTripBuIdCubit extends Cubit<BusTripBuIdInitial> {
  BusTripBuIdCubit() : super(BusTripBuIdInitial.initial());

  Future<void> getBusTripBuId(BuildContext context, {required int id}) async {
    if(id==0)return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getBusTripBuIdApi(id:id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<BusTripModel?, String?>> _getBusTripBuIdApi({required int id}) async {
    final response = await APIService().getApi(
      url: GetUrl.busTripById,
      query: {'Id':id}

    );

    if (response.statusCode == 200) {
      return Pair(BusTripModel.fromJson(response.jsonBody['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
