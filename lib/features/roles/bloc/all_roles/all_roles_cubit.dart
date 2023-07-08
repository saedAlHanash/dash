import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/roles_response.dart';

part 'all_roles_state.dart';

class AllRolesCubit extends Cubit<AllRolesInitial> {
  AllRolesCubit() : super(AllRolesInitial.initial());

  Future<void> getAllRoles(BuildContext context) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _getAllRolesApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Role>?, String?>> _getAllRolesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.allRoles,
    );

    if (response.statusCode == 200) {
      return Pair(RolesResponse.fromJson(response.jsonBody).result.items, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }
}
