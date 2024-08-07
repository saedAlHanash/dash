import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/temp_response.dart';

part 'temps_state.dart';

class TempsCubit extends MCubit<TempsInitial> {
  TempsCubit() : super(TempsInitial.initial());

  @override
  String get nameCache => 'temps';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request?.toString() ?? '';

  Future<void> getTemps({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Temp.fromJson,
      state: state,
      getDataApi: _getTemps,
      newData: newData,
    );
  }

  Future<Pair<List<Temp>?, String?>> _getTemps() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.temps,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.success) {
      return Pair(Temps.fromJson(response.json).items, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addTemp(Temp item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Temp.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteTempFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Temp.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
