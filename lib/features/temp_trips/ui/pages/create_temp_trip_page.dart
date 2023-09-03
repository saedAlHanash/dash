import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../bloc/add_point_cubit/add_point_cubit.dart';
import '../../bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import '../../bloc/temp_trip_by_id_cubit/temp_trip_by_id_cubit.dart';
import '../../data/request/create_temp_trip_request.dart';

import '../widget/path_points_widget.dart';
import '../widget/create_trip_points_widget.dart';

class CreateTempTripPage extends StatefulWidget {
  const CreateTempTripPage({super.key});

  @override
  State<CreateTempTripPage> createState() => _CreateTempTripPageState();
}

class _CreateTempTripPageState extends State<CreateTempTripPage> {
  var request = CreateTempTripRequest();
  late AddPointCubit addPointCubit;

  @override
  void initState() {
    addPointCubit = context.read<AddPointCubit>();
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
          text: 'نماذج الرحلات',
        ),
        body: BlocBuilder<TempTripBuIdCubit, TempTripBuIdInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.0.verticalSpace,
                  MyCardWidget(
                      cardColor: AppColorManager.f1,
                      margin: const EdgeInsets.symmetric(vertical: 30.0).h,
                      child: Column(
                        children: [
                          MyTextFormNoLabelWidget(
                            label: 'اسم النموذج',
                            initialValue: request.description,
                            onChanged: (p0) => request.description = p0,
                          ),
                          const Divider(),
                          SizedBox(
                            height: 500.0.h,
                            child: const CreateTempTripWidget(),
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
                                  addPointCubit.state.edgeIds.forEach(( value) {
                                    request.pathEdgesIds.add(value);
                                  });

                                  if (request.validateRequest(context)) {
                                    context
                                        .read<CreateTempTripCubit>()
                                        .createTempTrip(context, request: request);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      )),
                  20.0.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
