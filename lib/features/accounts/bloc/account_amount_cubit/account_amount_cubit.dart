// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:qareeb_dash/core/api_manager/api_url.dart';
// import 'package:qareeb_dash/core/extensions/extensions.dart';
// import 'package:qareeb_models/global.dart';
//
// import '../../../../core/api_manager/api_service.dart';
// import '../../../../core/util/pair_class.dart';
// import '../../data/response/account_amount_response.dart';
//
// part 'account_amount_state.dart';
//
// class AccountAmountCubit extends Cubit<AccountAmountInitial> {
//   AccountAmountCubit() : super(AccountAmountInitial.initial());
//
//   Future<void> getAccountAmount(BuildContext context, {required int driverId}) async {
//     emit(state.copyWith(statuses: CubitStatuses.loading, id: driverId));
//     final pair = await _getAccountAmountApi(driverId: driverId);
//
//     emit(state.copyWith(
//       statuses: CubitStatuses.done,
//       companyAmount: pair.first,
//       driverAmount: pair.second,
//     ));
//   }
//
//   Future<Pair<num?, num?>> _getAccountAmountApi({required int driverId}) async {
//     final response =
//     await APIService().getApi(url: GetUrl.fromDriver, query: {'driverId': driverId});
//
//     final response1 =
//     await APIService().getApi(url: GetUrl.fromCompany, query: {'driverId': driverId});
//
//     if (response.statusCode == 200 && response1.statusCode == 200) {
//       var fromDriver =
//           AccountAmountResponse
//               .fromJson(response.json)
//               .result
//               .data
//               .amount;
//       var fromCompany =
//           AccountAmountResponse
//               .fromJson(response1.json)
//               .result
//               .data
//               .amount;
//       return Pair(fromDriver, fromCompany);
//     } else {
//       return Pair(-1, -1);
//     }
//   }
// }
