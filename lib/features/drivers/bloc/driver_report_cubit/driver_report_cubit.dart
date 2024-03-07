import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/accounts/data/request/charging_request.dart';
import 'package:qareeb_dash/features/accounts/data/request/transfer_filter_request.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';
import 'package:qareeb_models/wallet/data/response/debt_response.dart';
import 'package:qareeb_models/wallet/data/response/driver_financial_response.dart';
import 'package:qareeb_models/wallet/data/response/wallet_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/pair_class.dart';
import '../../../accounts/bloc/all_charging_cubit/all_charging_cubit.dart';
import '../../../accounts/data/response/transfers_response.dart';

part 'driver_report_state.dart';

class DriverReportCubit extends Cubit<DriverReportInitial> {
  DriverReportCubit() : super(DriverReportInitial.initial());

  Future<void> getAll(DriverModel driver) async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    var excel = Excel.createExcel();

    final p = await _getAllChargingApi(driver);
    if (p.first != null) {
      final data = _getXlsData(p.first!.items);
      await saveSheet(
        header: data.first,
        data: data.second,
        sheetName: 'الشحنات',
        excel: excel,
      );
    }
    // final p1 = await _getDriverFinancialApi(driver);
    // if (p1.first != null) {
    //   final data = _getXlsData1(p1.first!);
    //   await saveSheet(
    //     header: data.first,
    //     data: data.second,
    //     sheetName: 'التقرير',
    //     excel: excel,
    //   );
    // }
    final p2 = await _getDebtsApi(driver);
    if (p2.first != null) {
      final data = _getXlsData2(p2.first!.items);
      await saveSheet(
        header: data.first,
        data: data.second,
        sheetName: 'العائدات',
        excel: excel,
      );
    }
    final p3 = await _getAllTransfersApi(driver);
    if (p3.first != null) {
      final data = _getXlsData3(p3.first!.items);
      await saveSheet(
        header: data.first,
        data: data.second,
        sheetName: 'التحويلات',
        excel: excel,
      );
    }

    excel.delete('Sheet1');
    List<int>? fileBytes = excel.save(fileName: 'تقرير السائق ${driver.fullName}.xlsx');

    saveFile(fileBytes: fileBytes);

    emit(state.copyWith(statuses: CubitStatuses.done));
  }

  Future<Pair<ChargingResult?, String?>> _getAllChargingApi(DriverModel driver) async {
    final response = await APIService().getApi(
      url: GetUrl.getAllCharging,
      query: ChargingRequest(
        chargerPhone: driver.phoneNumber,
      ).toJson(),
    );

    if (response.statusCode == 200) {
      return Pair(ChargingResult.fromJson(response.json['result'] ?? {}), null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<DriverFinancialResult?, String?>> _getDriverFinancialApi(
      DriverModel driver) async {
    final response = await APIService().getApi(
      url: GetUrl.driverFinancialReport,
      query: {
        'driverId': driver.id,
        'maxResultCount': 1.maxInt,
      },
    );
    if (response.statusCode == 200) {
      return Pair(DriverFinancialResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<DebtsResult?, String?>> _getDebtsApi(DriverModel driver) async {
    final response = await APIService().getApi(
      url: GetUrl.debt,
      query: {
        'driverId': driver.id,
        'maxResultCount': 1.maxInt,
      },
    );

    if (response.statusCode == 200) {
      return Pair(DebtsResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Future<Pair<TransfersResult?, String?>> _getAllTransfersApi(DriverModel driver) async {
    final response = await APIService().getApi(
      url: GetUrl.getAllTransfers,
      query: TransferFilterRequest(
        userId: driver.id,
      ).toMap()
        ..addAll(
          {
            'maxResultCount': 1.maxInt,
          },
        ),
    );

    if (response.statusCode == 200) {
      return Pair(TransfersResponse.fromJson(response.json).result, null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Charging> data) {
    return Pair(
        [
          '\tالمرسل\t',
          '\tالمستقبل\t',
          '\tالقيمة\t',
          '\tالحالة\t',
          '\tالتاريخ\t',
        ],
        data
            .mapIndexed(
              (i, e) => [
                e.chargerName.isEmpty ? e.providerName : e.chargerName,
                e.userName,
                e.amount == 0 ? 'عملية استرجاع' : e.amount.formatPrice,
                e.status.arabicName,
                e.date?.formatDate,
              ],
            )
            .toList());
  }

  // Pair<List<String>, List<List<dynamic>>> _getXlsData1(DriverFinancialResult data) {
  //   return Pair(
  //     [
  //       '\t رصيد السائق لدى الشركة\t',
  //       '\t رصيد الشركة لدى السائق\t',
  //       '\t ${data.getMessage}\t',
  //     ],
  //     [
  //       [
  //         data.requiredAmountFromCompany.formatPrice,
  //         data.requiredAmountFromDriver.formatPrice,
  //         data.price.formatPrice,
  //       ]
  //     ],
  //   );
  // }

  Pair<List<String>, List<List<dynamic>>> _getXlsData2(List<Debt> data) {
    return Pair(
        [
          '\t id \t',
          '\t حصة السائق \t',
          '\t الكلي \t',

          '\t قيمة الحسم \t',
          '\t تاريخ \t',
          '\t زيت \t',
          '\t مليون \t',
          '\t إطارات \t',
          '\t بنزين \t',
          // '\t حصة الوكيل \t',
          // '\t حصة الهيئة \t',
          '\t تعويض\t',
          '\t مصدر العائد\t',
          '\t نوع \t',
        ],
        data
            .mapIndexed(
              (index, e) => [
                e.id,
                e.driverShare.formatPrice,
                e.totalCost.formatPrice,
                e.discountAmount.formatPrice,
                e.date?.toIso8601String() ?? '',
                e.oilShare.formatPrice,
                e.goldShare.formatPrice,
                e.tiresShare.formatPrice,
                e.gasShare.formatPrice,
                // e.agencyShare.formatPrice,
                // e.syrianAuthorityShare.formatPrice,
                e.driverCompensation.formatPrice,
                e.sharedRequestId != 0 ? ' مقعد برحلة تشاركية' : ' عادية ',
                e.type.arabicName,
              ],
            )
            .toList());
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData3(List<Transfer> data) {
    return Pair(
        [
          '\tمعرف العملية\t',
          '\tنوع العملية\t',
          '\tالمرسل\t',
          '\tالمستقبل\t',
          '\tالمبلغ\t',
          '\tالحالة\t',
          '\tتاريخ العملية\t',
          '\t ملاحظات \t',
        ],
        data
            .mapIndexed(
              (index, e) => [
                e.id,
                e.type?.arabicName,
                e.sourceName,
                e.destinationName,
                e.amount.formatPrice,
                e.status == TransferStatus.closed ? true : false,
                e.transferDate?.toIso8601String(),
                e.note,
              ],
            )
            .toList());
  }
}
