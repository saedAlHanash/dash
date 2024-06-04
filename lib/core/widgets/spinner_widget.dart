import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
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
    this.searchable = true,
  }) : super(key: key);

  final List<SpinnerItem> items;
  final Widget? hint;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final bool searchable;
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
            color: item.id == null
                ? AppColorManager.gray.withOpacity(0.7)
                : (item.enable)
                    ? Colors.black
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

  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (_, state) {
        return DropdownButton2<SpinnerItem>(
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
          dropdownSearchData: !widget.searchable
              ? null
              : DropdownSearchData<SpinnerItem>(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'بحث',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value?.name.toString().contains(searchValue) ?? false;
                  },
                ),
          onMenuStateChange: !widget.searchable
              ? null
              : (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
        );
      },
    );
  }
}

class SpinnerWidget1<T> extends StatefulWidget {
  const SpinnerWidget1({
    super.key,
    required this.items,
    this.hint,
    this.hintText,
    this.hintLabel,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.isOverButton,
    this.decoration,
        this.searchable = true,
  });

  final List<SpinnerItem> items;
  final Widget? hint;
  final String? hintText;
  final String? hintLabel;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final bool? isOverButton;
  final BoxDecoration? decoration;
    final bool searchable;

  @override
  State<SpinnerWidget1<T>> createState() => SpinnerWidgetState1<T>();
}

class SpinnerWidgetState1<T> extends State<SpinnerWidget1<T>> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.hintLabel != null)
          DrawableText(
            text: widget.hintLabel ?? '',
            color: AppColorManager.gray,
            size: 14.0.sp,
            matchParent: true,
            padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
            fontFamily: FontManager.cairo.name,
          ),
        DropdownButton2(
          items: widget.items.map(
                (item) {
              return DropdownMenuItem(
                value: item,
                child: DrawableText(
                  selectable: false,
                  text: item.name ?? '',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                  color: (item.id != -1)
                      ? (item.enable)
                      ? Colors.black
                      : AppColorManager.gray.withOpacity(0.7)
                      : AppColorManager.gray.withOpacity(0.7),
                  drawableStart: item.icon,
                  drawablePadding: 15.0.w,
                ),
              );
            },
          ).toList(),
          value: widget.items.firstWhereOrNull((e) => e.isSelected),
          hint: (widget.hintText != null)
              ? DrawableText(
            text: widget.hintText!,
            color: Colors.grey,
            size: 14.0.sp,
            padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          )
              : widget.hint,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value!);
            if (!(value!).enable) return;

            for (final e in widget.items) {
              e.isSelected = false;
              if (e.id == value.id) {
                e.isSelected = true;
              }
            }
            setState(() {});
          },
          buttonStyleData: ButtonStyleData(
            width: widget.width ?? 0.9.sw,
            height: 51.0.h,
            decoration: widget.decoration ??
                BoxDecoration(
                  color: AppColorManager.f1,
                  borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                ),
            elevation: 0,
          ),
          dropdownStyleData: DropdownStyleData(
            width: widget.dropdownWidth,
            maxHeight: 300.0.h,
            elevation: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            isOverButton: widget.isOverButton ?? false,
          ),
          iconStyleData: IconStyleData(
            icon: Row(
              children: [
                ImageMultiType(
                  url: Icons.expand_more,
                  height: 18.0.r,
                  width: 18.0.r,
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
          dropdownSearchData: !widget.searchable
              ? null
              : DropdownSearchData<SpinnerItem>(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'بحث',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value?.name.toString().contains(searchValue) ?? false;
            },
          ),
          onMenuStateChange: !widget.searchable
              ? null
              : (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ],
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
    this.searchable = false,
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
  final bool searchable;

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
          searchable: searchable,
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
