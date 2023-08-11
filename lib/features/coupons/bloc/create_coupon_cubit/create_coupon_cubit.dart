import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

import '../../data/request/create_coupons_request.dart';

part 'create_coupon_state.dart';

class CreateCouponCubit extends Cubit<CreateCouponInitial> {
  CreateCouponCubit() : super(CreateCouponInitial.initial());

  Future<void> createCoupon(
    BuildContext context, {
    required CreateCouponRequest request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _createCouponApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _createCouponApi(
      {required CreateCouponRequest request}) async {
    late Response response;

    if (request.id != null) {
      response = await APIService().puttApi(
        url: PutUrl.updateCoupon,
        body: request.toJson(),
      );
    } else {
      response = await APIService().postApi(
        url: PostUrl.createCoupon,
        body: request.toJson(),
      );
    }

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
