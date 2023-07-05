import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/wallet_response.dart';

part 'my_wallet_state.dart';

class MyWalletCubit extends Cubit<MyWalletInitial> {
  MyWalletCubit() : super(MyWalletInitial.initial());

  Future<void> getMyWallet() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await getMyWalletApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  static Future<Pair<MyWalletResult?, String?>> getMyWalletApi() async {
    final network = sl<NetworkInfo>();
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.myWallet,
        query: {'UserId': AppSharedPreference.getMyId},
      );

      if (response.statusCode == 200) {
        var r = Pair(MyWalletResponse.fromJson(response.json).result, null);
        AppSharedPreference.setWalletBalance(r.first.totalMoney);
        return r;
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
