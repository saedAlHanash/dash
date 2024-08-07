import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'delete_temp_state.dart';

class DeleteTempCubit extends Cubit<DeleteTempInitial> {
  DeleteTempCubit() : super(DeleteTempInitial.initial());

  Future<void> deleteTemp({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, request: id));

    final pair = await _deleteTempApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _deleteTempApi() async {
    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteTemp,
      query: {'id': state.request},
    );

    if (response.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
