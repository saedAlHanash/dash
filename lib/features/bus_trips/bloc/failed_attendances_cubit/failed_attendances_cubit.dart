import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/trip_history_response.dart';

part 'failed_attendances_state.dart';

class FailedAttendancesCubit extends Cubit<FailedAttendancesInitial> {
  FailedAttendancesCubit() : super(FailedAttendancesInitial.initial());

  Future<void> getFailedAttendances(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getFailedAttendancesApi();

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

  Future<Pair<TripHistoryResult?, String?>> _getFailedAttendancesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.failedAttendances,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(TripHistoryResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getFailedAttendancesAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getFailedAttendancesApi();

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

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<TripHistoryItem> data) {
    return Pair(
        [
          '\tID\t',
          '\tID الباص\t',
          '\tاسم الباص\t',
          '\tاسم الرحلة\t',
          '\tاسم الطالب\t',
          '\tتاريخ العملية\t',
          '\tوقت العملية العملية\t',
          '\tنوع المعملية\t',
          '\tحالة الاشتراك بالنقل\t',
        ],
        data
            .mapIndexed(
              (index, element) => [
                element.id,
                element.busId,
                element.bus.driverName,
                element.busTrip.name,
                element.busMember.fullName,
                element.date?.formatDate,
                element.date?.formatTime,
                element.attendanceType.arabicName,
                element.isSubscribed ,
              ],
            )
            .toList());
  }

  void update() {
    emit(state.copyWith());
  }
}
