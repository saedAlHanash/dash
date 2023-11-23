import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/agency_response.dart';

part 'agency_by_id_state.dart';

class AgencyBuIdCubit extends Cubit<AgencyBuIdInitial> {
  AgencyBuIdCubit() : super(AgencyBuIdInitial.initial());

  Future<void> getAgencyBuId(BuildContext context, {required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAgencyBuIdApi(id:id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Agency?, String?>> _getAgencyBuIdApi({required int id}) async {
    final response = await APIService().getApi(
      url: GetUrl.getAgencyById,
      query: {'Id':id}

    );

    if (response.statusCode == 200) {
      return Pair(Agency.fromJson(response.json['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
