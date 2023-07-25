import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_institution_request.dart';

part 'create_institution_state.dart';

class CreateInstitutionCubit extends Cubit<CreateInstitutionInitial> {
  CreateInstitutionCubit() : super(CreateInstitutionInitial.initial());

  Future<void> createInstitution(BuildContext context,
      {required CreateInstitutionRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createInstitutionApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createInstitutionApi() async {
    final response = await APIService().uploadMultiPart(
      url:
          state.request.id != null ? PutUrl.updateInstitution : PostUrl.createInstitution,
      type: state.request.id != null ? 'PUT' : 'POST',
      fields: state.request.toMap(),
      files: [
        state.request.file,
      ],
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
