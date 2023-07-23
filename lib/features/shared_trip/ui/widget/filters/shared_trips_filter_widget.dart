import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../../../../../core/util/checker_helper.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../../../trip/data/request/filter_trip_request.dart';

class SharedTripsFilterWidget extends StatefulWidget {
  const SharedTripsFilterWidget({super.key, this.onApply});

  final Function(FilterTripRequest request)? onApply;

  @override
  State<SharedTripsFilterWidget> createState() => _SharedTripsFilterWidgetState();
}

class _SharedTripsFilterWidgetState extends State<SharedTripsFilterWidget> {
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
              if (state.statuses.loading) {
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
        SizedBox(
          width: 200.0.w,
          child: MyTextFormNoLabelWidget(
            label: 'رقم السائق',
            maxLength: 10,
            onChanged: (val) => request.driverPhone = checkPhoneNumber(null, val),
          ),
        ),
        SizedBox(
          width: 200.0.w,
          child: MyTextFormNoLabelWidget(
            label: 'رقم الزبون',
            maxLength: 10,
            onChanged: (val) => request.clientPhone = checkPhoneNumber(null, val),
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
