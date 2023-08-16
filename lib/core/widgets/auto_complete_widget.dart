import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import 'auto_complete/easy_autocomplete.dart';

class AutoCompleteWidget extends StatelessWidget {
  const AutoCompleteWidget({
    super.key,
    required this.onTap,
    required this.listItems,
    this.hint,
  });

  final Function(SpinnerItem item) onTap;

  final List<SpinnerItem> listItems;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return EasyAutocomplete(
      suggestions: listItems,
      decoration: InputDecoration(hintText: hint),
      initialValue: listItems.firstWhereOrNull((element) => element.isSelected),
      onSubmitted: (value) => onTap.call(value),
    );
  }
}
