import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/features/agencies/data/response/agency_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';


part 'create_agency_state.dart';

class CreateAgencyCubit extends Cubit<CreateAgencyInitial> {
  CreateAgencyCubit() : super(CreateAgencyInitial.initial());

  Future<void> createAgency(
    BuildContext context, {
    required Agency request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _createAgencyApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createAgencyApi(
      {required Agency request}) async {
    final response = await APIService().uploadMultiPart(
      url: request.id != 0 ? PutUrl.updateAgency : PostUrl.createAgency,
      fields: request.toJson(),
      type: request.id != 0 ? 'PUT' : 'POST',
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
