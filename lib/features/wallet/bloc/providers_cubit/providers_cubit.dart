import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/epay_response.dart';

part 'providers_state.dart';

class ProvidersCubit extends Cubit<ProvidersInitial> {
  ProvidersCubit()
      : super(ProvidersInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> getAllEpayProviders(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAllEpayProvidersApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
       emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<EpayItem>?, String?>> _getAllEpayProvidersApi() async {
    if (await network.isConnected) {
      final response = await APIService().getApi(url: GetUrl.getAllEpay);

      if (response.statusCode == 200) {
        return Pair(EpayResponse.fromJson(response.jsonBody).result.items, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
