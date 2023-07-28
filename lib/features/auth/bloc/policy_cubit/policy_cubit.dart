import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_super_user/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/policy_response.dart';

part 'policy_state.dart';

class PolicyCubit extends Cubit<PolicyInitial> {
  PolicyCubit({required this.network}) : super(PolicyInitial.initial());
  final NetworkInfo network;

  Future<void> getPolicy(BuildContext context) async {

    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getPolicyApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<PolicyResult?, String?>> _getPolicyApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(url: GetUrl.getPolicy);

      if (response.statusCode == 200) {
        return Pair(PolicyResponse.fromJson(jsonDecode(response.body)).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
