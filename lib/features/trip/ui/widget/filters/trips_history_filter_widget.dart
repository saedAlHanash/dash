import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../../core/util/checker_helper.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../../../trip/data/request/filter_trip_request.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../../core/api_manager/command.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/widgets/my_text_form_widget.dart';
import '../../../../../core/widgets/select_date.dart';

class TripsFilterWidget extends StatefulWidget {
  const TripsFilterWidget(
      {super.key, this.onApply, this.command, this.activeTrips = false});

  final Function(FilterTripRequest request)? onApply;

  final bool activeTrips;
  final Command? command;

  @override
  State<TripsFilterWidget> createState() => _TripsFilterWidgetState();
}

class _TripsFilterWidgetState extends State<TripsFilterWidget> {
  late FilterTripRequest request;

  late final TextEditingController startDateC;
  late final TextEditingController endDateC;
  late final TextEditingController clientIdC;
  late final TextEditingController driverIdC;
  late final TextEditingController clientNameC;
  late final TextEditingController driverNameC;
  late final TextEditingController clientPhoneC;
  late final TextEditingController driverPhoneC;

  final key1 = GlobalKey<SpinnerWidgetState>();
  final key2 = GlobalKey<SpinnerWidgetState>();

  @override
  void initState() {
    request = widget.command?.filterTripRequest ?? FilterTripRequest();
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    clientNameC = TextEditingController(text: request.clientName);
    driverNameC = TextEditingController(text: request.driverName);
    clientPhoneC = TextEditingController(text: request.clientPhone);
    driverPhoneC = TextEditingController(text: request.driverPhone);
    clientIdC = TextEditingController(text: '${request.clientId ?? ''}');
    driverIdC = TextEditingController(text: '${request.driverId ?? ''}');

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
                  label: 'معرف الزبون',
                  // initialValue: request.phoneNo,
                  controller: clientIdC,
                  onChanged: (p0) => request.clientId = int.tryParse(p0),
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'اسم الزبون',
                  // initialValue: request.phoneNo,
                  controller: clientNameC,
                  onChanged: (p0) => request.clientName = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'رقم الزبون',
                  // initialValue: request.phoneNo,
                  controller: clientPhoneC,
                  onChanged: (p0) => request.clientPhone = p0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'معرف السائق',
                  // initialValue: request.phoneNo,
                  controller: driverIdC,
                  onChanged: (p0) => request.driverId = int.tryParse(p0),
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'اسم السائق',
                  // initialValue: request.phoneNo,
                  controller: driverNameC,
                  onChanged: (p0) => request.driverName = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'رقم السائق',
                  // initialValue: request.phoneNo,
                  controller: driverPhoneC,
                  onChanged: (p0) => request.driverPhone = p0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'تاريخ بداية',
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
                  label: 'تاريخ نهاية',
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
              if (!widget.activeTrips) ...[
                15.0.horizontalSpace,
                Expanded(
                  child: SpinnerWidget(
                    key: key1,
                    width: 1.0.sw,
                    items: TripStatus.values.spinnerItems(selected: request.tripStatus)
                      ..insert(
                          0,
                          SpinnerItem(
                            name: 'حالة الرحلة',
                            id: -1,
                            isSelected: request.tripStatus == null,
                          )),
                    onChanged: (item) => request.tripStatus = item.item,
                  ),
                ),
              ],
              15.0.horizontalSpace,
              Expanded(
                child: SpinnerWidget(
                  key: key2,
                  width: 1.0.sw,
                  items: TripType.values.spinnerItems(selected: request.tripType)
                    ..insert(
                        0,
                        SpinnerItem(
                          name: 'نوع الرحلة',
                          id: -1,
                          isSelected: request.tripType == null,
                        )),
                  onChanged: (item) => request.tripType = item.item,
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
                      key1.currentState?.clearSelect();
                      key2.currentState?.clearSelect();
                      request.clearFilter();
                      startDateC.text = '';
                      endDateC.text = '';
                      clientNameC.text = '';
                      driverNameC.text = '';
                      clientPhoneC.text = '';
                      driverPhoneC.text = '';
                      clientIdC.text = '';
                      driverIdC.text = '';
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
