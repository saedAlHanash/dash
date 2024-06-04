import 'dart:convert';

import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../features/accounts/data/request/charging_request.dart';
import '../../features/accounts/data/request/transfer_filter_request.dart';
import '../../features/companies/data/request/companies_filter_request.dart';
import '../../features/drivers/data/request/drivers_filter_request.dart';
import '../../features/pay_to_drivers/data/request/financial_filter_request.dart';
import '../../features/plan_trips/data/request/plan_attendances_filter.dart';
import '../../features/syrian_agency/data/request/syrian_filter_request.dart';
import '../../features/trip/data/request/filter_trip_request.dart';
import 'package:crypto/crypto.dart';

class Command {
  Command({
    this.skipCount,
    this.totalCount,
    this.chargingRequest,
    this.driversFilterRequest,
    this.financialFilterRequest,
    this.syrianFilterRequest,
    this.filterTripRequest,
    this.transferFilterRequest,
    this.companiesFilterRequest,
    this.planAttendanceFilter,
    this.filter,
  });

  int? skipCount;
  int maxResultCount = 20;
  int? totalCount;
  Map<String, dynamic>? filter;
  ChargingRequest? chargingRequest;
  DriversFilterRequest? driversFilterRequest;
  FinancialFilterRequest? financialFilterRequest;
  SyrianFilterRequest? syrianFilterRequest;
  FilterTripRequest? filterTripRequest;
  TransferFilterRequest? transferFilterRequest;
  CompaniesFilterRequest? companiesFilterRequest;
  PlanAttendanceFilter? planAttendanceFilter;

  int get maxPages => ((totalCount ?? 0) / maxResultCount).myRound;

  int get currentPage => (((skipCount ?? 0) + 1) / maxResultCount).myRound;

  List<SpinnerItem> get getSpinnerItems {
    final list = <SpinnerItem>[];
    for (var i = 1; i <= maxPages; i++) {
      list.add(SpinnerItem(
        id: i,
        name: i.toString(),
        isSelected: i == currentPage,
        enable: i != currentPage,
      ));
    }
    return list;
  }

  void goToPage(int pageIndex) {
    skipCount = (pageIndex - 1) * maxResultCount;
  }

  factory Command.initial() {
    return Command(
      skipCount: 0,
      totalCount: 0,
    );
  }

  bool get isInitial => skipCount == 0;

  factory Command.noPagination() {
    return Command(skipCount: 0)..maxResultCount = 1.0.maxInt;
  }

  set setFilter(Map<String, dynamic> filter) => this.filter = filter;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
      if (AppSharedPreference.getAgencyId != 0)
        'AgencyId': AppSharedPreference.getAgencyId,
    };
    if (filter != null) json.addAll(filter!);

    if (filterTripRequest != null) {
      json.addAll(filterTripRequest!.toMap());
    }
    if (transferFilterRequest != null) {
      json.addAll(transferFilterRequest!.toMap());
    }

    if (chargingRequest != null) {
      json.addAll(chargingRequest!.toJson());
    }

    if (driversFilterRequest != null) {
      json.addAll(driversFilterRequest!.toJson());
    }
    if (financialFilterRequest != null) {
      json.addAll(financialFilterRequest!.toJson());
    }

    if (syrianFilterRequest != null) {
      json.addAll(syrianFilterRequest!.toMap());
    }

    if (companiesFilterRequest != null) {
      json.addAll(companiesFilterRequest!.toJson());
    }
    if (planAttendanceFilter != null) {
      json.addAll(planAttendanceFilter!.toJson());
    }

    return json;
  }

  factory Command.fromJson(Map<String, dynamic> map) {
    return Command(
      skipCount: map['skipCount'] ?? 0,
    );
  }

  String get getKey {
    var jsonString = jsonEncode(this);
    var bytes = utf8.encode(jsonString);
    var digest = sha1.convert(bytes);

    return '$digest';
  }

  Command copyWith({
    int? skipCount,
    int? totalCount,
    FilterTripRequest? filterTripRequest,
    ChargingRequest? chargingRequest,
    DriversFilterRequest? driversFilterRequest,
    FinancialFilterRequest? financialFilterRequest,
    SyrianFilterRequest? syrianFilterRequest,
    TransferFilterRequest? transferFilterRequest,
    CompaniesFilterRequest? companiesFilterRequest,
    PlanAttendanceFilter? planAttendanceFilter,
  }) {
    return Command(
      skipCount: skipCount ?? this.skipCount,
      totalCount: totalCount ?? this.totalCount,
      filterTripRequest: filterTripRequest ?? this.filterTripRequest,
      chargingRequest: chargingRequest ?? this.chargingRequest,
      driversFilterRequest: driversFilterRequest ?? this.driversFilterRequest,
      financialFilterRequest:
          financialFilterRequest ?? this.financialFilterRequest,
      syrianFilterRequest: syrianFilterRequest ?? this.syrianFilterRequest,
      transferFilterRequest:
          transferFilterRequest ?? this.transferFilterRequest,
      companiesFilterRequest:
          companiesFilterRequest ?? this.companiesFilterRequest,
      planAttendanceFilter: planAttendanceFilter ?? this.planAttendanceFilter,
    );
  }
}
