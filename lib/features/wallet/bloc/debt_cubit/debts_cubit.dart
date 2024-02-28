import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/wallet/data/response/debt_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'debts_state.dart';

class DebtsCubit extends Cubit<DebtsInitial> {
  DebtsCubit() : super(DebtsInitial.initial());

  Future<void> getDebts(BuildContext context, {int? id, Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command, id: id));
    final pair = await _getDebtsApi(id: id ?? state.id);

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

  Future<Pair<DebtsResult?, String?>> _getDebtsApi({required int id}) async {
    final response = await APIService().getApi(
      url: GetUrl.debt,
      query: {'driverId': id}..addAll(state.command.toJson()),
    );

    if (response.statusCode == 200) {
      return Pair(DebtsResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getDataAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getDebtsApi(id: state.id);

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

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Debt> data) {
    return Pair(
        [
          '\t id \t',
          '\t حصة السائق \t',
          '\t الكلي \t',
          '\t السعر بعد الحسم \t',
          '\t قيمة الحسم \t',
          '\t تاريخ \t',
          '\t زيت \t',
          '\t مليون \t',
          '\t إطارات \t',
          '\t بنزين \t',
          '\t حصة الوكيل \t',
          '\t حصة الهيئة \t',
          '\t تعويض\t',
          '\t نوع \t',
        ],
        data
            .mapIndexed(
              (index, e) => [
                e.id,
                e.driverShare,
                e.totalCost,
                e.costAfterDiscount,
                e.discountAmount.formatPrice,
                e.date?.toIso8601String() ?? '',
                e.oilShare,
                e.goldShare,
                e.tiresShare,
                e.gasShare,
                e.agencyShare,
                e.syrianAuthorityShare,
                e.driverCompensation,
                e.type.arabicName,
              ],
            )
            .toList());
  }
}
