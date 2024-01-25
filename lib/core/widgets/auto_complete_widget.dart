import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';

import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import 'auto_complete/easy_autocomplete.dart';

class Saed extends StatefulWidget {
  const Saed({super.key});

  @override
  State<Saed> createState() => _SaedState();
}

class _SaedState extends State<Saed> {
  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 200,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),

      ),
    );
  }
}


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
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.zero
      ),
      initialValue: listItems.firstWhereOrNull((element) => element.isSelected),
      onSubmitted: (value) => onTap.call(value),
      onChange: (val) {
        // if (val.isEmpty) onTap.call(SpinnerItem());
      },
    );
  }
}
