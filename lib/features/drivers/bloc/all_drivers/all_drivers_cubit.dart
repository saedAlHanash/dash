import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';

part 'all_drivers_state.dart';

class AllDriversCubit extends Cubit<AllDriversInitial> {
  AllDriversCubit() : super(AllDriversInitial.initial());

  Future<void> getAllDrivers(BuildContext context, {Command? command}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, command: command));
    final pair = await _getAllDriversApi();

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

  Future<Pair<DriversResult?, String?>> _getAllDriversApi() async {
    final response = await APIService().getApi(
      url: GetUrl.allDrivers,
      query: state.command.toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(DriversResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<List<String>, List<List<dynamic>>>?> getDriversAsync(
      BuildContext context) async {
    var oldSkipCount = state.command.skipCount;
    state.command
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getAllDriversApi();
    state.command
      ..maxResultCount = 20
      ..skipCount = oldSkipCount;
    if (pair.first == null) {
      if (context.mounted) {
        NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
      }
    } else {
      return _getXlsData(pair.first!.items);
    }
    return null;
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<DriverModel> data) {
    return Pair(
        [
          '\t ID \t',
          '\t الاسم الكامل \t',
          '\t تاريخ الميلاد \t',
          '\t العنوان \t',
          '\t رقم الهاتف \t',
          '\t تصنيف السيارة \t',
          '\t عدد مقاعد السيارة \t',
          '\t ماركة السيارة \t',
          '\t لون السيارة \t',
          '\t حالة فحص السيارة\t',
          '\t حالة الزبون \t',
          if (isQareebAdmin) ...[
            '\t اشتراك الولاء \t',
            '\t اشتراك البنزين\t',
            '\t OTP \t',
          ],
          '\t محافظة السيارة \t',
          '\t سنة صنع السيارة \t',
          '\t التصنيف الحكومي \t',
          '\t تاريخ الاشتراك \t',
          '\t معرف جهاز التتبع IMEI \t',
          '\t الجنس \t',
          '\t ملاحظات \t',
        ],
        data
            .mapIndexed(
              (index, element) => [
                element.id,
                element.fullName,
                element.birthdate?.formatDate,
                element.address,
                element.phoneNumber,
                element.carCategories.name,
                element.carType.seatsNumber,
                element.carType.carBrand,
                element.carType.carColor,
                element.isExamined,
                element.isActive,
                if (isQareebAdmin) ...[
                  element.loyalty,
                  element.isGasIncluded,
                  element.emailConfirmationCode,
                ],
                element.carType.carGovernorate,
                element.carType.manufacturingYear,
                element.carType.type,
                element.creationTime?.formatDate,
                element.qarebDeviceimei,
                element.gender == 0 ? 'M' : 'F',
                '',
              ],
            )
            .toList());
  }

  void update() {
    emit(state.copyWith());
  }
}
