import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';

import '../../features/map/data/models/my_marker.dart';
import '../../features/points/data/response/points_response.dart';
import '../../features/redeems/data/response/redeems_response.dart';
import '../../features/shared_trip/data/response/shared_trip.dart';
import '../../features/trip/data/response/trip_response.dart';
import '../../services/trip_path/data/models/trip_path.dart';
import '../strings/app_string_manager.dart';
import '../strings/enum_manager.dart';

export 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    show decodePolyline;

extension LatLngHelper on LatLng {
  int distanceBetweenLatLng(LatLng end) {
    final d =
        Geolocator.distanceBetween(latitude, longitude, end.latitude, end.longitude);
    return d.toInt();
  }
}

extension PolylineExt on List<List<num>> {
  List<LatLng> unpackPolyline() =>
      map((p) => LatLng(p[0].toDouble(), p[1].toDouble())).toList();
}

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      var piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  String get formatPrice => '${oCcy.format(this)} ل.س';

  int get numberOnly {
    final regex = RegExp(r'\d+');

    final numbers = regex.allMatches(this).map((match) => match.group(0)).join();

    try {
      return int.parse(numbers);
    } on Exception {
      return 0;
    }
  }
}

final oCcy = NumberFormat("#,##0.00");

extension MaxInt on num {
  int get maxInt => 2147483647;

  String get formatPrice => 'spy. ${oCcy.format(this)}';

  String get iconPoint {
    switch (toInt()) {
      case 0:
        return Assets.iconsA;
      case 1:
        return Assets.iconsB;
      case 2:
        return Assets.iconsC;
      case 3:
        return Assets.iconsD;
    }
    return Assets.iconsE;
  }
}

extension RealName on Enum {
  String get upperFirst => name.replaceRange(0, 1, name.substring(0, 1).toUpperCase());
}

extension Redeems on RedeemsResult {
  int get oilCount =>
      ((totalMeters / systemParameters.oil) - (totals.oil / systemParameters.oil))
          .floor();

  int get goldCount =>
      ((totalMeters / systemParameters.gold) - (totals.oil / systemParameters.gold))
          .floor();

  int get tiresCount =>
      ((totalMeters / systemParameters.tire) - (totals.oil / systemParameters.tire))
          .floor();

  int get oilOldCount => (totals.oil / systemParameters.oil).floor();

  int get goldOldCount => (totals.oil / systemParameters.gold).floor();

  int get tiresOldCount => (totals.oil / systemParameters.tire).floor();

  double get oilPCount => ((totals.oil * 100) / systemParameters.oil).roundToDouble();

  double get goldPCount => ((totals.oil * 100) / systemParameters.gold).roundToDouble();

  double get tiresPCount => ((totals.oil * 100) / systemParameters.tire).roundToDouble();
}

extension StateName on SharedTripStatus {
  String sharedTripName() {
    switch (this) {
      case SharedTripStatus.pending:
        return 'ابدأ الرحلة';

      case SharedTripStatus.started:
        return 'إنهاء الرحلة';

      case SharedTripStatus.closed:
        return '(رجوع)تم إنهاء الرحلة';

      case SharedTripStatus.canceled:
        return 'الرحلة ملغية';
    }
  }
}

extension PathMap on TripPath {
  List<MyMarker> getMarkers() {
    final list = <MyMarker>[];
    edges.forEachIndexed(
      (i, e) {
        if (i == 0) {
          list.add(
              MyMarker(point: e.startPoint.getLatLng, type: MyMarkerType.sharedPint));
        }
        list.add(MyMarker(point: e.endPoint.getLatLng, type: MyMarkerType.sharedPint));
      },
    );

    return list;
  }

  List<LatLng> getPoints() {
    final list = <LatLng>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(e.startPoint.getLatLng);
      }
      list.add(e.endPoint.getLatLng);
    });

    return list;
  }

  List<SpinnerItem> get getPointsSpinner {
    final list = <SpinnerItem>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(SpinnerItem(
          id: e.startPoint.id,
          name: e.startPoint.arName,
          item: e,
        ));
      }
      list.add(SpinnerItem(
        id: e.endPoint.id,
        name: e.endPoint.arName,
        item: e,
      ));
    });

    return list;
  }

  List<String> get getPointsName {
    final list = <String>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(e.startPoint.arName);
      }
      list.add(e.endPoint.arName);
    });

    return list;
  }

  List<TripPoint> get getTripPoints {
    final list = <TripPoint>[];

    edges.forEachIndexed((i, e) {
      if (i == 0) {
        list.add(e.startPoint);
      }
      list.add(e.endPoint);
    });

    return list;
  }

  List<MyPolyLine> getPolyLines() {
    final list = <MyPolyLine>[];

    edges.forEachIndexed((i, e) {
      list.add(MyPolyLine(key: i, encodedPolyLine: e.steps));
    });

    return list;
  }

  // String get pathNamed {
  //   var named = '';
  //   edges.forEachIndexed((i, e) {
  //
  //     if (i == edges.length - 1) named += '${e.endPoint.arName} ';
  //
  //     if (i == 0) named += '${e.startPoint.arName} -> ';
  //
  //     named += '${e.endPoint.arName} -> ';
  //   });
  //   return named;
  // }

  LatLng? get startPoint => edges.firstOrNull?.startPoint.getLatLng;
}

extension NormalTripMap on TripResult {
  List<MyMarker> get getMarkers {
    return [
      MyMarker(point: startPoint, type: MyMarkerType.sharedPint),
      MyMarker(point: endPoint, type: MyMarkerType.sharedPint),
    ];
  }

  LatLng get startPoint => currentLocation.latLng;

  LatLng get endPoint => destination.latLng;

  String get dateTrip {
    if (startDate != null) {
      return startDate!.formatFullDate;
    } else if (endDate != null) {
      return endDate!.formatFullDate;
    }
    return 'لم تبدأ';
  }

  String get getTripsCost {
    return '$tripFare ${AppStringManager.currency}';
  }

  String get tripStateName {
    //غير موجودة أو منتهية
    if (isCanceled) return 'ملغية';

    //final
    if (isDelved) return 'مكتملة';
    //بدأت
    if (isStarted || isConfirmed) return 'جارية';

    //تم تأكيدها
    if (isConfirmed) return 'بحث عن سائق';

    return 'حالة غير معروفة';
  }

  NavTrip? get tripStateEnum {
    //غير موجودة أو منتهية
    if (isCanceled) return null;

    //final
    if (isDelved) return NavTrip.ended;
    //بدأت
    if (isStarted || isConfirmed) return NavTrip.started;

    //تم تأكيدها
    if (isConfirmed) return NavTrip.waiting;

    return NavTrip.have;
  }

  String get getCost {
    return '${tripFare - paidAmount} ${AppStringManager.currency}';
  }

  String get getDuration {
    return ' ${duration.numberOnly ~/ 60} ${AppStringManager.minute}';
  }

  String get getDistance {
    return ' $distance ${AppStringManager.km}';
  }

  bool get iamDriver {
    return (driver.id == 0) || (driver.id == AppSharedPreference.getMyId);
  }
}

extension SharedRequestMap on SharedTrip {
  int nou(LatLng point) {
    for (var e in sharedRequests) {
      if (e.status == SharedRequestStatus.pending.index) return 0;
      if (e.pickupPoint.getLatLng.hashCode == point.hashCode) return e.seatNumber;
    }
    return 0;
  }

  List<SpinnerItem> availableRequest() {
    var s = <SpinnerItem>[];
    var a = seatsNumber - sharedRequests.length;
    for (var i = 1; i <= a; i++) {
      s.add(SpinnerItem(id: i, name: i.toString()));
    }
    return s;
  }
}

extension CubitStateHelper on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;

  bool get error => this == CubitStatuses.error;

  bool get init => this == CubitStatuses.init;
}

extension TripPointHelper on TripPoint {
  LatLng get getLatLng => LatLng(lat, lng);
}

extension MapResponse on http.Response {
  dynamic get jsonBody => jsonDecode(body);
}

extension FirstItem<E> on Iterable<E> {
  E? firstItem() {
    if (isEmpty) {
      return null;
    } else {
      return first;
    }
  }

  E? lastItem() {
    if (isEmpty) {
      return null;
    } else {
      return last;
    }
  }
}

extension GetDateTimesBetween on DateTime {
  List<DateTime> getDateTimesBetween({
    required DateTime end,
    required Duration period,
  }) {
    var dateTimes = <DateTime>[];
    var current = add(period);
    while (current.isBefore(end)) {
      if (dateTimes.length > 24) {
        break;
      }
      dateTimes.add(current);
      current = current.add(period);
    }
    return dateTimes;
  }
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat('yyyy/MM/dd').format(this);

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);

  String get formatTime => DateFormat('h:mm a').format(this);

  String get formatDateTime => '$formatTime $formatDate';

  String get formatFullDate => '$formatDayName  $formatDate  $formatTime';

  String get formatDayName {
    initializeDateFormatting();
    return DateFormat('EEEE', 'ar_SA').format(this);
  }

  DateTime addFromNow({int? year, int? month, int? day, int? hour}) {
    return DateTime(
      this.year + (year ?? 0),
      this.month + (month ?? 0),
      this.day + (day ?? 0),
      this.hour + (hour ?? 0),
    );
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}

extension ScrollMax on ScrollController {
  bool get isMax => position.maxScrollExtent == offset;

  bool get isMin => offset == 0;
}
