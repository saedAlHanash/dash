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
import '../../data/response/buses_response.dart';

part 'bus_by_imei_state.dart';

class BusByImeiCubit extends Cubit<BusByImeiInitial> {
  BusByImeiCubit() : super(BusByImeiInitial.initial());

  Future<void> getBusByIme(BuildContext context, {required String ime}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getBusesApi(ime:ime);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<BusModel?, String?>> _getBusesApi( {required String ime}) async {
    final response = await APIService().getApi(
      url: GetUrl.buses,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(response.jsonBody['result'], null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
