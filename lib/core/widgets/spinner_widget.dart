import 'package:drawable_text/drawable_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/global.dart';

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
            selectable: false,
            text: item.name ?? '',
            padding: padding,
            color: (item.id != null)
                ? (item.enable)
                    ? Colors.black
                    : AppColorManager.gray.withOpacity(0.7)
                : AppColorManager.gray.withOpacity(0.7),
            fontFamily: FontManager.cairoBold.name,
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

  void clearSelect() {
    if (widget.hint == null) {
      selectedItem = list.first.value;
    } else {
      selectedItem = null;
    }
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
            if (!(value!).enable) return;
            if (widget.onChanged != null) widget.onChanged!(value);
            state(() => selectedItem = value);
          },
          buttonStyleData: ButtonStyleData(
            width: widget.width,
            height: 60.0.h,
            decoration: widget.decoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0.r),
                  color: AppColorManager.offWhit.withOpacity(0.5),
                ),
            padding: const EdgeInsets.only(right: 10.0).w,
            elevation: 0,
          ),
          dropdownStyleData: DropdownStyleData(
            width: widget.dropdownWidth,
            maxHeight: 300.0.h,
            elevation: 2,
          ),
          iconStyleData: IconStyleData(
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
          ),
          isExpanded: widget.expanded ?? false,
          customButton: widget.customButton,
          underline: 0.0.verticalSpace,
        );
      },
    );
  }
}

class SpinnerOutlineTitle extends StatelessWidget {
  const SpinnerOutlineTitle({
    super.key,
    required this.items,
    this.hint,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.decoration,
    this.label = '',
  });

  final List<SpinnerItem> items;
  final Widget? hint;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final BoxDecoration? decoration;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawableText(
          selectable: false,
          text: label,
          color: AppColorManager.black,
          padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
          size: 18.0.sp,
        ),
        3.0.verticalSpace,
        SpinnerWidget(
          items: items,
          hint: hint,
          onChanged: onChanged,
          customButton: customButton,
          width: width,
          dropdownWidth: dropdownWidth,
          sendFirstItem: sendFirstItem,
          expanded: expanded,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0.r),
            border: Border.all(color: AppColorManager.gray, width: 1.0.r),
          ),
        )
      ],
    );
  }
}
