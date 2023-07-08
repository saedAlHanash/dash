import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/cretae_driver_request.dart';

part 'create_driver_state.dart';

class CreateDriverCubit extends Cubit<CreateDriverInitial> {
  CreateDriverCubit() : super(CreateDriverInitial.initial());

  Future<void> createDriver(
    BuildContext context, {
    required CreateDriverRequest request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _createDriverApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createDriverApi(
      {required CreateDriverRequest request}) async {
    final response = await APIService().uploadMultiPart(
      url: request.id != null ? PutUrl.updateDriver : PostUrl.createDriver,
      fields: request.toMap(),
      type: request.id != null ? 'PUT' : 'POST',
      files: [
        request.imageFile,
        request.identityFile,
        request.contractFile,
        request.drivingLicenceFile,
        request.carMechanicFile,
      ],
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
