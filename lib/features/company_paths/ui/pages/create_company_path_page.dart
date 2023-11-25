import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/features/companies/bloc/companies_cubit/companies_cubit.dart';
import 'package:qareeb_models/extensions.dart';
import "package:universal_html/html.dart";

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../../shared_trip/bloc/add_point_cubit/add_point_cubit.dart';
import '../../../temp_trips/ui/widget/create_trip_points_widget.dart';
import '../../bloc/all_compane_paths_cubit/all_company_paths_cubit.dart';
import '../../bloc/company_path_by_id_cubit/company_path_by_id_cubit.dart';
import '../../bloc/create_compane_path_cubit/create_company_path_cubit.dart';
import '../../bloc/estimate_cubit/estimate_company_cubit.dart';
import '../../data/request/create_company_path_request.dart';
import '../../data/request/estimate_company_request.dart';

class CreateCompanyPathPage extends StatefulWidget {
  const CreateCompanyPathPage({super.key});

  @override
  State<CreateCompanyPathPage> createState() => _CreateCompanyPathPageState();
}

class _CreateCompanyPathPageState extends State<CreateCompanyPathPage> {
  var request = CreateCompanyPathRequest();
  late final AddPointCubit addPointCubit;
  late final EstimateCompanyCubit estimateCompanyCubit;
  late final MapControllerCubit mapControllerCubit;

  @override
  void initState() {
    addPointCubit = context.read<AddPointCubit>();
    estimateCompanyCubit = context.read<EstimateCompanyCubit>();
    mapControllerCubit = context.read<MapControllerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateCompanyPathCubit, CreateCompanyPathInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AllCompanyPathsCubit>().getCompanyPaths(context);
            window.history.back();
          },
        ),
        BlocListener<AddPointCubit, AddPointInitial>(
          listener: (context, state) {
            if (state.edgeIds.isEmpty) return;

            context.read<EstimateCompanyCubit>().getEstimateCompany(
                  context,
                  request: EstimateCompanyRequest(pathEdgesIds: state.edgeIds),
                );
          },
        ),
        BlocListener<CompanyPathBuIdCubit, CompanyPathBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            request = CreateCompanyPathRequest().fromCompanyPath(state.result);
            addPointCubit.fromTempModel(model: state.result.path);
            addPointCubit.update();
            if (addPointCubit.state.addedPoints.isNotEmpty) {
              context.read<PointsCubit>().getConnectedPoints(context,
                  point: addPointCubit.state.addedPoints.last);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'مسارات الرحلات',
        ),
        body: BlocBuilder<CompanyPathBuIdCubit, CompanyPathBuIdInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyCardWidget(
                          cardColor: AppColorManager.f1,
                          margin: const EdgeInsets.only(bottom: 30.0).h,
                          child: SizedBox(
                            height: 500.0.h,
                            child: const CreateTempPathWidget(),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormNoLabelWidget(
                                label: 'اسم النموذج',
                                initialValue: request.description,
                                onChanged: (p0) => request.description = p0,
                              ),
                            ),
                            Expanded(
                              child: BlocBuilder<AllCompaniesCubit, AllCompaniesInitial>(
                                builder: (context, state) {
                                  return SpinnerOutlineTitle(
                                    width: 1.0.sw,
                                    label: 'اختر الشركة',
                                    items: state.getSpinnerItem,
                                    onChanged: (item) => request.companyId = item.id,
                                    expanded: true,
                                    sendFirstItem: true,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<CreateCompanyPathCubit, CreateCompanyPathInitial>(
                          builder: (context, state) {
                            if (state.statuses.loading) {
                              return MyStyle.loadingWidget();
                            }
                            return MyButton(
                              text: request.id != null ? 'تعديل' : 'إنشاء',
                              onTap: () {
                                request.pathEdgesIds.clear();
                                for (var value in addPointCubit.state.edgeIds) {
                                  request.pathEdgesIds.add(value);
                                }

                                if (request.validateRequest(context)) {
                                  context
                                      .read<CreateCompanyPathCubit>()
                                      .createCompanyPath(context, request: request);
                                }
                              },
                            );
                          },
                        ),
                        20.0.verticalSpace,
                      ],
                    ),
                  ),
                ),
                10.0.horizontalSpace,
                Expanded(
                  child: Column(
                    children: [
                      BlocBuilder<EstimateCompanyCubit, EstimateCompanyInitial>(
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return SaedTableWidget(
                            title: const [
                              'اسم التصنيف',
                              'السعر',
                              'المسافة',
                            ],
                            data: state.result
                                .map(
                                  (e) => [
                                    e.carCategoryName,
                                    (e.carCategorySeats * e.price).formatPrice,
                                    '${context.read<AddPointCubit>().getDistance.round()} km'
                                  ],
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
