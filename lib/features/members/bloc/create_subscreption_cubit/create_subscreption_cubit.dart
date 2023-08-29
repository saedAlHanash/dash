import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_subcription_request.dart';

part 'create_subscription_state.dart';

class CreateSubscriptionCubit1 extends Cubit<CreateSubscriptionInitial1> {
  CreateSubscriptionCubit1() : super(CreateSubscriptionInitial1.initial());

  Future<void> createSubscription(BuildContext context,
      {required CreateSubscriptionRequest request}) async {
    if (!request.isActive) {
      final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
      if (!r) return;
    }
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _createSubscriptionApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createSubscriptionApi() async {
    late Response response;

    if (state.request.id != null) {
      response = await APIService().puttApi(
        url: PutUrl.updateSubscription1,
        body: state.request.toJson(),
      );
    } else {
      state.request.isActive = true;
      response = await APIService().postApi(
        url: PostUrl.createSubscription1,
        body: state.request.toJson(),
      );
    }

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
