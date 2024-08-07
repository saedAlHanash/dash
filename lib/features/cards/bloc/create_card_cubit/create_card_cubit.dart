import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/card_request.dart';
import '../../data/response/cards_user_response.dart';

part 'create_card_state.dart';

class CreateCardCubit extends Cubit<CreateCardInitial> {
  CreateCardCubit() : super(CreateCardInitial.initial());

  Future<void> createCard() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _createCardApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createCardApi() async {
    final response = await APIService().uploadMultiPart(
        url: updateMode ? PutUrl.updateCard : PostUrl.createCard,
        fields: state.mRequest.toMap(),
        files: [state.mRequest.file],
        type: updateMode  ? ApiType.put:ApiType.post);

    if (response.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  void setUpdateData(UserCard? card) {
    if (card == null) return;
    emit(state.copyWith(request: CreateCardRequest.fromUserCard(card)));
  }

  void setRequest(CreateCardRequest request) {
    emit(state.copyWith(request: request));
  }

  bool get updateMode => !state.mRequest.id.isEmpty;
}
