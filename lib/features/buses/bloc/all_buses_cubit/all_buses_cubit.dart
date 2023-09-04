import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../map/data/response/ather_response.dart';
import '../../data/response/buses_response.dart';

part 'all_buses_state.dart';

class AllBusesCubit extends Cubit<AllBusesInitial> {
  AllBusesCubit() : super(AllBusesInitial.initial());

  Future<void> getBuses(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getBusesApi();

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

  Future<Pair<List<String>, List<List<dynamic>>>?> getBusesAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    emit(state.copyWith(
        command: state.command.copyWith(maxResultCount: 1.maxInt, skipCount: 0)));
    final pair = await _getBusesApi();
    emit(state.copyWith(
        command: state.command.copyWith(maxResultCount: 20, skipCount: oldSkipCount)));
    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
    } else {
      return _getXlsData(pair.first!.items);
    }
    return null;
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<BusModel> data) {
    return Pair(
        [
          'ID',
          'IMEI',
          'اسم الباص',
          'رقم هاتف السائق',
          'نوع الباص',
          'لون الباص',
          'رقم لوحة الباص',
          'عد المقاعد',
        ],
        data
            .mapIndexed(
              (index, element) => [
                element.id,
                element.ime,
                element.driverName,
                element.driverPhone,
                element.busModel,
                element.busColor,
                element.busNumber,
                element.seatsNumber,
              ],
            )
            .toList());
  }

  Ime getBusByImei(Ime imei) {
    final r = state.result.firstWhereOrNull((element) => element.ime == imei.ime);
    if (r != null) {
      imei.name = r.driverName;
    }
    return imei;
  }

  Future<Pair<BusResult?, String?>> _getBusesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.buses,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(BusesResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
