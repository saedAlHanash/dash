import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../api_manager/command.dart';
import '../strings/app_color_manager.dart';
import '../util/my_style.dart';

class SaedTableWidget extends StatelessWidget {
  const SaedTableWidget({
    super.key,
    required this.title,
    required this.data,
    this.command,
    this.onChangePage,
    this.fullSizeIndex,
    this.fullHeight,
    this.filters,
  });

  final List<dynamic> title;
  final List<int>? fullSizeIndex;
  final Widget? filters;
  final List<List<dynamic>> data;

  final Command? command;
  final double? fullHeight;

  final Function(Command command)? onChangePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorManager.lightGray,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      padding: MyStyle.cardPadding,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: ListView(
        shrinkWrap: true,
        children: [
          filters ?? 0.0.verticalSpace,
          TitleWidget(title: title),
          ...data.map((e) => CellWidget(e: e)).toList(),
          30.0.verticalSpace,
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (command != null)
                  SpinnerWidget(
                    items: command!.getSpinnerItems,
                    onChanged: (spinnerItem) {
                      onChangePage?.call(command!..goToPage(spinnerItem.id));
                    },
                  ),
                15.0.horizontalSpace,
                if (command != null)
                  DrawableText(
                      text:
                          'الصفحات: ${command?.maxPages}   - النتائج : ${command?.totalCount}'),
                // InkWell(onTap: () {}, child: Icon(Icons.search))
              ],
            ),
          ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({super.key, required this.e});

  final List e;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: e.mapIndexed(
            (i, e) {
              final widget = e is String
                  ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: DrawableText(
                        selectable: true,
                        size: 17.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: e.isEmpty ? '-' : e,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold.name,
                      ),
                    )
                  : e is Widget
                      ? e
                      : Container(
                          height: 10,
                          color: Colors.red,
                        );

              return Expanded(child: widget);
            },
          ).toList(),
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});

  final List title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: title.mapIndexed(
        (i, e) {
          final widget = e is String
              ? DrawableText(
                  selectable: true,
                  size: 20.0.sp,
                  matchParent: true,
                  textAlign: TextAlign.center,
                  text: e,
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold.name,
                )
              : title is Widget
                  ? title as Widget
                  : Container(
                      color: Colors.red,
                      height: 10,
                    );

          return Expanded(child: widget);
        },
      ).toList(),
    );
  }
}
