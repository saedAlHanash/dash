import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:map_package/error_manager.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/agencies/data/response/agencies_financial_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import 'package:qareeb_models/agencies/data/response/agency_response.dart';

part 'agency_report_state.dart';

class AgencyReportCubit extends Cubit<AgencyReportInitial> {
  AgencyReportCubit() : super(AgencyReportInitial.initial());

  Future<void> getAgencyReport(
    BuildContext context, {
    int? id,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _getAgencyReportApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<AgencyReport?, String?>> _getAgencyReportApi() async {
    final response = await APIService().getApi(
      url: GetUrl.agencyFinancialReport,
      query: {'agencyId': state.id},
    );
    if (response.statusCode == 200) {
      return Pair(AgencyReport.fromJson(response.json['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
