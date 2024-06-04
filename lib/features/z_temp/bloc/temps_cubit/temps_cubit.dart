import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/caching_service/caching_service.dart';
import '../../data/response/temp_response.dart';

part 'temps_state.dart';

class TempsCubit extends MCubit<TempsInitial> {
  TempsCubit() : super(TempsInitial.initial());

  @override
  String get nameCache => 'temps';

  @override
  String get filter => state.command?.getKey ?? '';

  Future<void> getTemps() async {
    if (await checkCashed()) return;

    final pair = await _getTemps();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Temp>?, String?>> _getTemps() async {
    final response = await APIService().getApi(
      url: GetUrl.temp,
      query: state.command?.toJson() ?? {},
    );

    if (response.success) {
      return Pair(Temps.fromJson(response.json).items, null);
    } else {
      return response.getPairError;
    }
  }

  void setRequest(Command request) {
    emit(state.copyWith(command: request));
  }

  Future<bool> checkCashed() async {
    try {
      final cacheType = await needGetData();

      emit(
        state.copyWith(
          statuses: cacheType.getState,
          result: (await getListCached()).map((e) => Temp.fromJson(e)).toList(),
        ),
      );

      if (cacheType == NeedUpdateEnum.no) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
}
