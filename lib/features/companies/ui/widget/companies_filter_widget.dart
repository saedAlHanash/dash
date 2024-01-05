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
import '../../bloc/companies_cubit/companies_cubit.dart';
import '../../data/request/companies_filter_request.dart';


class CompanyPathesFilterWidget extends StatefulWidget {
  const CompanyPathesFilterWidget({super.key, this.onApply, this.command});

  final Function(CompaniesFilterRequest request)? onApply;

  final Command? command;

  @override
  State<CompanyPathesFilterWidget> createState() => _CompanyPathesFilterWidgetState();
}

class _CompanyPathesFilterWidgetState extends State<CompanyPathesFilterWidget> {
  late CompaniesFilterRequest request;

  late final TextEditingController nameC;
  final key1 = GlobalKey<SpinnerWidgetState>();


  @override
  void initState() {
    request = widget.command?.companiesFilterRequest ?? CompaniesFilterRequest();
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
                  label: 'اسم المسار',
                  // initialValue: request.collegeIdNumber,
                  controller: nameC,
                  onChanged: (p0) => request.name = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: BlocBuilder<AllCompaniesCubit, AllCompaniesInitial>(
                  builder: (context, state) {
                    if (state.statuses.isLoading) {
                      return MyStyle.loadingWidget();
                    }
                    return SpinnerWidget(
                      key: key1,
                      items: state.getSpinnerItems(selectedId: request.companyId)
                        ..insert(
                          0,
                          SpinnerItem(
                              name: 'الشركة',
                              item: null,
                              /*id: -1,*/
                              isSelected: request.companyId == null),
                        ),
                      width: 1.0.sw,
                      onChanged: (spinnerItem) {
                        request.companyId = spinnerItem.id;
                      },
                    );
                  },
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
