import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../bloc/add_point_cubit/add_point_cubit.dart';
import '../../bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import '../../data/request/create_temp_trip_request.dart';
import '../../data/response/temp_trips_response.dart';
import 'create_shred_trip_page.dart';

class CreateTempTripPage extends StatefulWidget {
  const CreateTempTripPage({super.key, this.tempTrip});

  final TempTripModel? tempTrip;

  @override
  State<CreateTempTripPage> createState() => _CreateTempTripPageState();
}

class _CreateTempTripPageState extends State<CreateTempTripPage> {
  var request = CreateTempTripRequest();
  late AddPointCubit addPointCubit;

  @override
  void initState() {
    addPointCubit = context.read<AddPointCubit>();

    if (widget.tempTrip != null) {
      request = CreateTempTripRequest().fromTempTrip(widget.tempTrip!);
      addPointCubit.fromTempModel(model: widget.tempTrip!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTempTripCubit, CreateTempTripInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllTempTripsCubit>().getTempTrips(context);
        window.history.back();
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'نماذج الرحلات',
        ),
        body: SingleChildScrollView(
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
                  ],
                ),
              ),
              BlocBuilder<CreateTempTripCubit, CreateTempTripInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.tempTrip != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      addPointCubit.state.edgeIds.forEach((key, value) {
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
              20.0.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
