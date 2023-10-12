import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/temp_trips/data/estimate_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/estimate_request.dart';

part 'estimate_state.dart';

class EstimateCubit extends Cubit<EstimateInitial> {
  EstimateCubit() : super(EstimateInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> getEstimate(BuildContext context,
      {required EstimateRequest request}) async {

    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _getEstimateApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showErrorSnackBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Estimate>?, String?>> _getEstimateApi() async {
    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: PostUrl.estimateSharedTrip,
        body: state.request.toJson(),
      );

      if (response.statusCode == 200) {
        return Pair(EstimateResponse.fromJson(response.json).result,
          null,
        );
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
