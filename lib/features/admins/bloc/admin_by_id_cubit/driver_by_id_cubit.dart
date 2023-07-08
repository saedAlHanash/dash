import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'driver_by_id_state.dart';

class DriverBuIdCubit extends Cubit<DriverBuIdInitial> {
  DriverBuIdCubit() : super(DriverBuIdInitial.initial());

  Future<void> getDriverBuId(BuildContext context, {required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getDriverBuIdApi(id:id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<DriverModel?, String?>> _getDriverBuIdApi({required int id}) async {
    final response = await APIService().getApi(
      url: GetUrl.getDriverById,
      query: {'Id':id}

    );

    if (response.statusCode == 200) {
      return Pair(DriverModel.fromJson(response.jsonBody['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
