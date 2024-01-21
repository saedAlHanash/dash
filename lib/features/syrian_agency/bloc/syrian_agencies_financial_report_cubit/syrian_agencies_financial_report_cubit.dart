import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/wallet/data/response/wallet_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/syrian_agency_financial_report_response.dart';

part 'syrian_agencies_financial_report_state.dart';

class SyrianAgenciesFinancialReportCubit extends Cubit<SyrianAgenciesFinancialReportInitial> {
  SyrianAgenciesFinancialReportCubit() : super(SyrianAgenciesFinancialReportInitial.initial());

  Future<void> getReport(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getReportApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(
        statuses: CubitStatuses.done,
        result: pair.first,
      ));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getReportAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getReportApi();
    state.command
      ..maxResultCount = 20
      ..skipCount = oldSkipCount;
    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
    } else {
      return _getXlsData(pair.first!.transactions);
    }
    return null;
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Transaction> data) {
    return Pair(
        [
          '\tمعرف العملية\t',
          '\t تاريخ \t',
          '\t قيمة الدفعة \t',
          '\t نوع الدفعة \t',
          '\t ملاحظات \t',

        ],
        data
            .mapIndexed(
              (index, e) => [
                e.id.toString(),
                e.transferDate?.formatDateTime,
                e.amount.formatPrice,
                e.type.arabicName,
                e.note,
              ],
            )
            .toList());
  }

  Future<Pair<SyrianAgencyFinancialReport?, String?>> _getReportApi() async {
    final response = await APIService().getApi(
      url: GetUrl.syrianAgenciesFinancialReport,
    );

    if (response.statusCode == 200) {
      return Pair(
          SyrianAgencyFinancialReportResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
