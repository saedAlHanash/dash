import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'change_coupon_state_state.dart';

class ChangeCouponStateCubit extends Cubit<ChangeCouponStateInitial> {
  ChangeCouponStateCubit() : super(ChangeCouponStateInitial.initial());

  Future<void> changeCouponState(BuildContext context,
      {required int id}) async {
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));
    final pair = await _changeCouponStateApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _changeCouponStateApi() async {
    final response = await APIService().patchApi(
        url: PatchUrl.changeCouponState,
        query: {'Id': state.id});

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
