import 'package:bloc/bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/direct_pay_request.dart';

part 'direct_pay_state.dart';

class DirectPayCubit extends Cubit<DirectPayInitial> {
  DirectPayCubit() : super(DirectPayInitial.initial());

  Future<void> directPay({required DirectPayRequest request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _getDataApi() async {
    final response =
        await APIService().postApi(url: PostUrl.directPay, body: state.request.toJson());

    if (response.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
