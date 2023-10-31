import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:map_package/error_manager.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/wallet/data/response/driver_financial_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/driver_financial_filter_request.dart';

part 'driver_financial_state.dart';

class DriverFinancialCubit extends Cubit<DriverFinancialInitial> {
  DriverFinancialCubit() : super(DriverFinancialInitial.initial());

  Future<void> getDriverFinancial(
    BuildContext context, {
     DriverFinancialFilterRequest? request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _getDriverFinancialApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<DriverFinancialResult?, String?>> _getDriverFinancialApi() async {
    final response = await APIService().getApi(
      url: GetUrl.driverFinancialReport,
      query: state.request.toMap(),
    );
    if (response.statusCode == 200) {
      return Pair(DriverFinancialResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
