import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/shared_trip.dart';

part 'shared_trip_by_id_state.dart';

class SharedTripByIdCubit extends Cubit<SharedTripByIdInitial> {
  SharedTripByIdCubit() : super(SharedTripByIdInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> getSharedTripById(BuildContext context, {required int id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));

    final pair = await _getSharedTripByIdApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<SharedTrip?, String?>> _getSharedTripByIdApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getSharedTripById,
        query: {'Id': state.id},
      );

      if (response.statusCode == 200) {
        return Pair(SharedTripResponse.fromJson(response.json).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
