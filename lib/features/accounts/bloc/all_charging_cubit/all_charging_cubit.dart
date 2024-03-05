import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/wallet/data/response/wallet_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'all_charging_state.dart';

class AllChargingCubit extends Cubit<AllChargingInitial> {
  AllChargingCubit() : super(AllChargingInitial.initial());

  Future<void> getAllCharging(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getAllChargingApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;

      emit(state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first!.items
            ..removeWhere((e) => e.chargerPhone == e.clientPhone)));
    }
  }

  Future<Pair<ChargingResult?, String?>> _getAllChargingApi() async {
    final response = await APIService().getApi(
      url: GetUrl.getAllCharging,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(ChargingResult.fromJson(response.json['result'] ?? {}), null);
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

    final pair = await _getAllChargingApi();
    state.command
      ..maxResultCount = 20
      ..skipCount = oldSkipCount;
    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
    } else {
      return _getXlsData(pair.first!.items..removeWhere((e) => e.chargerPhone == e.clientPhone));
    }
    return null;
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Charging> data) {
    return Pair(
        [
          '\tالمرسل\t',
          '\tالمستقبل\t',
          '\tالقيمة\t',
          '\tالحالة\t',
          '\tالتاريخ\t',
        ],
        data
            .mapIndexed(
              (index, e) => [
                e.chargerName.isEmpty ? e.providerName : e.chargerName,
                e.userName,
                e.amount == 0 ? 'عملية استرجاع' : e.amount.formatPrice,
                e.status.arabicName,
                e.date?.formatDate,
              ],
            )
            .toList());
  }
}
