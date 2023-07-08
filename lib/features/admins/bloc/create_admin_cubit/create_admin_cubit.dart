import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_admin_request.dart';

part 'create_admin_state.dart';

class CreateAdminCubit extends Cubit<CreateAdminInitial> {
  CreateAdminCubit() : super(CreateAdminInitial.initial());

  Future<void> createAdmin(
    BuildContext context, {
    required CreateAdminRequest request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _createAdminApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createAdminApi(
      {required CreateAdminRequest request}) async {
    late Response response;

    if (request.id != null) {
      response = await APIService().puttApi(
        url: PutUrl.updateAdmin,
        body: request.toJson(),
      );
    } else {
      response = await APIService().postApi(
        url: PostUrl.createAdmin,
        body: request.toJson(),
      );
    }

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
