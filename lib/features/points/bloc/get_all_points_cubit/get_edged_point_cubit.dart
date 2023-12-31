import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'get_edged_point_state.dart';

class EdgesPointCubit extends Cubit<EdgesPointInitial> {
  EdgesPointCubit() : super(EdgesPointInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> getAllEdgesPoint(BuildContext context, {required int? id}) async {
    if (id == null || id == 0) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAllEdgesPointApi(id: id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!));
    }
  }

  Future<Pair<List<Edge>?, String?>> _getAllEdgesPointApi(
      {required int id}) async {
    if (await network.isConnected) {
      final response = await APIService()
          .getApi(url: GetUrl.getAllEdgesPoint, query: {'sourcePointId': id});

      if (response.statusCode == 200) {
        final json = response.json;
        return Pair(
            json['result'] == null
                ? <Edge>[]
                : List<Edge>.from(
                    json['result'].map((e) => Edge.fromJson(e))),
            null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
