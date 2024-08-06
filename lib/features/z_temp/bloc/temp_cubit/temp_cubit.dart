import 'package:qareeb_dash/core/strings/enum_manager.dart'; import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart'; import 'package:qareeb_dash/core/strings/enum_manager.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/caching_service/caching_service.dart';
import '../../data/response/temp_response.dart';

part 'temp_state.dart';

class TempCubit extends MCubit<TempInitial> {
  TempCubit() : super(TempInitial.initial());

  @override
  String get nameCache => 'temp';

  @override
  String get filter => state.tempId ?? '';

  Future<void> getTemp({required String tempId}) async {
    emit(state.copyWith(tempId: tempId));
    if (await checkCashed()) return;

    final pair = await _getTemp();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Temp?, String?>> _getTemp() async {
    final response = await APIService().callApi(type: ApiType.get,
      url: GetUrl.temp,
      query: {'Id': state.tempId},
    );

    if (response.success) {
      return Pair(Temp.fromJson(response.json), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
        try {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: Temp.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
        } catch (e) {
      return false;
    }
  }
}
