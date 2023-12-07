import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../members/ui/pages/create_member_page.dart';
import '../../data/request/filter_record_check_request.dart';
import '../../data/request/filter_trip_history_request.dart';

class RecordCheckFilterWidget extends StatefulWidget {
  const RecordCheckFilterWidget({super.key, this.onApply, this.command});

  final Function(FilterRecordCheckRequest request)? onApply;

  final Command? command;

  @override
  State<RecordCheckFilterWidget> createState() => _RecordCheckFilterWidgetState();
}

class _RecordCheckFilterWidgetState extends State<RecordCheckFilterWidget> {
  late FilterRecordCheckRequest request;

  late final TextEditingController startDateC;
  late final TextEditingController endDateC;
  late final TextEditingController memberNameC;
  late final TextEditingController supervisorNameC;

  final key1 = GlobalKey<SpinnerWidgetState>();

  @override
  void initState() {
    request = widget.command?.recordCheckRequest ?? FilterRecordCheckRequest();
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    memberNameC = TextEditingController(text: request.memberName);
    supervisorNameC = TextEditingController(text: request.supervisorName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0).r,
      margin: const EdgeInsets.all(30.0).r,
      decoration: MyStyle.outlineBorder,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'تاريخ بداية الرحلة',
                  controller: startDateC,
                  disableAndKeepIcon: true,
                  textDirection: TextDirection.ltr,
                  iconWidget: SelectSingeDateWidget(
                    initial: request.startTime,
                    onSelect: (selected) {
                      startDateC.text = selected?.formatDate ?? '';
                      request.startTime = selected;
                    },
                  ),
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'تاريخ نهاية الرحلة',
                  controller: endDateC,
                  disableAndKeepIcon: true,
                  textDirection: TextDirection.ltr,
                  iconWidget: SelectSingeDateWidget(
                    initial: request.endTime,
                    onSelect: (selected) {
                      endDateC.text = selected?.formatDate ?? '';
                      request.endTime = selected;
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'اسم الطالب',
                  // initialValue: request.collegeIdNumber,
                  controller: memberNameC,
                  onChanged: (p0) => request.memberName = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'اسم المفتش',
                  // initialValue: request.address,
                  controller: supervisorNameC,
                  onChanged: (p0) => request.supervisorName = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: Builder(builder: (context) {
                  return SpinnerWidget(
                    key: key1,
                    width: 1.0.sw,
                    items: [
                      SpinnerItem(
                        name: 'مشترك',
                        id: 1,
                        item: true,
                        isSelected: request.isSubscribed ?? false,
                      ),
                      SpinnerItem(
                        name: 'غير مشترك',
                        id: 2,
                        item: false,
                        isSelected: !(request.isSubscribed ?? true),
                      ),
                    ]..insert(
                        0,
                        SpinnerItem(
                          name: 'حالة الاشتراك في النقل',
                          id: -1,
                          isSelected: request.isSubscribed == null,
                        ),
                      ),
                    onChanged: (item) => request.isSubscribed = item.item,
                  );
                }),
              ),
            ],
          ),
          20.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MyButton(
                  width: 1.0.sw,
                  color: AppColorManager.mainColorDark,
                  text: 'فلترة',
                  onTap: () => widget.onApply?.call(request),
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyButton(
                  width: 1.0.sw,
                  color: AppColorManager.black,
                  text: 'مسح الفلاتر',
                  onTap: () {
                    setState(() {
                      request.clearFilter();
                      startDateC.text = '';
                      endDateC.text = '';

                      memberNameC.text = '';
                      supervisorNameC.text = '';

                      key1.currentState?.clearSelect();
                    });
                    widget.onApply?.call(request);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
