import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/redeems/data/response/redeems_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'redeems_state.dart';

class RedeemsCubit extends Cubit<RedeemsInitial> {
  RedeemsCubit() : super(RedeemsInitial.initial());

  Future<void> getRedeems(BuildContext context, {int? driverId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, driverId: driverId));
    final pair = await _getRedeemsApi(driverId: driverId);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<RedeemsResult?, String?>> _getRedeemsApi({int? driverId}) async {
    final response = await APIService().getApi(
      url:GetUrl.driverRedeems,
      query: {'DriverId': driverId},
    );

    if (response.statusCode == 200) {
      return Pair(RedeemsResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
