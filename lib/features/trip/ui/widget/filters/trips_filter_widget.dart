import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../core/util/my_style.dart';
import '../../../../car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../../../drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../../data/request/filter_trip_request.dart';

class TripsFilterWidget extends StatefulWidget {
  const TripsFilterWidget({super.key, this.onApply});

  final Function(FilterTripRequest request)? onApply;

  @override
  State<TripsFilterWidget> createState() => _TripsFilterWidgetState();
}

class _TripsFilterWidgetState extends State<TripsFilterWidget> {
  var request = FilterTripRequest();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilterItem(
          title: 'حسب السائق',
          child: BlocBuilder<AllDriversCubit, AllDriversInitial>(
            builder: (context, state) {
              if (state.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }
              final list = <SpinnerItem>[];
              list.addAll(state.getSpinnerItem);
              list.insert(0, SpinnerItem(name: 'اختر سائق', id: -1));
              for (var e in list) {
                if (e.id == request.driverId) {
                  e.isSelected = true;
                  break;
                }
              }
              return SpinnerWidget(
                items: list,
                onChanged: (spinnerItem) => request.driverId = spinnerItem.id,
              );
            },
          ),
        ),
        FilterItem(
          title: 'حسب تصنيف السيارة',
          child: BlocBuilder<AllCarCategoriesCubit, AllCarCategoriesInitial>(
            builder: (context, state) {
              if (state.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }

              final list = <SpinnerItem>[];
              list.addAll(state.getSpinnerItem);
              list.insert(0, SpinnerItem(name: 'اختر تصنيف', id: -1));

              for (var e in list) {
                if (e.id == request.carCategoryId) {
                  e.isSelected = true;
                  break;
                }
              }
              return SpinnerWidget(
                items: list,
                onChanged: (spinnerItem) => request.carCategoryId = spinnerItem.id,
              );
            },
          ),
        ),
        FilterItem(
          title: 'حسب مجال من التاريخ',
          child: PopupMenuButton(
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
                  const DrawableText(
                    text: 'اختر التاريخ',
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
          ),
        ),
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
