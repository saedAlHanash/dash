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
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/response/bus_trips_response.dart';

part 'all_bus_trips_state.dart';

class AllBusTripsCubit extends Cubit<AllBusTripsInitial> {
  AllBusTripsCubit() : super(AllBusTripsInitial.initial());

  Future<void> getBusTrips(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getBusTripsApi();

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

  Future<Pair<BusTripsResult?, String?>> _getBusTripsApi() async {
    final response = await APIService().getApi(
      url: GetUrl.busTrips,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(BusTripsResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getBusAsync(
      BuildContext context) async {
    emit(state.copyWith(command: state.command.copyWith(maxResultCount: 1.maxInt)));
    final pair = await _getBusTripsApi();
    emit(state.copyWith(command: state.command.copyWith(maxResultCount: 20)));
    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
    } else {
      return _getXlsData(pair.first!.items);
    }
    return null;
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<BusTripModel> data) {
    return Pair(
        [
          'id',
          'name',
          'tripTemplateId',
          'description',
          'numberOfParticipation',
          'isActive',
          'distance',
          'buses',
          'startDate',
          'endDate',
          'busTripType',
          'days',
        ],
        data
            .mapIndexed(
              (index, element) => [
                element.id,
                element.name,
                element.tripTemplateId,
                element.description,
                element.numberOfParticipation,
                element.isActive ? 'Active' : 'Un Active',
                element.distance,
                element.buses.map((e) => e.driverName).toList().join("-"),
                element.startDate?.toIso8601String(),
                element.endDate?.toIso8601String(),
                element.busTripType.name,
                element.days.map((e) => e.arabicName).toList().join("-"),
              ],
            )
            .toList());
  }

  void update() {
    emit(state.copyWith());
  }
}
