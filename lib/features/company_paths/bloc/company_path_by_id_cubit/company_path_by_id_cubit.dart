import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/company_paths/data/response/company_paths_response.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'company_path_by_id_state.dart';

class CompanyPathBuIdCubit extends Cubit<CompanyPathBuIdInitial> {
  CompanyPathBuIdCubit() : super(CompanyPathBuIdInitial.initial());

  Future<void> getCompanyPathBuId(BuildContext context, {required int id}) async {
    if(id==0)return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getCompanyPathBuIdApi(id:id);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<CompanyPath?, String?>> _getCompanyPathBuIdApi({required int id}) async {
    final response = await APIService().getApi(
      url: GetUrl.companyPathById,
      query: {'Id':id}

    );

    if (response.statusCode == 200) {
      return Pair(CompanyPath.fromJson(response.json['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
