import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../map/bloc/ather_cubit/ather_cubit.dart';

part 'trip_status_state.dart';

class TripStatusCubit extends Cubit<TripStatusInitial> {
  TripStatusCubit() : super(TripStatusInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> changeTripStatus(
    BuildContext context, {
    required int tripId,
    required TripStatus tripStatus,
  }) async {
    final r = await NoteMessage.showConfirm(context, text: 'تأكيد العملية');
    if (!r) return;
    if (tripStatus == TripStatus.non) return;

    emit(state.copyWith(
      statuses: CubitStatuses.loading,
      tripStatus: tripStatus,
      tripId: tripId,
    ));

    final pair = await _changeTripStatusApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _changeTripStatusApi() async {
    if (await network.isConnected) {
      var url = '';
      var body = <String, dynamic>{};

      num? distance;
      switch (state.tripStatus) {
        case TripStatus.non:
          break;

        case TripStatus.reject:
          body['id'] = state.tripId;
          body['cancelReasone'] = '';
          url = PostUrl.rejectTrip;
          break;
        case TripStatus.accept:
          url = PostUrl.acceptTrip;
          break;
        case TripStatus.start:
          url = PostUrl.startTrip;
          break;
        case TripStatus.end:
          try {
            distance = await AtherCubit.getDriverDistance(
              ime: '359632107579978',
              start: AppSharedPreference.getCashedTrip().startDate,
              end: await APIService().getServerTime(),
            );
          } on Exception {
            loggerObject.e('error');
          }
          url = PostUrl.endTrip;
          break;
      }

      final response = await APIService().postApi(
        url: url,
        query: {'id': state.tripId, 'distance': distance},
        body: body,
      );

      if (response.statusCode == 200) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
