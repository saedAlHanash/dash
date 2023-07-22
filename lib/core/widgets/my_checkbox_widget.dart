import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

import '../strings/app_color_manager.dart';
import '../widgets/spinner_widget.dart';

class MyCheckboxWidget extends StatefulWidget {
  const MyCheckboxWidget({
    Key? key,
    required this.items,
    this.buttonBuilder,
    this.onSelected,
    this.isRadio,
    this.width,
    this.maxSelected,
    this.onSelectGetListItems,
  }) : super(key: key);

  final List<SpinnerItem> items;
  final bool? isRadio;

  final double? width;
  final int? maxSelected;
  final GroupButtonValueBuilder<SpinnerItem>? buttonBuilder;
  final Function(SpinnerItem, int, bool)? onSelected;
  final Function(List<SpinnerItem> list)? onSelectGetListItems;

  factory MyCheckboxWidget.btn(
      {required List<SpinnerItem> items,
      Function(SpinnerItem item, int index, bool isSelect)? onSelected,
      bool? isRadio,
      double? border}) {
    return MyCheckboxWidget(
      onSelected: onSelected,
      items: items,
      isRadio: isRadio,
      buttonBuilder: (selected, value, context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0).r,
          decoration: BoxDecoration(
            color: selected ? AppColorManager.mainColor : AppColorManager.whit,
            borderRadius: BorderRadius.circular(border ?? 3.r),
            border: Border.all(
              color: selected ? AppColorManager.mainColor : AppColorManager.black,
              width: 1.spMin,
            ),
          ),
          child: DrawableText(
            text: value.name ?? '',
            maxLines: 1,
            color: selected ? AppColorManager.whit : AppColorManager.black,
            size: 16.0.sp,
          ),
        );
      },
    );
  }

  @override
  State<MyCheckboxWidget> createState() => _MyCheckboxWidgetState();
}

class _MyCheckboxWidgetState extends State<MyCheckboxWidget> {
  final GroupButtonController controller = GroupButtonController();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        for (var i = 0; i < widget.items.length; i++) {
          if (widget.items[i].isSelected) {
            controller.selectIndex(i);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GroupButton<SpinnerItem>(
      buttons: widget.items,
      buttonBuilder: widget.buttonBuilder ??
          (selected, value, context) {
            return InkWell(
              child: SizedBox(
                width: widget.width ?? 0.4.sw,
                height: 40.0.h,
                child: DrawableText(
                  text: value.name ?? '',
                  maxLines: 1,
                  color: selected
                      ? AppColorManager.mainColorDark
                      : ((widget.maxSelected != null &&
                                  controller.selectedIndexes.length >=
                                      widget.maxSelected!) ||
                              value.enable == false)
                          ? AppColorManager.mainColorDark
                          : AppColorManager.black,
                  size: 24.0.sp,
                  fontFamily: FontManager.cairoBold,
                  drawableStart: Checkbox(
                    value: selected,
                    activeColor: AppColorManager.mainColorDark,
                    side: BorderSide(
                        width: 1.0.spMin, color: AppColorManager.mainColorDark),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0.r),
                    ),
                    onChanged: null,
                  ),
                ),
              ),
            );
          },
      onSelected: (value, index, isSelected) {
        if (value.enable == false) {
          controller.unselectIndex(index);
          if (controller.selectedIndexes.isEmpty) {
            for (var e in widget.items) {
              if (e.id == 0) continue;

              e.enable = true;
            }
          }
          return;
        }

        value.isSelected = isSelected;

        if (controller.selectedIndexes.isEmpty) {
          for (var e in widget.items) {
            if (e.id == 0) continue;
            e.enable = true;
          }
        } else {
          if (controller.selectedIndexes.isNotEmpty && widget.maxSelected != null) {
            var f = controller.selectedIndexes;
            for (var e in widget.items) {
              e.enable = false;
            }

            for (var i = f.first; i < (f.first + widget.maxSelected!); i++) {
              if (i == widget.items.length) break;
              if (widget.items[i].id == 0) continue;
              widget.items[i].enable = true;
            }
          }
        }

        setState(() {});
        if (widget.onSelected != null) {
          widget.onSelected!(value, index, isSelected);
        }
        if (widget.onSelectGetListItems != null) {
          final selectedList = <SpinnerItem>[];
          for (var e in widget.items) {
            if (e.isSelected) selectedList.add(e);

          }
          widget.onSelectGetListItems!(selectedList);
        }
      },
      enableDeselect: !(widget.isRadio ?? false),
      options: const GroupButtonOptions(
        crossGroupAlignment: CrossGroupAlignment.center,
        mainGroupAlignment: MainGroupAlignment.center,
      ),
      controller: controller,
      isRadio: widget.isRadio ?? false,
      maxSelected: widget.maxSelected,
    );
  }
}
