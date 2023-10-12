
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/agency_response.dart';

part 'agencies_state.dart';

class AgenciesCubit extends Cubit<AgenciesInitial> {
  AgenciesCubit() : super(AgenciesInitial.initial());

  Future<void> getAgencies(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getAgenciesApi();

    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      state.command.totalCount = pair.first!.totalCount;
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first!.items));
    }
  }

  Future<Pair<AgenciesResult?, String?>> _getAgenciesApi() async {
    final response = await APIService().getApi(
      url: GetUrl.agencies,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(AgenciesResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  // Future<Pair<List<String>, List<List<dynamic>>>?> getAgenciesAsync(
  //     BuildContext context) async {
  //   var oldSkipCount = state.command.skipCount;
  //   state.command
  //     ..maxResultCount = 1.maxInt
  //     ..skipCount = 0;
  //
  //   final pair = await _getAgenciesApi();
  //   state.command
  //     ..maxResultCount = 20
  //     ..skipCount = oldSkipCount;
  //   if (pair.first == null) {
  //     if (context.mounted) {
  //       NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
  //     }
  //   } else {
  //     return _getXlsData(pair.first!.items);
  //   }
  //   return null;
  // }

  // Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Agency> data) {
  //   return Pair(
  //       [
  //         '\t ID \t',
  //         '\t الاسم الكامل \t',
  //         '\t تاريخ الميلاد \t',
  //         '\t العنوان \t',
  //         '\t رقم الهاتف \t',
  //         '\t تصنيف السيارة \t',
  //         '\t عدد مقاعد السيارة \t',
  //         '\t ماركة السيارة \t',
  //         '\t لون السيارة \t',
  //         '\t حالة الزبون \t',
  //         '\t اشتراك الولاء \t',
  //         '\t OTP \t',
  //         '\t محافظة السيارة \t',
  //         '\t سنة صنع السيارة \t',
  //         '\t التصنيف الحكومي \t',
  //         '\t تاريخ الاشتراك \t',
  //         '\t معرف جهاز التتبع IMEI \t',
  //         '\t الجنس \t',
  //         '\t ملاحظات \t',
  //       ],
  //       data
  //           .mapIndexed(
  //             (index, element) => [
  //               element.id,
  //               element.fullName,
  //               element.birthdate?.formatDate,
  //               element.address,
  //               element.phoneNumber,
  //               element.carCategories.name,
  //               element.carType.seatsNumber,
  //               element.carType.carBrand,
  //               element.carType.carColor,
  //               element.isActive,
  //               element.loyalty,
  //               element.emailConfirmationCode,
  //               element.carType.carGovernorate,
  //               element.carType.manufacturingYear,
  //               element.carType.type,
  //               element.creationTime?.formatDate,
  //               element.qarebDeviceimei,
  //               element.gender == 0 ? 'M' : 'F',
  //               '',
  //             ],
  //           )
  //           .toList());
  // }

  void update() {
    emit(state.copyWith());
  }
}
