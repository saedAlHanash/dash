import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_member_request.dart';
import '../../data/response/member_response.dart';

part 'create_member_state.dart';

class CreateMemberCubit extends Cubit<CreateMemberInitial> {
  CreateMemberCubit() : super(CreateMemberInitial.initial());

  Future<void> createMember(
    BuildContext context, {
    required CreateMemberRequest request,
  }) async {
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      request: request,
    ));

    var pair = await _createMemberApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: true));
    }
  }

  Future<Pair<Member?, String?>> _createMemberApi() async {
    final response = await APIService().uploadMultiPart(
      url: state.request.id != null ? PutUrl.updateMember : PostUrl.createMember,
      fields: state.request.toJson(),
      type: state.request.id != null ? 'PUT' : 'POST',
      files: [
        state.request.file,
      ],
    );

    if (response.statusCode == 200) {
      return Pair(Member.fromJson(response.jsonBody['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

}
