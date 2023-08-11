import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'delete_edge_state.dart';

class DeleteEdgeCubit extends Cubit<DeleteEdgeInitial> {
  DeleteEdgeCubit() : super(DeleteEdgeInitial.initial());

  Future<void> deleteEdge(BuildContext context,
      {required num start, required num end}) async {
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, id: end));
    final pair = await _deleteEdgeApi(start: start, end: end);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deleteEdgeApi(
      {required num start, required num end}) async {
    final response = await APIService().deleteApi(
      url: DeleteUrl.deleteEdge,
      query: {
        'FirstPointId': start,
        'SecondPointId': end,
      },
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
