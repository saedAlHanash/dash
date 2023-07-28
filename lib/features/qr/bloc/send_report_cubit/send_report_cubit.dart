import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/api_manager/api_url.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';

part 'send_report_state.dart';

class SendReportCubit extends Cubit<SendReportInitial> {
  SendReportCubit() : super(SendReportInitial.initial());
  final network = sl<NetworkInfo>();

  Future<void> sendReport(BuildContext context,
      {required List<ReportRequest> request}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _sendReportApi(request: request);

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _sendReportApi(
      {required List<ReportRequest> request}) async {
    var c = request.map((x) => x.toJson()).toList();

    if (await network.isConnected) {
      final response = await APIService().postApi(
        url: request.length == 1 ? PostUrl.postSingleReport : PostUrl.postSingleReport,
        body: (request.length == 1) ? request.first.toJson() : jsonDecode(jsonEncode(c)),
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
/*
POST
api/services/app/InstitutionAttendancesService/AddAtendance

POST
api/services/app/InstitutionAttendancesService/SyncAtendances

GET
api/services/app/InstitutionAttendancesService/GetAll

 */

class ReportRequest {
  ReportRequest({
    required this.result,
  });

  final List<Result> result;

  factory ReportRequest.fromJson(Map<String, dynamic> json) {
    return ReportRequest(
      result: json["result"] == null
          ? []
          : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
      };
}

class Result {
  Result({
    required this.busTripId,
    required this.busMemberId,
    required this.date,
    required this.attendanceType,
  });

  final num busTripId;
  final num busMemberId;
  final DateTime? date;
  final String attendanceType;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      busTripId: json["busTripId"] ?? 0,
      busMemberId: json["busMemberId"] ?? 0,
      date: DateTime.tryParse(json["date"] ?? ""),
      attendanceType: json["attendanceType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "busTripId": busTripId,
        "busMemberId": busMemberId,
        "date": date?.toIso8601String(),
        "attendanceType": attendanceType,
      };
}
