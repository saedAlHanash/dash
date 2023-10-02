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

  String get removeSpace => replaceAll(' ', '');

  int get numberOnly {
    try {
      return int.parse(this);
    } on Exception {
      return 0;
    }
  }

  double get getCost {
    RegExp regExp = RegExp(r"(\d+\.\d+)");
    String? match = regExp.stringMatch(this);
    double number = double.parse(match ?? '0');
    return number;
  }

  String get removeDuplicates {
    List<String> words = split(' ');
    Set<String> uniqueWords = Set<String>.from(words);
    List<String> uniqueList = uniqueWords.toList();
    String output = uniqueList.join(' ');
    return output;
  }
}

extension StringHelper on String? {
  bool get isBlank {
    return this?.trim().isEmpty ?? true;
  }
}

final oCcy = NumberFormat("#,##0", 'en');

extension MaxInt on num {
  int get maxInt => 2147483647;

  String get formatPrice => 'spy${oCcy.format(this)}';

  String get iconPoint {
    final data = toInt() + 1;
    switch (data) {
      case 1:
        return Assets.icons1;
      case 2:
        return Assets.icons2;
      case 3:
        return Assets.icons3;
      case 4:
        return Assets.icons4;
      case 5:
        return Assets.icons5;
      case 6:
        return Assets.icons6;
      case 7:
        return Assets.icons7;
      case 8:
        return Assets.icons8;
      case 9:
        return Assets.icons9;
      case 10:
        return Assets.icons10;
      case 11:
        return Assets.icons11;
      case 12:
        return Assets.icons12;
      case 13:
        return Assets.icons13;
      case 14:
        return Assets.icons14;
      case 15:
        return Assets.icons15;
      case 16:
        return Assets.icons16;
      case 17:
        return Assets.icons17;
      case 18:
        return Assets.icons18;
      case 19:
        return Assets.icons19;
      case 20:
        return Assets.icons20;
      case 21:
        return Assets.icons21;
      case 22:
        return Assets.icons22;
      case 23:
        return Assets.icons23;
      case 24:
        return Assets.icons24;
      case 25:
        return Assets.icons25;
      case 26:
        return Assets.icons26;
    }
    return Assets.icons26;
  }

  int get myRound {
    if (toInt() < this) return toInt() + 1;
    return toInt();
  }
}

extension NullOrZero on num? {
  bool get nullOrZero => this == 0;
}

extension RealName on Enum {
  String get upperFirst => name.replaceRange(0, 1, name.substring(0, 1).toUpperCase());

  String get arabicName {
    if (this is AttendanceType) {
      switch (this as AttendanceType) {
        case AttendanceType.up:
          return 'صعود';
        case AttendanceType.down:
          return 'نزول';
        case AttendanceType.unknown:
          return 'غير معروف';
      }
    }
    if (this is TransferType) {
      switch (this) {
        case TransferType.sharedPay:
          return 'رحلة تشاركية';
        case TransferType.tripPay:
          return 'رحلة عادية';
        case TransferType.payoff:
          return 'من السائق للشركة';
        case TransferType.debit:
          return 'من الشركة للسائق';
      }
    }
    if (this is BusTripType) {
      switch (this) {
        case BusTripType.go:
          return 'ذهاب';
        case BusTripType.back:
          return 'إياب';
      }
    }
    if (this is InstitutionType) {
      switch (this) {
        case InstitutionType.school:
          return 'مدرسة';

        case InstitutionType.college:
          return 'جامعة';

        case InstitutionType.transportation:
          return 'نقل';
      }
    }
    if (this is Government) {
      switch (this) {
        case Government.damascus:
          return 'دمشق';

        case Government.rifDimashq:
          return 'ريف دمشق';
      }
    }
    if (this is WeekDays) {
      switch (this) {
        case WeekDays.sunday:
          return 'أحد';

        case WeekDays.monday:
          return 'إثنين';

        case WeekDays.tuesday:
          return 'ثلاثاء';

        case WeekDays.wednesday:
          return 'أربعاء';

        case WeekDays.thursday:
          return 'خميس';

        case WeekDays.friday:
          return 'جمعة';

        case WeekDays.saturday:
          return 'سبت';
      }
    }
    return '';
  }
}

extension EnumSpinner on List<Enum> {
  List<SpinnerItem> spinnerItems({List<Enum?>? selected}) {
    return map(
      (e) => SpinnerItem(
        name: (e.arabicName.isEmpty) ? e.name : e.arabicName,
        id: e.index,
        item: e,
        isSelected: selected?.contains(e) ?? false,
      ),
    ).toList();
  }
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

  String get formatTime => DateFormat('h:mm a',).format(this)
;

  String get formatDateTime => '$formatDate - $formatTime';

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

List<List<T>> groupingList<T>(int size, List<T> list) {
  final List<List<T>> result = [];
  for (int i = 0; i < list.length; i += size) {
    result.add(list.sublist(i, i + size > list.length ? list.length : i + size));
  }
  return result;
}