import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:map_package/map/data/response/ather_response.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/home/data/response/drivers_imei_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'drivers_imei_state.dart';
class DriversImeiCubit extends Cubit<DriversImeiInitial> {
  DriversImeiCubit() : super(DriversImeiInitial.initial());

  Future<void> getDriversImei(BuildContext context,
      {DriverStatus? status, LatLng? startPoint}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, status: status));
    final pair = await _getDriversImeiApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(result: pair.first));

      final l = await AtherCubit.getDriverLocationApi(state.getImeisListString);
      final atherResult = <Ime>[];
      if (startPoint != null) {
        atherResult.addAll(getNearestPoints(startPoint, l.first ?? []));
      } else {
        atherResult.addAll((l.first ?? []).take(10));
      }

      emit(state.copyWith(
          statuses: CubitStatuses.done, result: pair.first, atherResult: atherResult));
    }
  }

  Future<Pair<List<DriverImei>?, String?>> _getDriversImeiApi() async {
    final q = Command.initial().toJson();
    if (state.status != null) {
      q['status'] = state.status!.index;
    }
    final response = await APIService().getApi(
      url: GetUrl.getDriversImei,
      query: q,
    );

    if (response.statusCode == 200) {
      return Pair(DriversImei.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
