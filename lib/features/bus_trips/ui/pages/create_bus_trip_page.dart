import 'dart:html';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_checkbox_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../../members/ui/pages/create_member_page.dart';
import '../../../temp_trips/bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../../temp_trips/data/response/temp_trips_response.dart';
import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../bloc/bus_trip_by_id_cubit/bus_trip_by_id_cubit.dart';
import '../../bloc/create_bus_trip_cubit/create_bus_trip_cubit.dart';
import '../../data/request/create_bus_trip_request.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CreateBusTripPage extends StatefulWidget {
  const CreateBusTripPage({super.key});

  @override
  State<CreateBusTripPage> createState() => _CreateBusTripPageState();
}

class _CreateBusTripPageState extends State<CreateBusTripPage> {
  var request = CreateBusTripRequest();

  final startDateC = TextEditingController();
  final endDateC = TextEditingController();
  final startTimeC = TextEditingController();
  final endTimeC = TextEditingController();
  final bussesC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateBusTripCubit, CreateBusTripInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AllBusTripsCubit>().getBusTrips(context);
            window.history.back();
          },
        ),
        BlocListener<BusTripBuIdCubit, BusTripBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            request = CreateBusTripRequest().fromBusTrip(state.result);

            startDateC.text = request.startDate?.formatDate ?? '';
            endDateC.text = request.endDate?.formatDate ?? '';
            startTimeC.text = request.startDate?.formatTime ?? '';
            endTimeC.text = request.endDate?.formatTime ?? '';
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'الرحلات',
        ),
        body: BlocBuilder<BusTripBuIdCubit, BusTripBuIdInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 70.0).r,
              child: MyCardWidget(
                cardColor: AppColorManager.f1,
                margin: const EdgeInsets.symmetric(vertical: 30.0).h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'اسم ',
                            initialValue: request.name,
                            onChanged: (p0) => request.name = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'وصف',
                            initialValue: request.description,
                            onChanged: (p0) => request.description = p0,
                          ),
                        ),
                      ],
                    ),
                    30.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'تاريخ بداية الرحلة',
                            controller: startDateC,
                            disableAndKeepIcon: true,
                            textDirection: TextDirection.ltr,
                            iconWidget: SelectSingeDateWidget(
                              initial: request.startDate,
                              minDate: DateTime.now(),
                              onSelect: (selected) {
                                startDateC.text = selected?.formatDate ?? '';
                                request.startDate = selected;
                              },
                            ),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'تاريخ نهاية الرحلة',
                            controller: endDateC,
                            disableAndKeepIcon: true,
                            textDirection: TextDirection.ltr,
                            iconWidget: SelectSingeDateWidget(
                              initial: request.endDate,
                              minDate: DateTime.now(),
                              onSelect: (selected) {
                                endDateC.text = selected?.formatDate ?? '';
                                request.endDate = selected;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    30.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'وقت بداية الرحلة',
                            controller: startTimeC,
                            disableAndKeepIcon: true,
                            textDirection: TextDirection.ltr,
                            iconWidget: IconButton(
                                onPressed: () async {
                                  var s = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        request.startDate ?? DateTime.now()),
                                  );
                                  setState(() {
                                    request.startDate = request.startDate
                                        ?.copyWith(hour: s?.hour, minute: s?.minute);
                                    startTimeC.text = request.startDate?.formatTime ?? '';
                                  });
                                },
                                icon: const Icon(Icons.timer_outlined)),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'وقت نهاية الرحلة',
                            controller: endTimeC,
                            disableAndKeepIcon: true,
                            textDirection: TextDirection.ltr,
                            iconWidget: IconButton(
                                onPressed: () async {
                                  var s = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        request.endDate ?? DateTime.now()),
                                  );
                                  setState(() {
                                    request.endDate = request.endDate
                                        ?.copyWith(hour: s?.hour, minute: s?.minute);
                                    endTimeC.text = request.endDate?.formatTime ?? '';
                                  });
                                },
                                icon: const Icon(Icons.timer_outlined)),
                          ),
                        ),
                      ],
                    ),
                    30.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<AllBusesCubit, AllBusesInitial>(
                            builder: (context, state) {
                              if (state.statuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              bussesC.text =
                                  state.getNames(request.busesId).toString();

                              void showMultiSelect() async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  // required for min/max child size
                                  context: context,
                                  builder: (ctx) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 200.0).r,
                                      child: MultiSelectBottomSheet<int>(
                                        searchable: true,
                                        items: state.getSpinnerItem.mapIndexed(
                                          (i, e) {
                                            return MultiSelectItem<int>(e.id, e.name);
                                          },
                                        ).toList(),
                                        initialValue: request.busesId,
                                        onConfirm: (values) {
                                          request.busesId
                                            ..clear()
                                            ..addAll(values);
                                          bussesC.text =
                                              state.getNames(request.busesId).toString();
                                        },
                                      ),
                                    );
                                  },
                                );
                              }

                              return MyTextFormNoLabelWidget(
                                label: 'وقت نهاية الرحلة',
                                controller: bussesC,
                                disableAndKeepIcon: true,
                                textDirection: TextDirection.ltr,
                                iconWidget: IconButton(
                                    onPressed: () async {
                                      showMultiSelect();
                                    },
                                    icon: const Icon(Icons.bus_alert_rounded)),
                              );
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: BlocBuilder<AllTempTripsCubit, AllTempTripsInitial>(
                            builder: (context, state) {
                              if (state.statuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              return SpinnerOutlineTitle(
                                sendFirstItem: true,
                                width: double.infinity,
                                items: state.getSpinnerItem,
                                label: 'نموذج الرحلة',
                                onChanged: (spinnerItem) {
                                  var tempTrip = spinnerItem.item as TempTripModel;
                                  request.tripTemplateId = tempTrip.id;
                                  request.pathId = tempTrip.pathId;
                                  request.distance = tempTrip.distance;
                                },
                              );
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: SpinnerOutlineTitle(
                            sendFirstItem: true,
                            width: double.infinity,
                            label: 'نوع الرحلة',
                            items: BusTripType.values
                                .spinnerItems(selected: [request.busTripType]),
                            onChanged: (spinnerItem) =>
                                request.busTripType = spinnerItem.item,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0).h,
                      child: MyCheckboxWidget(
                        width: .1.sw,
                        items: WeekDays.values.spinnerItems(selected: request.days),
                        onSelectGetListItems: (list) {
                          request.getDays.clear();
                          request.getDays
                              .addAll(list.map((e) => (e.item as WeekDays)).toList());
                        },
                      ),
                    ),
                    10.0.verticalSpace,
                    BlocBuilder<CreateBusTripCubit, CreateBusTripInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButton(
                          text: 'إنشاء',
                          onTap: () {
                            if (request.validateRequest(context)) {
                              context
                                  .read<CreateBusTripCubit>()
                                  .createBusTrip(context, request: request);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
