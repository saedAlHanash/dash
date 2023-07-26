import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
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
import '../../bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../bloc/create_bus_cubit/create_bus_cubit.dart';
import '../../data/request/create_bus_request.dart';
import '../../data/response/buses_response.dart';



class CreateBusPage extends StatefulWidget {
  const CreateBusPage({super.key, this.bus});

  final BusModel? bus;

  @override
  State<CreateBusPage> createState() => _CreateBusPageState();
}

class _CreateBusPageState extends State<CreateBusPage> {
  var request = CreateBusRequest();

  @override
  void initState() {
    if (widget.bus != null) {
      request = CreateBusRequest().fromBus(widget.bus!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateBusCubit, CreateBusInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllBusesCubit>().getBuses(context);
        window.history.back();
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'الباصات',
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
                    DrawableText(
                      text: 'السائق',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'اسم السائق',
                            initialValue: request.driverName,
                            onChanged: (p0) => request.driverName = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'هاتف السائق',
                            initialValue: request.driverPhone,
                            onChanged: (p0) => request.driverPhone = p0,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    DrawableText(
                      text: 'الباص',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'موديل الباص',
                            initialValue: request.busModel,
                            onChanged: (p0) => request.busModel = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'لون الباص',
                            initialValue: request.busColor,
                            onChanged: (p0) => request.busColor = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'رقم لوحة الباص',
                            initialValue: request.busNumber,
                            onChanged: (p0) => request.busNumber = p0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'IME',
                            initialValue: request.ime,
                            onChanged: (p0) => request.ime = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد المقاعد',
                            initialValue: request.seatsNumber?.toString(),
                            onChanged: (p0) => request.seatsNumber = num.tryParse(p0),
                          ),
                        ),
                        15.0.horizontalSpace,
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
              BlocBuilder<CreateBusCubit, CreateBusInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.bus != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateBusCubit>()
                            .createBus(context, request: request);
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
