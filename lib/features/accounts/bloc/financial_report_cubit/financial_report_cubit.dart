import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import 'package:qareeb_models/wallet/data/response/single_driver_financial.dart';

part 'financial_report_state.dart';

class FinancialReportCubit extends Cubit<FinancialReportInitial> {
  FinancialReportCubit() : super(FinancialReportInitial.initial());

  Future<void> getReport(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getReportApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(
        statuses: CubitStatuses.done,
        result: pair.first!.items,
        response: pair.first,
      ));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getDriversAsync(
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
      return _getXlsData(pair.first!.items);
    }
    return null;
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<FinancialResult> data) {
    return Pair(
        [
          '\tمعرف السائق\t',
          '\tالاسم الكامل\t',
          '\tرقم الهاتف\t',
          '\tمستحقات الشركة\t',
          '\tمستحقات السائق\t',
          '\tالملخص\t',
        ],
        data
            .mapIndexed(
              (index, e) => [
                e.driverId,
                e.driverName,
                e.driverPhoneNo,
                e.requiredAmountFromCompany,
                e.requiredAmountFromDriver,
                getMessage(e),
              ],
            )
            .toList());
  }

  Future<Pair<FinancialReportResult?, String?>> _getReportApi() async {
    final response = await APIService().getApi(
      url: GetUrl.financialReport,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(FinancialReportResult.fromJson(response.json), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}

SummaryPayToEnum summaryType(FinancialResult report) {
  if (report.requiredAmountFromDriver > report.requiredAmountFromCompany) {
    return SummaryPayToEnum.requiredFromDriver;
  } else if (report.requiredAmountFromCompany > report.requiredAmountFromDriver) {
    return SummaryPayToEnum.requiredFromCompany;
  } else {
    return SummaryPayToEnum.equal;
  }
}

String getMessage(FinancialResult report) {
  switch (summaryType(report)) {
    //السائق يجب أن يدفع للشركة
    case SummaryPayToEnum.requiredFromDriver:
      return 'يستوجب على السائق تسديد مبلغ للشركة وقدره :  \n'
          '${(report.requiredAmountFromDriver - report.requiredAmountFromCompany).formatPrice}\n  ليرة سورية ';

    //الشركة يجب انت تدفع للسائق
    case SummaryPayToEnum.requiredFromCompany:
      return 'يستوجب على الشركة تسديد مبلغ للسائق وقدره :   \n'
          ' ${(report.requiredAmountFromCompany - report.requiredAmountFromDriver).formatPrice}\n   ليرة سورية';

    //الرصيد متكافئ
    case SummaryPayToEnum.equal:
      return 'ان مستحقات الشركة من السائق مساوية تماما لمستحقات السائق لدى الشركة';
  }
}
