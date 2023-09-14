import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'clients_by_id_state.dart';

class ClientByIdCubit extends Cubit<ClientByIdInitial> {
  ClientByIdCubit() : super(ClientByIdInitial.initial());

  Future<void> getClientBuId(BuildContext context, {required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getClientBuIdApi(id:id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<DriverModel?, String?>> _getClientBuIdApi({required int id}) async {
    final response = await APIService().getApi(
      url: GetUrl.getClientById,
      query: {'Id':id}

    );

    if (response.statusCode == 200) {
      return Pair(DriverModel.fromJson(response.jsonBody['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
