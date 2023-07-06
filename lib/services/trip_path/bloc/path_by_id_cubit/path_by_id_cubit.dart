import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/services/trip_path/data/models/trip_path.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'path_by_id_state.dart';

class PathByIdCubit extends Cubit<PathByIdInitial> {
  PathByIdCubit() : super(PathByIdInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> getPathById(BuildContext context, {required num id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: id));

    final pair = await _getPathByIdApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<TripPath?, String?>> _getPathByIdApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: GetUrl.getPathById,
        query: {'pathId': state.id},
      );

      if (response.statusCode == 200) {
        return Pair(TripPath.fromJson(response.jsonBody['result'] ?? {}), null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
