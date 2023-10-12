import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../wallet/data/summary_model.dart';

part 'reverse_charging_state.dart';

class ReverseChargingCubit extends Cubit<ReverseChargingInitial> {
  ReverseChargingCubit() : super(ReverseChargingInitial.initial());

  Future<void> payTo(BuildContext context, {required String processId}) async {
    if (processId.isEmpty) {
      NoteMessage.showErrorSnackBar(
          message: 'العملية قديمة لا يمكن استرجاعها', context: context);
      return;
    }
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, processId: processId));

    final pair = await _payReverseChargingApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _payReverseChargingApi() async {
    final response = await APIService().postApi(
      url: PostUrl.reverseCharging,
      body: {"processId": state.processId},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
