import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/policy_response.dart';

part 'create_policy_state.dart';

class CreatePolicyCubit extends Cubit<CreatePolicyInitial> {
  CreatePolicyCubit({required this.network}) : super(CreatePolicyInitial.initial());
  final NetworkInfo network;

  Future<void> createPolicy(BuildContext context, {required String policy}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _createPolicyApi(policy: policy);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<PolicyResult?, String?>> _createPolicyApi({required String policy}) async {
    if (await network.isConnected) {
      final response = await APIService().puttApi(
        url: PostUrl.createPolicy,
        body: {"policy": policy},
      );

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
