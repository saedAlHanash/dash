import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/features/accounts/data/request/re_pay_request.dart';
import 'package:qareeb_dash/features/accounts/data/request/re_pay_request.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/checker_helper.dart';
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
      //مطلوب من الشركة للوكيل
      case SummaryPayToEnum.agency:
        //region

        //دفعة بمستحقات السائق من الشركة
        //Company To Driver
        pair = await _payPayToAgencyApi(
          agencyId: request.agencyId!,
          amount: request.payAmount!,
          note: request.note,
        );

        break;
      //endregion

      //مطلوب من السائق
      case SummaryPayToEnum.requiredFromDriver:
        //region

        //دفعة بمستحقات السائق من الشركة
        //Company To Driver
        pair = await _payPayToApi(
          driverId: request.driverId!,
          type: TransferPayType.companyToDriver,
          amount: request.cutAmount!,
          note: request.note,
        );

        //دفعة بمستحقات الشركة من السائق
        //Driver To Company
        if (checkResponse(pair)) {
          pair = await _payPayToApi(
            driverId: request.driverId!,
            type: TransferPayType.driverToCompany,
            amount: request.payAmount! + request.cutAmount!,
            note: request.note,
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
          note: request.note,
        );
        //دفعة بمستحقات السائق من الشركة
        //Company To Driver
        if (checkResponse(pair)) {
          pair = await _payPayToApi(
            driverId: request.driverId!,
            type: TransferPayType.companyToDriver,
            amount: request.payAmount! + request.cutAmount!,
            note: request.note,
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
          note: request.note,
        );

        if (checkResponse(pair)) {
          pair = await _payPayToApi(
            driverId: request.driverId!,
            type: TransferPayType.companyToDriver,
            amount: request.cutAmount!,
            note: request.note,
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

  Future<void> rePayToClient(
    BuildContext context, {
    required RePayRequest request,
  }) async {
    var p = checkPhoneNumber(context, request.phone ?? '');

    if (p == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: 'رقم هاتف خاطئ', context: context);
      }
      return;
    }
    request.phone = p;

    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _rePayToClientApi(request: request);
    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _rePayToClientApi({required RePayRequest request}) async {
    final response = await APIService().postApi(
      url: PostUrl.createRepay,
      body: request.toJson(),
    );
    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  bool checkResponse(Pair<dynamic, dynamic> pair) {
    if (pair.first != null) return true;
    return false;
  }

  Future<Pair<bool?, String?>> _payPayToApi(
      {required num amount,
      required int driverId,
      required TransferPayType type,
      String? note}) async {
    final response = await APIService().postApi(
      url: type == TransferPayType.companyToDriver
          ? PostUrl.createFromCompany
          : PostUrl.createFromDriver,
      body: {"amount": amount, "driverId": driverId, 'note': note},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<bool?, String?>> _payPayToAgencyApi(
      {required num amount, required int agencyId, String? note}) async {
    final response = await APIService().postApi(
      url: PostUrl.createToAgency,
      body: {"amount": amount, "agencyId": agencyId, 'note': note},
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
