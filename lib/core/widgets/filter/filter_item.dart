import 'package:flutter/cupertino.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_models/global.dart';

class FilterItem {
  FilterItem({
    required this.type,
    required this.title,
    required this.key,
    this.items,
    this.controller,
  });

  final String title;
  final String key;
  final FilterType type;
  final List<SpinnerItem>? items;
  final TextEditingController? controller;
}

enum FilterType {
  spinner,
  text,
  num,
  date,
}
