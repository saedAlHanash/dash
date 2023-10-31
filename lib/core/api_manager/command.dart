import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../features/accounts/data/request/transfer_filter_request.dart';
import '../../features/clients/data/request/clients_filter_request.dart';
import '../../features/drivers/data/request/drivers_filter_request.dart';
import '../../features/pay_to_drivers/data/request/financial_filter_request.dart';
import '../../features/trip/data/request/filter_trip_request.dart';

class Command {


  Command({
    this.skipCount,
    this.totalCount,
    this.clientsFilterRequest,
    this.driversFilterRequest,
    this.financialFilterRequest,
    this.filterTripRequest,
    this.transferFilterRequest,
  });

  int? skipCount;
  int maxResultCount = 20;
  int? totalCount;
  ClientsFilterRequest? clientsFilterRequest;
  DriversFilterRequest? driversFilterRequest;
  FinancialFilterRequest? financialFilterRequest;
  FilterTripRequest? filterTripRequest;

  TransferFilterRequest? transferFilterRequest;

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

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
      if (AppSharedPreference.getAgencyId != 0)
        'AgencyId': AppSharedPreference.getAgencyId,
    };

    if (filterTripRequest != null) {
      json.addAll(filterTripRequest!.toMap());
    }
    if (transferFilterRequest != null) {
      json.addAll(transferFilterRequest!.toMap());
    }

    if (clientsFilterRequest != null) {
      json.addAll(clientsFilterRequest!.toJson());
    }

    if (driversFilterRequest != null) {
      json.addAll(driversFilterRequest!.toJson());
    }
    if (financialFilterRequest != null) {
      json.addAll(financialFilterRequest!.toJson());
    }

    return json;
  }

  factory Command.fromJson(Map<String, dynamic> map) {
    return Command(
      skipCount: map['skipCount'] as int,
    );
  }

  Command copyWith({
    int? skipCount,
    int? totalCount,
    FilterTripRequest? filterTripRequest,
    ClientsFilterRequest? clientsFilterRequest,
    DriversFilterRequest? driversFilterRequest,
    FinancialFilterRequest? financialFilterRequest,
    TransferFilterRequest? transferFilterRequest,
  }) {
    return Command(
      skipCount: skipCount ?? this.skipCount,
      totalCount: totalCount ?? this.totalCount,
      filterTripRequest: filterTripRequest ?? this.filterTripRequest,
      clientsFilterRequest: clientsFilterRequest ?? this.clientsFilterRequest,
      driversFilterRequest: driversFilterRequest ?? this.driversFilterRequest,
      financialFilterRequest: financialFilterRequest ?? this.financialFilterRequest,
      transferFilterRequest: transferFilterRequest ?? this.transferFilterRequest,
    );
  }
}
