import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/api_manager/api_url.dart';
import 'package:qareeb_super_user/core/extensions/extensions.dart';
import 'package:qareeb_super_user/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/service/members_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/response/member_response.dart';
import '../../data/response/super_users_response.dart';

part 'all_super_users_state.dart';

class AllSuperUsersCubit extends Cubit<AllSuperUsersInitial> {
  AllSuperUsersCubit() : super(AllSuperUsersInitial.initial());

  Future<void> getSuperUsers(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getSuperUsersApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      sl<UsersService>().addMembers(pair.first!.items);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<MembersResult?, String?>> _getSuperUsersApi() async {
    final response = await APIService().getApi(
      url: GetUrl.superUsers,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(MembersResponse.fromJson(response.jsonBody).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  void update() {
    emit(state.copyWith());
  }
}
