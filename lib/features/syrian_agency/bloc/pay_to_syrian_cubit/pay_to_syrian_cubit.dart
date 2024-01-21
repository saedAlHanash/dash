import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../wallet/data/summary_model.dart';
import '../../data/request/syrian_pay_request.dart';

part 'pay_to_syrian_state.dart';

class PayToSyrianCubit extends Cubit<PayToSyrianInitial> {
  PayToSyrianCubit() : super(PayToSyrianInitial.initial());

  Future<void> payTo(BuildContext context, {required SyrianPayRequest request}) async {
    final r = await NoteMessage.showConfirm(context,
        text: 'تأكيد الدفع للهيئة المبلغ ${request.amount?.formatPrice ?? ''}');
    if (!r) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _payPayToApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _payPayToApi() async {
    final response = await APIService().postApi(
      url: PostUrl.createFromSyrian,
      body: state.request.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
