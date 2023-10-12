import "package:universal_html/html.dart";

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../../shared_trip/bloc/add_point_cubit/add_point_cubit.dart';
import '../../bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import '../../bloc/estimate_cubit/estimate_cubit.dart';
import '../../bloc/temp_trip_by_id_cubit/temp_trip_by_id_cubit.dart';
import '../../data/request/create_temp_trip_request.dart';
import '../../data/request/estimate_request.dart';
import '../widget/create_trip_points_widget.dart';

class CreateTempTripPage extends StatefulWidget {
  const CreateTempTripPage({super.key});

  @override
  State<CreateTempTripPage> createState() => _CreateTempTripPageState();
}

class _CreateTempTripPageState extends State<CreateTempTripPage> {
  var request = CreateTempTripRequest();
  late final AddPointCubit addPointCubit;
  late final MapControllerCubit mapControllerCubit;

  @override
  void initState() {
    addPointCubit = context.read<AddPointCubit>();
    mapControllerCubit = context.read<MapControllerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateTempTripCubit, CreateTempTripInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AllTempTripsCubit>().getTempTrips(context);
            window.history.back();
          },
        ),
        BlocListener<AddPointCubit, AddPointInitial>(
          listener: (context, state) {
            if (state.edgeIds.isEmpty) return;

            context.read<EstimateCubit>().getEstimate(
                  context,
                  request: EstimateRequest(pathEdgesIds: state.edgeIds),
                );
          },
        ),
        BlocListener<TempTripBuIdCubit, TempTripBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            request = CreateTempTripRequest().fromTempTrip(state.result);
            addPointCubit.fromTempModel(model: state.result);
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
        body: BlocBuilder<TempTripBuIdCubit, TempTripBuIdInitial>(
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
                            child: const CreateTempTripWidget(),
                          ),
                        ),
                        MyTextFormNoLabelWidget(
                          label: 'اسم النموذج',
                          initialValue: request.arName,
                          onChanged: (p0) => request.arName = p0,
                        ),
                        BlocBuilder<CreateTempTripCubit, CreateTempTripInitial>(
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
                                      .read<CreateTempTripCubit>()
                                      .createTempTrip(context, request: request);
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
                Expanded(
                  child: Column(
                    children: [
                      BlocBuilder<EstimateCubit, EstimateInitial>(
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return SaedTableWidget(
                            title: const [
                              'اسم التصنيف',
                              'السعر الأدنى',
                              'السعر الوسطي',
                              'السعر الأعلى',
                              'المسافة',
                            ],
                            data: state.result
                                .map(
                                  (e) => [
                                    e.carCategoryName,
                                    (e.carCategorySeats * e.prices[0]).formatPrice,
                                    (e.carCategorySeats * e.prices[1]).formatPrice,
                                    (e.carCategorySeats * e.prices[2]).formatPrice,
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
