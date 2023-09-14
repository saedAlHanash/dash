import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/update_profile_request.dart';
import '../../data/response/profile_info_response.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileInitial> {
  UpdateProfileCubit() : super(UpdateProfileInitial.initial());

  final network = sl<NetworkInfo>();

  Future<void> updateProfile(BuildContext context,
      {required UpdateProfileRequest request}) async {
    if (!checkFields(request: request, context: context)) {
      return;
    }
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _updateProfileApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second, context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<ProfileInfoResult?, String?>> _updateProfileApi(
      {required UpdateProfileRequest request}) async {
    if (await network.isConnected) {
      final response = await APIService().uploadMultiPart(
        url: PutUrl.updateProfile,
        type: 'PUT',
        fields: request.toJson(),
        files: [
          UploadFile(fileBytes: await request.file?.readAsBytes(), nameField: 'ImageFile')
        ],
      );

      if (response.statusCode == 200) {
        final data = ProfileInfoResponse.fromJson(jsonDecode(response.body)).result;
        return Pair(data, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }

  bool checkFields(
      {required BuildContext context, required UpdateProfileRequest request}) {
    if (request.name?.isEmpty ?? false) {
      NoteMessage.showErrorSnackBar(
        message: AppStringManager.firstNameEmpty,
        context: context,
      );
      return false;
    }

    if (request.surname?.isEmpty ?? false) {
      NoteMessage.showErrorSnackBar(
          message: AppStringManager.lastNameEmpty, context: context);
      return false;
    }

    return true;
  }
}
