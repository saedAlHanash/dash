import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';


import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/search_location_response.dart';


part 'search_location_state.dart';

class SearchLocationCubit extends Cubit<SearchLocationInitial> {
  SearchLocationCubit() : super(SearchLocationInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> searchLocation({required String request}) async {
    if (request.isEmpty ||
        request.length < 3 ||
        request.removeSpace == state.request.removeSpace) {
      emit(state.copyWith(statuses: CubitStatuses.done, result: []));
      return;
    }
    request = 'دمشق $request'.removeDuplicates;

    emit(state.copyWith(statuses: CubitStatuses.loading, request: request));
    final pair = await _searchLocationApi();

    if (pair.first != null) {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: []));
    }
  }

  Future<Pair<List<SearchLocationResult>?, String?>> _searchLocationApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(
        url: 'search.php',
        hostName: 'nominatim.openstreetmap.org',
        query: {
          'q': state.request,
          'dedupe': 0,
          // 'accept-language': 'ar',
          // 'countrycodes': 'sy',
          'format': 'jsonv2'
        },
      );

      if (response.statusCode == 200) {
        return Pair(SearchLocationResponse.fromJson(response.jsonBody).result, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
