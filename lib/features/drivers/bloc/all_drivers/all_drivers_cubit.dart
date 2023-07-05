
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'all_drivers_state.dart';

class AllDriversCubit extends Cubit<AllDriversInitial> {
  AllDriversCubit() : super(AllDriversInitial.initial());

  Future<void> getAllDrivers(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAllDriversApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<DriverModel>?, String?>> _getAllDriversApi() async {
    final response = await APIService().getApi(
      url: GetUrl.allDrivers,
    );

    if (response.statusCode == 200) {
      return Pair(DriversResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
