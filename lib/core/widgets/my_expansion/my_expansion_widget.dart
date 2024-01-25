import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../strings/app_color_manager.dart';
import 'item_expansion.dart';
import 'my_expansion_panal.dart';

class MyExpansionWidget extends StatefulWidget {
  const MyExpansionWidget({
    Key? key,
    required this.items,
    this.onTapItem,
    this.elevation,
    this.onExpansion,
    this.decoration,
    this.bodyPadding,
    this.headerHeight,
  }) : super(key: key);

  final List<ItemExpansion> items;

  final double? elevation;
  final double? headerHeight;
  final Function(int)? onTapItem;
  final ItemExpansionOption Function(ItemExpansion)? onExpansion;
  final BoxDecoration? decoration;
  final EdgeInsets? bodyPadding;

  @override
  State<MyExpansionWidget> createState() => _MyExpansionWidgetState();
}

class _MyExpansionWidgetState extends State<MyExpansionWidget> {
  @override
  Widget build(BuildContext context) {
    final listItem = widget.items.map(
      (e) {
        return MyExpansionPanel(
          canTapOnHeader: true,
          isExpanded: e.isExpanded,
          withSideColor: e.withSideColor,
          backgroundColor: AppColorManager.lightGray,
          headerBuilder: (_, isExpanded) {
            if (e.headerText != null) {
              return Center(
                child: DrawableText(
                  text: e.headerText!,
                  size: 18.0.sp,
                  matchParent: true,
                  fontFamily: FontManager.cairoBold.name,
                  color: Colors.black,
                  drawablePadding: 32.0.spMin,
                ),
              );
            }
            return e.header ??
                const DrawableText(
                  text: 'header',
                );
          },
          body: e.body,
          enable: e.enable,
          onTapItem: widget.onTapItem,
        );
      },
    ).toList();

    return MyExpansionPanelList(
      cardElevation: widget.elevation,
      elevation: 0,
      children: listItem,
      headerHeight: widget.headerHeight,
      bodyPadding: widget.bodyPadding,
      expandedHeaderPadding: EdgeInsets.zero,
      decoration: widget.decoration,
      dividerColor: Colors.transparent,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          widget.items[panelIndex].isExpanded = !widget.items[panelIndex].isExpanded;
        });
      },
    );
  }
}
