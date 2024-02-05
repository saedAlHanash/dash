import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:map_package/error_manager.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

import '../../data/response/syrian_agency_report_response.dart';

part 'syrian_agency_report_state.dart';

class SyrianAgencyReportCubit extends Cubit<SyrianAgencyReportInitial> {
  SyrianAgencyReportCubit() : super(SyrianAgencyReportInitial.initial());

  Future<void> getSyrianAgencyReport(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getSyrianAgencyReportApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<SyrianAgencyResult?, String?>> _getSyrianAgencyReportApi() async {
    final response = await APIService().getApi(
      url: GetUrl.syrianAgencyFinancialReport,
      query: state.command.toJson(),
    );
    if (response.statusCode == 200) {
      return Pair(SyrianAgencyReportResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
