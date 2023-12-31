import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'loyalty_state.dart';

class LoyaltyCubit extends Cubit<LoyaltyInitial> {
  LoyaltyCubit() : super(LoyaltyInitial.initial());

  Future<void> changeLoyalty(BuildContext context,
      {required int driverId, bool? loyalState, bool? gas}) async {
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;
    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      id: driverId,
      loyalty: loyalState,
      isGasIncluded: gas,
    ));
    final pair = await _changeLoyaltyApi(
      driverId: driverId,
      loyalState: loyalState,
      gas: gas,
    );

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  static Future<Pair<bool?, String?>> _changeLoyaltyApi(
      {required int driverId, bool? loyalState, bool? gas}) async {
    final response = await APIService().patchApi(
      url: PatchUrl.changeLoyalty,
      body: {
        "driverId": driverId,
        "subscribed": loyalState,
        "includeGas": gas,
      },
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
