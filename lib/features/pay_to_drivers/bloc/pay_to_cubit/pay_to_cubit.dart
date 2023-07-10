import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'pay_to_state.dart';

class PayToCubit extends Cubit<PayToInitial> {
  PayToCubit() : super(PayToInitial.initial());

  Future<void> payPayTo(BuildContext context,
      {required num amount, required int driverId, required TransferPayType type}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _payPayToApi(amount: amount, driverId: driverId, type: type);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _payPayToApi(
      {required num amount, required int driverId, required TransferPayType type}) async {
    final response = await APIService().postApi(
      url: type == TransferPayType.companyToDriver
          ? PostUrl.createFromCompany
          : PostUrl.createFromDriver,
      body: {"amount": amount, "driverId": driverId},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
