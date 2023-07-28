import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:qareeb_super_user/generated/assets.dart';

import '../strings/enum_manager.dart';




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

final oCcy = NumberFormat("#,##0.00", "en_US");


extension RealName on Enum {
  String get upperFirst => name.replaceRange(0, 1, name.substring(0, 1).toUpperCase());
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

extension NavTripHelper on NavTrip {
  double get maxBottomSheet {
    switch (this) {
      case NavTrip.waiting:
        return 0.1;

      case NavTrip.acceptor:
        return 0.4;

      case NavTrip.start:
        return 0.24;

      case NavTrip.end:
        // TODO: Handle this case.
        break;
    }
    return 0.5;
  }

  double get minBottomSheet {
    switch (this) {
      case NavTrip.waiting:
        return 0.1;

      case NavTrip.acceptor:
        return 0.2;

      case NavTrip.start:
        return 0.1;

      case NavTrip.end:
        // TODO: Handle this case.
        break;
    }
    return 0.2;
  }

  double get initBottomSheet {
    switch (this) {
      case NavTrip.waiting:
        return 0.1;
      case NavTrip.acceptor:
        return 0.2;
      case NavTrip.start:
        return 0.1;
      case NavTrip.end:
        // TODO: Handle this case.
        break;
    }
    return 0.3;
  }
}


extension MaxInt on num {
  int get maxInt => 2147483647;

  String get formatPrice => 'spy${oCcy.format(this)}';

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

  int get myRound {
    if (toInt() < this) return toInt() + 1;
    return toInt();
  }
}


extension CubitStateHelper on CubitStatuses {
  bool get isLoading => this == CubitStatuses.loading;

  bool get isDone => this == CubitStatuses.done;
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

  String get formatDate => DateFormat.yMd().format(this);

  String get formatTime => DateFormat.Hm().format(this);

  String get formatDateTime => '$formatDate $formatTime';

  String get formatFullDate => '$formatDayName  $formatTime  $formatDate';

  String get formatDayName {
    initializeDateFormatting();
    return DateFormat('EEEE', 'ar_SA').format(this);
  }

  DateTime addFromNow({int? year, int? month, int? day}) {
    return DateTime(
        this.year + (year ?? 0), this.month + (month ?? 0), this.day + (day ?? 0));
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}

extension ScrollMax on ScrollController {
  bool get isMax => position.maxScrollExtent == offset;

  bool get isMin => offset == 0;
}
