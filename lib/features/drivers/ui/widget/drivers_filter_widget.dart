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

class DriversFilterWidget extends StatefulWidget {
  const DriversFilterWidget({super.key, this.onApply, this.command});

  final Function(DriversFilterRequest request)? onApply;

  final Command? command;

  @override
  State<DriversFilterWidget> createState() => _DriversFilterWidgetState();
}

class _DriversFilterWidgetState extends State<DriversFilterWidget> {
  late DriversFilterRequest request;

  late final TextEditingController phoneNoC;
  late final TextEditingController nameC;
  final key1 = GlobalKey<SpinnerWidgetState>();
  final key2 = GlobalKey<SpinnerWidgetState>();
  final key3 = GlobalKey<SpinnerWidgetState>();
  final key4 = GlobalKey<SpinnerWidgetState>();
  final key5 = GlobalKey<SpinnerWidgetState>();

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
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SpinnerWidget(
                  key: key1,
                  items: DriverStatus.values.spinnerItems(
                    selected: request.status,
                  )..insert(
                      0,
                      SpinnerItem(
                          name: 'حالة السائق',
                          item: null,
                          id: -1,
                          isSelected: request.status == null),
                    ),
                  onChanged: (p0) => request.status = p0.item,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: SpinnerWidget(
                  key: key4,
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
              15.0.horizontalSpace,
              Expanded(
                child: BlocBuilder<AllCarCategoriesCubit, AllCarCategoriesInitial>(
                  builder: (context, state) {
                    if (state.statuses.isLoading) {
                      return MyStyle.loadingWidget();
                    }
                    return SpinnerWidget(
                      key: key2,
                      items: state.getSpinnerItems(selectedId: request.carCategoryId)
                        ..insert(
                          0,
                          SpinnerItem(
                              name: 'تصنيف السيارة',
                              item: null,
                              id: -1,
                              isSelected: request.carCategoryId == null),
                        ),
                      width: 1.0.sw,
                      onChanged: (spinnerItem) {
                        request.carCategoryId = spinnerItem.id;
                      },
                    );
                  },
                ),
              ),
              if (!isAgency) ...[
                15.0.horizontalSpace,
                Expanded(
                  child: BlocBuilder<AgenciesCubit, AgenciesInitial>(
                    builder: (context, state) {
                      if (state.statuses.isLoading) {
                        return MyStyle.loadingWidget();
                      }
                      return SpinnerWidget(
                        key: key3,
                        items: state.getSpinnerItems(selectedId: request.agencyId)
                          ..insert(
                            0,
                            SpinnerItem(
                                name: 'الوكيل',
                                item: null,
                                id: -1,
                                isSelected: request.agencyId == null),
                          ),
                        width: 1.0.sw,
                        onChanged: (spinnerItem) {
                          request.agencyId = spinnerItem.id;
                        },
                      );
                    },
                  ),
                ),
                15.0.horizontalSpace,
                Expanded(
                  child: SpinnerWidget(
                    key: key5,
                    items: [
                      SpinnerItem(
                        name: 'المعرك يعمل',
                        item: null,
                        id: 1,
                        isSelected: request.engineStatus == true,
                      ),
                      SpinnerItem(
                        name: 'المحرك لا يعمل',
                        item: true,
                        id: 2,
                        isSelected: request.engineStatus == false,
                      ),
                    ]..insert(
                        0,
                        SpinnerItem(
                            name: 'حالة المحرك',
                            item: false,
                            id: -1,
                            isSelected: request.engineStatus == null),
                      ),
                    width: 1.0.sw,
                    onChanged: (spinnerItem) {
                      request.agencyId = spinnerItem.id;
                    },
                  ),
                ),
              ],
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
                    key2.currentState?.clearSelect();
                    key3.currentState?.clearSelect();
                    key4.currentState?.clearSelect();
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
