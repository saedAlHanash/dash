import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../api_manager/command.dart';
import '../strings/app_color_manager.dart';
import 'my_card_widget.dart';

class SaedTableWidget extends StatelessWidget {
  const SaedTableWidget(
      {super.key, required this.title, required this.data, required this.command});

  final List<dynamic> title;
  final List<List<dynamic>> data;

  final Command command;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Column(
        children: [
          Row(
            children: title
                .mapIndexed(
                  (i, e) => Expanded(
                    child: e is String
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
                              ),
                  ),
                )
                .toList(),
          ),
          const Divider(),
          ...data.mapIndexed((i1, e) {
            return Column(
              children: [
                Row(
                  children: e
                      .mapIndexed(
                        (i, e) => Expanded(
                          child: e is String
                              ? Directionality(
                                  textDirection: e.contains('spy')
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  child: DrawableText(
                                    size: 18.0.sp,
                                    matchParent: true,
                                    textAlign: TextAlign.center,
                                    text: e.replaceAll('spy', ''),
                                    color: Colors.black,
                                    fontFamily: FontManager.cairoBold,
                                  ),
                                )
                              : e is Widget
                                  ? e
                                  : Container(
                                      height: 10,
                                      color: Colors.red,
                                    ),
                        ),
                      )
                      .toList(),
                ),
                if (i1 != data.length - 1) const Divider(),
              ],
            );
          }).toList(),

          SpinnerWidget(items: )
        ],
      ),
    );
  }
}
