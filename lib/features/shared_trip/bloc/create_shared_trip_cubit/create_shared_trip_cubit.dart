import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/shared_trip/data/response/shared_trip.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/create_shared_request.dart';

part 'create_shared_trip_state.dart';

class CreateSharedTripCubit extends Cubit<CreateSharedTripInitial> {
  CreateSharedTripCubit() : super(CreateSharedTripInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> createSharesTrip(
    BuildContext context, {
    required RequestCreateShared request,
  }) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));

    final pair = await _createSharesTripApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<SharedTrip?, String?>> _createSharesTripApi() async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: PostUrl.createSharedTrip,
        body: state.request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(SharedTripResponse.fromJson(jsonDecode(response.body)).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

}
