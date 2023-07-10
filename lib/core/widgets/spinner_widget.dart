import 'package:drawable_text/drawable_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class SpinnerWidget<T> extends StatefulWidget {
  const SpinnerWidget({
    Key? key,
    required this.items,
    this.hint,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.decoration,
  }) : super(key: key);

  final List<SpinnerItem> items;
  final Widget? hint;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final BoxDecoration? decoration;

  @override
  State<SpinnerWidget<T>> createState() => SpinnerWidgetState<T>();
}

class SpinnerWidgetState<T> extends State<SpinnerWidget<T>> {
  var list = <DropdownMenuItem<SpinnerItem>>[];
  SpinnerItem? selectedItem;

  @override
  void initState() {
    list = widget.items.map(
      (item) {
        if (item.isSelected) selectedItem = item;

        final padding = (item.icon == null)
            ? const EdgeInsets.symmetric(horizontal: 15.0).w
            : EdgeInsets.only(left: 15.0.w);

        return DropdownMenuItem(
          value: item,
          child: DrawableText(
            text: item.name ?? '',
            padding: padding,
            color: (item.id != -1)
                ? (item.enable)
                    ? Colors.black
                    : AppColorManager.gray.withOpacity(0.7)
                : AppColorManager.gray.withOpacity(0.7),
            fontFamily: FontManager.cairoBold,
            drawableStart: item.icon,
            drawablePadding: 15.0.w,
          ),
        );
      },
    ).toList();

    if (widget.hint == null) selectedItem ??= widget.items.firstOrNull;

    if ((widget.sendFirstItem ?? false) && selectedItem != null) {
      if (widget.onChanged != null) widget.onChanged!(selectedItem!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, state) {
        return DropdownButton2(
          items: list,
          value: selectedItem,
          hint: widget.hint,
          onChanged: (value) {
            if (!(value! as SpinnerItem).enable) return;
            if (widget.onChanged != null) widget.onChanged!(value as SpinnerItem);
            state(() => selectedItem = value as SpinnerItem);
          },
          buttonWidth: widget.width,
          isExpanded: widget.expanded ?? false,
          dropdownWidth: widget.dropdownWidth,
          customButton: widget.customButton,
          underline: 0.0.verticalSpace,
          buttonHeight: 60.0.h,
          dropdownMaxHeight: 300.0.h,
          buttonDecoration: widget.decoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                color: AppColorManager.offWhit.withOpacity(0.5),
              ),
          buttonPadding: const EdgeInsets.only(right: 10.0).w,
          buttonElevation: 0,
          dropdownElevation: 2,
          icon: Row(
            children: [
              const Icon(
                Icons.expand_more,
                color: AppColorManager.mainColor,
              ),
              18.0.horizontalSpace,
            ],
          ),
          iconSize: 35.0.spMin,
        );
      },
    );
  }
}

class SpinnerItem {
  SpinnerItem({
    this.name,
    this.id = 0,
    this.isSelected = false,
    this.item,
    this.icon,
    this.enable = true,
  });

  String? name;
  int id;
  bool isSelected;
  bool enable;
  dynamic item;
  Widget? icon;

//<editor-fold desc="Data Methods">

  SpinnerItem copyWith({
    String? name,
    int? id,
    bool? isSelected,
    bool? enable,
    dynamic item,
  }) {
    return SpinnerItem(
      name: name ?? this.name,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      enable: enable ?? this.enable,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'isSelected': isSelected,
      'enable': enable,
      'item': item,
    };
  }

  factory SpinnerItem.fromMap(Map<String, dynamic> map) {
    return SpinnerItem(
      name: map['name'] as String,
      id: map['id'] as int,
      isSelected: map['isSelected'] as bool,
      enable: map['enable'] as bool,
      item: map['item'] as dynamic,
    );
  }

//</editor-fold>
}
