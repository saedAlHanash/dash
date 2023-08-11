import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:qareeb_dash/core/widgets/spinner_widget.dart'; import 'package:qareeb_models/global.dart';

import '../api_manager/command.dart';
import 'my_card_widget.dart';

class SaedTableWidget extends StatelessWidget {
  const SaedTableWidget(
      {super.key,
      required this.title,
      required this.data,
      this.command,
      this.onChangePage,
      this.fullSizeIndex});

  final List<dynamic> title;
  final List<int>? fullSizeIndex;
  final List<List<dynamic>> data;

  final Command? command;

  final Function(Command command)? onChangePage;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: title.mapIndexed(
                (i, e) {
                  final widget = e is String
                      ? DrawableText(
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
            const Divider(),
            10.0.verticalSpace,
            ...data.mapIndexed((i1, e) {
              return Column(
                children: [
                  Row(
                    children: e.mapIndexed(
                      (i, e) {
                        final widget = e is String
                            ? Directionality(
                                textDirection: e.contains('spy')
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: DrawableText(
                                  size: 16.0.sp,
                                  matchParent: !(fullSizeIndex?.contains(i) ?? true),
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

                        if (fullSizeIndex?.contains(i) ?? false) {
                          return widget;
                        }

                        return Expanded(child: widget);
                      },
                    ).toList(),
                  ),
                  if (i1 != data.length - 1) const Divider(),
                ],
              );
            }).toList(),
            if (command != null)
              SpinnerWidget(
                items: command!.getSpinnerItems,
                onChanged: (spinnerItem) {
                  onChangePage?.call(command!..goToPage(spinnerItem.id));
                },
              ),

            20.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
