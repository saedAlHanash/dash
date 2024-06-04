import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/api_manager/api_service.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../../strings/app_color_manager.dart';
import '../../util/my_style.dart';
import '../my_button.dart';
import '../my_text_form_widget.dart';
import 'filter_item.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget(
      {super.key, required this.filters, required this.onFilter});

  final List<List<FilterItem>> filters;

  final Function(Map<String, dynamic> map) onFilter;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final Map<String, dynamic> map = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0).r,
      margin: const EdgeInsets.all(30.0).r,
      decoration: MyStyle.outlineBorder,
      child: Column(
        children: widget.filters
            .map(
              (e) => Row(
                children: e.map(
                  (e) {
                    return Expanded(
                      child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20.0).w,
                          child: Builder(
                            builder: (context) {
                              switch (e.type) {
                                case FilterType.spinner:
                                  return SpinnerWidget1(
                                    items: e.items!,
                                    hintText: e.title,
                                    onChanged: (spinnerItem) {
                                      map[e.key] = spinnerItem.id;
                                    },
                                  );
                                case FilterType.num:
                                case FilterType.text:
                                  return MyTextFormNoLabelWidget(
                                    label: e.title,
                                    controller: e.controller,
                                    onChanged: (p0) => map[e.key] = p0,
                                  );

                                case FilterType.date:
                              }
                              return Container();
                            },
                          )),
                    );
                  },
                ).toList(),
              ),
            )
            .toList()
          ..add(Row(
            children: [
              Expanded(
                child: MyButton(
                  width: 1.0.sw,
                  color: AppColorManager.mainColorDark,
                  text: 'فلترة',
                  onTap: () {
                    widget.onFilter.call(map);
                  },
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyButton(
                  width: 1.0.sw,
                  color: AppColorManager.black,
                  text: 'مسح الفلاتر',
                  onTap: () {
                    for (var e in widget.filters) {
                      for (var e1 in e) {
                        e1.controller?.text = '';
                        e1.items?.forEach((e2) => e2.isSelected = false);
                      }
                    }
                    map.clear();
                    widget.onFilter.call(map);
                    setState(() {});
                  },
                ),
              ),
            ],
          )),
      ),
    );
  }
}
