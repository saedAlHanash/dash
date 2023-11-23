import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/plans_response.dart';

part 'plans_state.dart';

class AllPlansCubit extends Cubit<AllPlansInitial> {
  AllPlansCubit() : super(AllPlansInitial.initial());

  Future<void> getPlans(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getPlansApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<PlansResult?, String?>> _getPlansApi() async {
    final response = await APIService().getApi(
      url: GetUrl.plans,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(PlansResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
