import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/api_manager/api_url.dart';
import 'package:qareeb_super_user/core/util/shared_preferences.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/service/report_request_service.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/request/report_request.dart';

part 'send_report_state.dart';

class SendReportCubit extends Cubit<SendReportInitial> {
  SendReportCubit() : super(SendReportInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> sendReport(BuildContext context) async {
    final request = sl<RequestsService>().getReportRequests();
    if (request.isEmpty) return;

    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _sendReportApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      sl<RequestsService>().clear();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _sendReportApi(
      {required List<ReportRequest> request}) async {
    var c = request.map((x) => x.toJson()).toList();

    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: request.length == 1 ? PostUrl.postSingleReport : PostUrl.postListReport,
        body: (request.length == 1) ? request.first.toJson() : {'asList': c},
      );

      if (response.statusCode == 200) {
        return Pair(true, null);
      } else {
        return Pair(null, ErrorManager.getApiError(response));
      }
    } else {
      return Pair(null, AppStringManager.noInternet);
    }
  }
}
