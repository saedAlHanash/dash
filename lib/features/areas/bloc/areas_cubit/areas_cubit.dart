import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/area_response.dart';

part 'areas_state.dart';

class AreasCubit extends Cubit<AreasInitial> {
  AreasCubit() : super(AreasInitial.initial());

  Future<void> getArea(BuildContext context, {Command? command, required int id}) async {
    if (id <= 0) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command, id: id));

    final pair = await _getAreaApi();

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

  Future<Pair<AreaResult?, String?>> _getAreaApi() async {
    final response = await APIService().getApi(
      url: GetUrl.areas,
      query: state.command.toJson()..addAll({'GovernorateId': state.id}),
    );

    if (response.statusCode == 200) {
      return Pair(AreaResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
