import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/plans/data/response/plan_attendances.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/plan_attendances_filter.dart';

part 'plan_attendances_state.dart';

class PlanAttendancesCubit extends Cubit<PlanAttendancesInitial> {
  PlanAttendancesCubit() : super(PlanAttendancesInitial.initial());

  Future<void> getAttendances(BuildContext context,
      {PlanAttendanceFilter? request, Command? command}) async {
    emit(state.copyWith(
        statuses: CubitStatuses.loading, request: request, command: command));
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

  Future<Pair<PlanAttendanceResult?, String?>> _getAttendancesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.planAttendance,
      query: state.command.toJson()..addAll(state.request.toJson()),
    );

    if (response.statusCode == 200) {
      return Pair(PlanAttendancesResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

// Future<Pair<List<String>, List<List<dynamic>>>?> getAttendancesAsync(
//     BuildContext context) async {
//   var oldSkipCount = state.command.skipCount;
//   state.command
//     ..maxResultCount = 1.maxInt
//     ..skipCount = 0;
//
//   final pair = await _getAttendancesApi();
//
//   state.command
//     ..maxResultCount = AppSharedPreference.getTotalCount
//     ..skipCount = oldSkipCount;
//
//   if (pair.first == null) {
//     if (context.mounted) {
//       NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
//     }
//   } else {
//     return _getXlsData(pair.first!.items);
//   }
//   return null;
// }

// Pair<List<String>, List<List<dynamic>>> _getXlsData(List<PlanAttendance> data) {
//   return Pair(
//       [
//         '\tID\t',
//         '\tID السائق\t',
//         '\tاسم السائق\t',
//         '\tاسم الشركة\t',
//         '\tاسم الزبون\t',
//         '\tتاريخ العملية\t',
//         '\tوقت العملية العملية\t',
//       ],
//       data
//           .mapIndexed(
//             (index, element) => [
//               element.id,
//               element.driverId,
//               element.driver.fullName,
//               element.enrollment.company.name,
//               element.enrollment.user.fullName,
//               element.date?.formatDate,
//               element.date?.formatTime,
//             ],
//           )
//           .toList());
// }
}
