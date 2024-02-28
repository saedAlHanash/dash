import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/wallet/data/response/debt_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'trip_debit_state.dart';

class TripDebitCubit extends Cubit<TripDebitInitial> {
  TripDebitCubit() : super(TripDebitInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> tripDebit(BuildContext context, {required int tripId}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await tripDebitApi(tripId: tripId);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  static Future<Pair<Debt?, String?>> tripDebitApi({required tripId}) async {
    if (tripId == 0) return Pair(null, 'no result with ID:0');
    final response =
        await APIService().getApi(url: GetUrl.tripDebit, query: {'tripId': tripId});

    if (response.statusCode == 200) {
      final trip = Debt.fromJson(jsonDecode(response.body)['result'] ?? {});
      return Pair(trip, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
//{
//   "id": 0,
//   "driverShare": 0,
//   "totalCost": 0,
//   "costAfterDiscount": 0,
//   "discountAmount": 0,
//   "sharedRequestId": 0,
//   "tripId": 0,
//   "driverId": 0,
//   "date": "2024-02-11T08:07:54.142Z",
//   "oilShare": 0,
//   "goldShare": 0,
//   "tiresShare": 0,
//   "gasShare": 0,
//   "agencyShare": 0,
//   "syrianAuthorityShare": 0,
//   "driverCompensation": 0,
//   "type": "TripPayment"
// }