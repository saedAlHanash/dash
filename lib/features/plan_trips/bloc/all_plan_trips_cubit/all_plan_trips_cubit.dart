import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/plan_trips/data/response/plan_trips_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/response/plan_trips_response.dart';

part 'all_plan_trips_state.dart';

class AllPlanTripsCubit extends Cubit<AllPlanTripsInitial> {
  AllPlanTripsCubit() : super(AllPlanTripsInitial.initial());

  Future<void> getPlanTrips(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getPlanTripsApi();

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

  Future<Pair<PlanTripsResult?, String?>> _getPlanTripsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.planTrips,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(PlanTripsResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getPlanAsync(
      BuildContext context) async {

    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getPlanTripsApi();
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

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<PlanTripModel> data) {
    return Pair(
        [
          'ID',
          'الاسم',
          'وصف',
          'عدد اشتراكات الإشعارات',
          'حالة الرحلة',
          'مسافة الرحلة',
          'باصات الرحلة',
          'تاريخ ووقت البداية',
          'تاريخ ووقت النهاية',
          'نوع الرحلة',
          'أيام الرحلة',
        ],
        data
            .mapIndexed(
              (index, element) => [
                element.id,
                element.name,
                element.description,
                // element.numberOfParticipation,
                // element.isActive ? 'Active' : 'Un Active',
                // element.distance,
                // element.Plans.map((e) => e.driverName).toList().join("-"),
                element.startDate?.toIso8601String(),
                element.endDate?.toIso8601String(),
                // element.planTripType.arabicName,
                element.days.map((e) => e.arabicName).toList().join("-"),
              ],
            )
            .toList());
  }

  void update() {
    emit(state.copyWith());
  }
}
