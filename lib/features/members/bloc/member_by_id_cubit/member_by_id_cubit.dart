import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/member_response.dart';

part 'member_by_id_state.dart';

class MemberBuIdCubit extends Cubit<MemberBuIdInitial> {
  MemberBuIdCubit() : super(MemberBuIdInitial.initial());

  Future<void> getMemberBuId(BuildContext context, {required int id}) async {
    if (id == 0) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getMemberBuIdApi(id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Member?, String?>> _getMemberBuIdApi({required int id}) async {
    final response =
        await APIService().getApi(url: GetUrl.getMemberById, query: {'Id': id});

    if (response.statusCode == 200) {
      return Pair(Member.fromJson(response.jsonBody['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
