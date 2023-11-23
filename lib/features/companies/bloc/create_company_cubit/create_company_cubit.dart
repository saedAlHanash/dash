import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_company_request.dart';

part 'create_company_state.dart';

class CreateCompanyCubit extends Cubit<CreateCompanyInitial> {
  CreateCompanyCubit() : super(CreateCompanyInitial.initial());

  Future<void> createCompany(BuildContext context,
      {required CreateCompanyRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createCompanyApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createCompanyApi() async {
    final response = await APIService().uploadMultiPart(
      url:
          state.request.id != null ? PutUrl.updateCompany : PostUrl.createCompany,
      type: state.request.id != null ? 'PUT' : 'POST',
      fields: state.request.toMap(),
      files: [
        state.request.file
      ],
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
