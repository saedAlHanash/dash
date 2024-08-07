import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/cards_user_response.dart';

part 'cards_state.dart';

class CardsCubit extends MCubit<CardsInitial> {
  CardsCubit() : super(CardsInitial.initial());

  @override
  String get nameCache => 'CardsCubit';

  @override
  String get filter => '';

  Future<void> getCards({bool newData = false}) async {
    getDataAbstract(
      fromJson: UserCard.fromJson,
      state: state,
      newData: newData,
      getDataApi: _getCardsApi,
    );

  }

  Future<Pair<List<UserCard>?, String?>> _getCardsApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.allUserCards,
    );

    if (response.statusCode == 200) {
      return Pair(Cards.fromJson(response.json['result']??{}).items, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
