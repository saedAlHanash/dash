import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'delete_governorate_state.dart';

class DeleteGovernmentCubit extends Cubit<DeleteGovernmentInitial> {
  DeleteGovernmentCubit() : super(DeleteGovernmentInitial.initial());

  Future<void> deleteGovernment(BuildContext context, {required int id}) async {
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;

    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _deleteGovernmentApi(id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deleteGovernmentApi({required int id}) async {
    final response = await APIService().deleteApi(
      url: DeleteUrl.deleteCancelGovernment,
      query: {'Id': id},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
