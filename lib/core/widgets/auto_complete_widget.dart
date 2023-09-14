import 'package:flutter/material.dart';
import 'package:qareeb_models/global.dart';

import 'auto_complete/easy_autocomplete.dart';


class AutoCompleteWidget extends StatelessWidget {
  const AutoCompleteWidget({super.key, required this.onTap, required this.listItems});

  final Function(SpinnerItem item) onTap;

  final List<SpinnerItem> listItems;

  @override
  Widget build(BuildContext context) {
    return EasyAutocomplete(

      suggestions: listItems,
      onSubmitted: (value) => onTap.call(value),
    );
  }
}
