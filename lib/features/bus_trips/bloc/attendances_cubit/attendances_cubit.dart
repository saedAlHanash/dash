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
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/attendances_response.dart';

part 'attendances_state.dart';
// part 'attendances_state.dart';

class AllAttendancesCubit extends Cubit<AllAttendancesInitial> {
  AllAttendancesCubit() : super(AllAttendancesInitial.initial());

  Future<void> getAttendances(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getAttendancesApi();

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

  Future<Pair<AttendancesResult?, String?>> _getAttendancesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.attendances,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(AttendancesResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getAttendancesAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getAttendancesApi();

    state.command
      ..maxResultCount = AppSharedPreference.getTotalCount
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

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<AttendancesItem> data) {
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
