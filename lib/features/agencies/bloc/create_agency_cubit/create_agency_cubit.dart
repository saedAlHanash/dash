import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/agency_request.dart';

part 'create_agency_state.dart';

class CreateAgencyCubit extends Cubit<CreateAgencyInitial> {
  CreateAgencyCubit() : super(CreateAgencyInitial.initial());

  Future<void> createAgency(
    BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _createAgencyApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createAgencyApi() async {
    final response = await APIService().uploadMultiPart(
      url: state.request.id != null ? PutUrl.updateAgency : PostUrl.createAgency,
      fields: state.request.toJson(),
      type: state.request.id != null?'PUT':'POST',
      files: [state.request.file],
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
