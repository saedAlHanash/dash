import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/active_cards.dart';

part 'active_cards_state.dart';

class ActiveCardsCubit extends MCubit<ActiveCardsInitial> {
  ActiveCardsCubit() : super(ActiveCardsInitial.initial());

  @override
  String get nameCache => 'active_cards';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request?.toString() ?? '';

  Future<void> getActiveCards({bool newData = false}) async {
    await getDataAbstract(
      fromJson: ActiveCard.fromJson,
      state: state,
      getDataApi: _getActiveCards,
      newData: newData,
    );
  }

  Future<Pair<List<ActiveCard>?, String?>> _getActiveCards() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.allActiveCards,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.success) {
      return Pair(ActiveCards.fromJson(response.json['result'] ?? {}).items, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addActiveCard(ActiveCard item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => ActiveCard.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteActiveCardFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => ActiveCard.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
