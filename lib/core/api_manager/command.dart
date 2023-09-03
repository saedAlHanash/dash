import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../features/accounts/data/request/transfer_filter_request.dart';
import '../../features/bus_trips/data/request/filter_trip_history_request.dart';
import '../../features/bus_trips/data/request/trips_filter_request.dart';
import '../../features/buses/data/request/buses_filter_request.dart';
import '../../features/members/data/request/member_filter_request.dart';
import '../widgets/spinner_widget.dart';

class Command {
  Command({
    this.skipCount,
    this.maxResultCount,
    this.totalCount,
    this.historyRequest,
    this.memberFilterRequest,
    this.busesFilterRequest,
    this.tripsFilterRequest,
  });

  int? skipCount;
  int? maxResultCount;

  int? totalCount;
  FilterTripHistoryRequest? historyRequest;
  MemberFilterRequest? memberFilterRequest;
  BusesFilterRequest? busesFilterRequest;
  TripsFilterRequest? tripsFilterRequest;

  int get maxPages => ((totalCount ?? 0) / (maxResultCount??20)).myRound;

  int get currentPage => ((skipCount ?? 0) + 1 / (maxResultCount??20)).myRound;

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
    skipCount = (pageIndex - 1) * (maxResultCount??20);
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
    final json = <String, dynamic>{
      'skipCount': skipCount,
      'maxResultCount': maxResultCount,
      'InstitutionId': AppSharedPreference.getInstitutionId,
    };

    if (historyRequest != null) {
      json.addAll(historyRequest!.toMap());
    }
    if (memberFilterRequest != null) {
      json.addAll(memberFilterRequest!.toJson());
    }

    if (busesFilterRequest != null) {
      json.addAll(busesFilterRequest!.toJson());
    }

    if (tripsFilterRequest != null) {
      // json.addAll(tripsFilterRequest!.toJson());
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
    int? maxResultCount,
    FilterTripHistoryRequest? historyRequest,
    MemberFilterRequest? memberFilterRequest,
    BusesFilterRequest? busesFilterRequest,
    TripsFilterRequest? tripsFilterRequest,
  }) {
    return Command(
      skipCount: skipCount ?? this.skipCount,
      totalCount: totalCount ?? this.totalCount,
      historyRequest: historyRequest ?? this.historyRequest,
      memberFilterRequest: memberFilterRequest ?? this.memberFilterRequest,
      busesFilterRequest: busesFilterRequest ?? this.busesFilterRequest,
      tripsFilterRequest: tripsFilterRequest ?? this.tripsFilterRequest,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }
}
