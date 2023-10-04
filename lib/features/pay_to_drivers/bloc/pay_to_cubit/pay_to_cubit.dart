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

part 'pay_to_state.dart';

class PayToCubit extends Cubit<PayToInitial> {
  PayToCubit() : super(PayToInitial.initial());

  Future<void> payTo(BuildContext context, {required SummaryModel request}) async {
    if ((request.payAmount ?? 0) == 0) return;
    if (request.driverId == null) return;
    final r = await NoteMessage.showConfirm(context, text: request.message);
    if (!r) return;

    if (request.type == null) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));

    Pair? pair;

    switch (request.type!) {
      //مطلوب من السائق
      case SummaryPayToEnum.requiredFromDriver:
        //region

        //دفعة بمستحقات السائق من الشركة
        //Company To Driver
        pair = await _payPayToApi(
          driverId: request.driverId!,
          type: TransferPayType.companyToDriver,
          amount: request.cutAmount!,
        );

        //دفعة بمستحقات الشركة من السائق
        //Driver To Company
        if (checkResponse(pair)) {
          pair = await _payPayToApi(
            driverId: request.driverId!,
            type: TransferPayType.driverToCompany,
            amount: request.payAmount! + request.cutAmount!,
          );
        }
        break;
      //endregion

      //مطلوب من الشركة
      case SummaryPayToEnum.requiredFromCompany:
        //region
        //دفعة بمستحقات الشركة من السائق
        //Driver To Company
        pair = await _payPayToApi(
          driverId: request.driverId!,
          type: TransferPayType.driverToCompany,
          amount: request.cutAmount!,
        );
        //دفعة بمستحقات السائق من الشركة
        //Company To Driver
        if (checkResponse(pair)) {
          pair = await _payPayToApi(
            driverId: request.driverId!,
            type: TransferPayType.companyToDriver,
            amount: request.payAmount! + request.cutAmount!,
          );
        }
        break;
      //endregion

      //المبلغ متساوي
      case SummaryPayToEnum.equal:
        //region
        pair = await _payPayToApi(
          driverId: request.driverId!,
          type: TransferPayType.driverToCompany,
          amount: request.cutAmount!,
        );

        if (checkResponse(pair)) {
          pair = await _payPayToApi(
            driverId: request.driverId!,
            type: TransferPayType.companyToDriver,
            amount: request.cutAmount!,
          );
        }
        break;
      //endregion
    }

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  bool checkResponse(Pair<dynamic, dynamic> pair) {
    if (pair.first != null) return true;
    return false;
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
