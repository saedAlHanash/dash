import 'package:equatable/equatable.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/active_cards.dart';

part 'my_cards_state.dart';

class MyCardsCubit extends MCubit<MyCardsInitial> {
  MyCardsCubit() : super(MyCardsInitial.initial());

  @override
  String get nameCache => 'MyCardsCubit';

  @override
  String get filter => '';

  Future<void> getMyCards({bool newData = false}) async {
    getDataAbstract(
      fromJson: ActiveCard.fromJson,
      state: state,
      newData: newData,
      getDataApi: _getMyCardsApi,
    );

  }

  Future<Pair<List<ActiveCard>?, String?>> _getMyCardsApi() async {
    final response = await APIService(). callApi(
      type: ApiType.get,
      url: GetUrl.allActiveCards,
    );

    if (response.statusCode == 200) {
      return Pair(ActiveCards.fromJson(response.json['result']??{}).items, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
