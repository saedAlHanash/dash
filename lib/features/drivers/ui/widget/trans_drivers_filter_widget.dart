import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../agencies/bloc/agencies_cubit/agencies_cubit.dart';
import '../../../car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../data/request/drivers_filter_request.dart';

class TransDriversFilterWidget extends StatefulWidget {
  const TransDriversFilterWidget({super.key, this.onApply, this.command});

  final Function(DriversFilterRequest request)? onApply;

  final Command? command;

  @override
  State<TransDriversFilterWidget> createState() => _TransDriversFilterWidgetState();
}

class _TransDriversFilterWidgetState extends State<TransDriversFilterWidget> {
  late DriversFilterRequest request;

  late final TextEditingController phoneNoC;
  late final TextEditingController nameC;
  final key1 = GlobalKey<SpinnerWidgetState>();

  @override
  void initState() {
    request = widget.command?.driversFilterRequest ?? DriversFilterRequest();

    phoneNoC = TextEditingController(text: request.phoneNo);
    nameC = TextEditingController(text: request.name);
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
                  label: 'الاسم',
                  // initialValue: request.collegeIdNumber,
                  controller: nameC,
                  onChanged: (p0) => request.name = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'رقم الهاتف',
                  // initialValue: request.address,
                  controller: phoneNoC,
                  onChanged: (p0) => request.phoneNo = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: SpinnerWidget(
                  key: key1,
                  items: [
                    SpinnerItem(
                        name: 'حالة الفحص',
                        item: null,
                        id: -1,
                        isSelected: request.isExamined == null),
                    SpinnerItem(
                      name: 'تم الفحص',
                      item: true,
                      id: 1,
                      isSelected: request.isExamined == true,
                    ),
                    SpinnerItem(
                      name: 'لم يتم الفحص',
                      item: false,
                      id: 2,
                      isSelected: request.isExamined == false,
                    ),
                  ],
                  onChanged: (p0) => request.isExamined = p0.item,
                ),
              ),

            ],
          ),

          5.0.verticalSpace,
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
                      phoneNoC.text = request.phoneNo ?? '';
                      nameC.text = request.name ?? '';
                    });
                    widget.onApply?.call(request);
                    key1.currentState?.clearSelect();
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
