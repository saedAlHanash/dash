import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/e_pay/data/response/epay_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/caching_service/caching_service.dart';

part 'providers_state.dart';

class ProvidersCubit extends MCubit<ProvidersInitial> {
  ProvidersCubit() : super(ProvidersInitial.initial());

  @override
  String get nameCache => 'providers';

  @override
  String get filter => '';

  Future<void> getProviders() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Provider>?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.providers);

    if (response.success) {
      return Pair(
          ProvidersResponse.fromJson(response.json['result'] ?? {}).items,
          null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result:
            (await getListCached()).map((e) => Provider.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
