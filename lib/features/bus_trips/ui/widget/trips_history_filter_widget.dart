import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../core/util/my_style.dart';
import '../../../../core/widgets/auto_complete_widget.dart';
import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../data/request/filter_trip_history_request.dart';

class TripsHistoryFilterWidget extends StatefulWidget {
  const TripsHistoryFilterWidget({super.key, this.onApply, this.command});

  final Function(FilterTripHistoryRequest request)? onApply;

  final Command? command;

  @override
  State<TripsHistoryFilterWidget> createState() => _TripsHistoryFilterWidgetState();
}

class _TripsHistoryFilterWidgetState extends State<TripsHistoryFilterWidget> {
  late FilterTripHistoryRequest request;

  @override
  void initState() {
    request = widget.command?.historyRequest ?? FilterTripHistoryRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<AllBusTripsCubit, AllBusTripsInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            final list = <SpinnerItem>[];
            list.addAll(state.getSpinnerItem);
            list.insert(0, SpinnerItem(name: 'الرحلة', id: -1));
            list.forEachWhile(
              (e) {
                if (e.id == request.busTripId) e.isSelected = true;
                return e.isSelected;
              },
            );
            return SizedBox(
              width: 200.0.w,
              child: AutoCompleteWidget(
                hint: '',
                onTap: (item) => request.busTripId = item.id,
                listItems: list,
              ),
            );
          },
        ),
        SpinnerWidget(
          items: AttendanceType.values.spinnerItems(
            selected: [request.attendanceType],
          )..insert(0, SpinnerItem(name: 'نوع العملية', id: -1)),
          onChanged: (item) => request.attendanceType = item.item,
        ),
        StatefulBuilder(builder: (context, myState) {
          return PopupMenuButton(
            constraints: BoxConstraints(maxHeight: 1.0.sh, maxWidth: 1.0.sw),
            splashRadius: 0.001,
            color: Colors.white,
            padding: const EdgeInsets.all(5.0).r,
            elevation: 2.0,
            iconSize: 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                enabled: false,
                // row with 2 children
                child: SizedBox(
                  height: 400.0.spMin,
                  width: 300.0.spMin,
                  child: Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: SfDateRangePicker(
                        initialSelectedRange:
                            PickerDateRange(request.startTime, request.endTime),
                        maxDate: DateTime.now(),
                        viewSpacing: 0,
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs range) {
                          if (range.value is DateTime) {
                            request.startTime = range.value;
                            request.endTime = DateTime.now();
                          } else if (range.value is PickerDateRange) {
                            var val = range.value as PickerDateRange;
                            request.startTime = val.startDate;
                            request.endTime = val.endDate;
                          }
                          myState(
                            () {},
                          );
                        },
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.all(15.0).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                color: AppColorManager.offWhit.withOpacity(0.5),
              ),
              child: Row(
                children: [
                  DrawableText(
                    text: '${request.startTime?.formatDate ?? ''} '
                        '->'
                        '${request.endTime?.formatDate ?? ''}'
                        '${(request.startTime != null || request.endTime != null) ? '' : 'اختر التاريخ'}',
                    color: Colors.black,
                  ),
                  10.0.horizontalSpace,
                  Icon(
                    Icons.date_range,
                    size: 40.0.r,
                  ),
                ],
              ),
            ),
          );
        }),
        MyButton(
          width: 70.0.w,
          color: AppColorManager.mainColorDark,
          text: 'فلترة',
          onTap: () => widget.onApply?.call(request),
        ),
        20.0.horizontalSpace,
      ],
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
