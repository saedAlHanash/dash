import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'change_provider_state_state.dart';

class ChangeProviderStateCubit extends Cubit<ChangeProviderStateInitial> {
  ChangeProviderStateCubit() : super(ChangeProviderStateInitial.initial());

  Future<void> changeProviderState(BuildContext context,
      {required int id, required bool providerState}) async {
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _changeProviderStateApi(providerState: providerState);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _changeProviderStateApi(
      {required bool providerState}) async {
    final response = await APIService().patchApi(
        url: PathUrl.changeProviderState,
        query: {'Id': state.id, 'isActive': providerState});

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
