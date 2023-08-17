import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../api_manager/command.dart';
import '../strings/app_color_manager.dart';
import 'my_card_widget.dart';

class SaedTableWidget extends StatelessWidget {
  const SaedTableWidget({
    super.key,
    required this.title,
    required this.data,
    this.command,
    this.onChangePage,
    this.fullSizeIndex,
    this.fullHeight,
  });

  final List<dynamic> title;
  final List<int>? fullSizeIndex;
  final List<List<dynamic>> data;

  final Command? command;
  final double? fullHeight;

  final Function(Command command)? onChangePage;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Column(
        children: [
          Row(
            children: title.mapIndexed(
              (i, e) {
                final widget = e is String
                    ? DrawableText(
                        selectable: true,
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: e,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
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
          ),
          Container(
            constraints: BoxConstraints(maxHeight: fullHeight ?? 0.6.sh),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, i1) {
                final e = data[i1];
                return CellWidget(e: e);
              },
            ),
          ),
          if (command != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinnerWidget(
                  items: command!.getSpinnerItems,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppColorManager.mainColor,
                  ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),

                  onChanged: (spinnerItem) {
                    onChangePage?.call(command!..goToPage(spinnerItem.id));
                  },
                ),
                15.0.horizontalSpace,
                DrawableText(text: 'عدد الصفحات الكلي: ${command?.maxPages}')
              ],
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
                        size: 16.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: e.isEmpty ? '-' : e.replaceAll('spy', ''),
                        color: Colors.black,
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
