import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/select_date.dart';
import '../../data/request/plan_attendances_filter.dart';

class AttendancesFilterWidget extends StatefulWidget {
  const AttendancesFilterWidget({super.key, this.onApply, this.command});

  final Function(PlanAttendanceFilter request)? onApply;

  final Command? command;

  @override
  State<AttendancesFilterWidget> createState() => _AttendancesFilterWidgetState();
}

class _AttendancesFilterWidgetState extends State<AttendancesFilterWidget> {
  late PlanAttendanceFilter request;

  late final TextEditingController startDateC;
  late final TextEditingController endDateC;
  late final TextEditingController driverNameC;
  late final TextEditingController companyNameC;
  late final TextEditingController userNameC;
  final key1 = GlobalKey<SpinnerWidgetState>();
  final key2 = GlobalKey<SpinnerWidgetState>();
  final key3 = GlobalKey<SpinnerWidgetState>();
//driverName
// companyName
// userName
  @override
  void initState() {
    request = widget.command?.planAttendanceFilter ?? PlanAttendanceFilter();
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    driverNameC = TextEditingController(text: request.driverName);
    companyNameC = TextEditingController(text: request.companyName);
    userNameC = TextEditingController(text: request.userName);
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
                label: 'اسم الشركة',
                // initialValue: request.collegeIdNumber,
                controller: companyNameC,
                onChanged: (p0) => request.companyName = p0,
              ),
            ),
            15.0.horizontalSpace,
            Expanded(
              child: MyTextFormNoLabelWidget(
                label: 'معرف الشركة',
                onChanged: (p0) => request.companyId = int.tryParse(p0),
              ),
            ),
            15.0.horizontalSpace,
            Expanded(
              child: MyTextFormNoLabelWidget(
                label: 'اسم الزبون',
                // initialValue: request.address,
                controller: userNameC,
                onChanged: (p0) => request.userName = p0,
              ),
            ),
            15.0.horizontalSpace,
            Expanded(
              child: MyTextFormNoLabelWidget(
                label: 'معرف الزبون',
                // initialValue: request.facility,
                onChanged: (p0) => request.userId = int.tryParse(p0),
              ),
            ),
          ],
        ),

          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'اسم السائق',
                  // initialValue: request.collegeIdNumber,
                  controller: driverNameC,
                  onChanged: (p0) => request.driverName = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'معرف السائق',
                  onChanged: (p0) => request.driverId = int.tryParse(p0),
                ),
              ),
              15.0.horizontalSpace,
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
                    driverNameC.text = '';
                    companyNameC.text = '';
                    userNameC.text = '';
                    key1.currentState?.clearSelect();
                    key2.currentState?.clearSelect();
                    key3.currentState?.clearSelect();
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
