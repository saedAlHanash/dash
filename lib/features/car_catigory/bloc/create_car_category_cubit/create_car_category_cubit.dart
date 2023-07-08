import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_car_category_request.dart';

part 'create_car_category_state.dart';

class CreateCarCategoryCubit extends Cubit<CreateCarCategoryInitial> {
  CreateCarCategoryCubit() : super(CreateCarCategoryInitial.initial());

  Future<void> createCarCategory(BuildContext context,
      {required CreateCarCatRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createCarCategoryApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createCarCategoryApi() async {
    final response = await APIService().uploadMultiPart(
      url:
          state.request.id != null ? PutUrl.updateCarCategory : PostUrl.createCarCategory,
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
