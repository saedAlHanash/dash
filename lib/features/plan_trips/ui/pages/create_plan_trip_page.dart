import 'dart:html';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_checkbox_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_models/company_paths/data/response/company_paths_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/select_date.dart';
import '../../../companies/bloc/companies_cubit/companies_cubit.dart';
import '../../../company_paths/bloc/all_compane_paths_cubit/all_company_paths_cubit.dart';
import '../../../drivers/bloc/drivers_imiei_cubit/drivers_imei_cubit.dart';
import '../../../plans/bloc/plans_cubit/plans_cubit.dart';
import '../../../temp_trips/bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../../temp_trips/data/response/temp_trips_response.dart';
import '../../bloc/all_plan_trips_cubit/all_plan_trips_cubit.dart';
import '../../bloc/plan_trip_by_id_cubit/plan_trip_by_id_cubit.dart';
import '../../bloc/create_plan_trip_cubit/create_plan_trip_cubit.dart';
import '../../data/request/create_plan_trip_request.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CreatePlanTripPage extends StatefulWidget {
  const CreatePlanTripPage({super.key, this.qareebPoints = true});

  final bool qareebPoints;

  @override
  State<CreatePlanTripPage> createState() => _CreatePlanTripPageState();
}

class _CreatePlanTripPageState extends State<CreatePlanTripPage> {
  var request = CreatePlanTripRequest();

  final startDateC = TextEditingController();
  final endDateC = TextEditingController();
  final startTimeC = TextEditingController();
  final endTimeC = TextEditingController();
  final plansesC = TextEditingController();

  late final AllCompaniesCubit allCompaniesCubit;

  @override
  void initState() {
    allCompaniesCubit = context.read<AllCompaniesCubit>();

    if (allCompaniesCubit.state.result.isEmpty) {
      allCompaniesCubit.getCompanies(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreatePlanTripCubit, CreatePlanTripInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AllPlanTripsCubit>().getPlanTrips(context);
            window.history.back();
          },
        ),
        BlocListener<PlanTripBuIdCubit, PlanTripBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            request = CreatePlanTripRequest().fromPlanTrip(state.result);

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
        body: BlocBuilder<PlanTripBuIdCubit, PlanTripBuIdInitial>(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BlocBuilder<DriversImeiCubit, DriversImeiInitial>(
                            builder: (context, state) {
                              if (state.statuses.loading) {
                                return MyStyle.loadingWidget();
                              }

                              plansesC.text =
                                  state.getNames(request.driversIds).toString();

                              return MultiSelectDialogField(
                                buttonText: const Text('السائقين'),
                                searchable: true,
                                items: state.getSpinnerItem.mapIndexed(
                                  (i, e) {
                                    return MultiSelectItem<int>(e.id, e.name ?? '');
                                  },
                                ).toList(),
                                initialValue: request.driversIds,
                                onConfirm: (values) {
                                  request.driversIds
                                    ..clear()
                                    ..addAll(values);
                                  plansesC.text =
                                      state.getNames(request.driversIds).toString();
                                },
                              );
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child:
                              BlocBuilder<AllCompanyPathsCubit, AllCompanyPathsInitial>(
                            builder: (context, state) {
                              if (state.statuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              return SpinnerOutlineTitle(
                                sendFirstItem: true,
                                width: double.infinity,
                                items: state.getSpinnerItems(
                                    selectedId: (request.companyPathId ?? -1) as int),
                                label: 'مسار الرحلة',
                                onChanged: (spinnerItem) {
                                  var tempTrip = spinnerItem.item as CompanyPath;
                                  request.companyPathId = tempTrip.id;
                                },
                              );
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: BlocBuilder<AllCompaniesCubit, AllCompaniesInitial>(
                            builder: (context, state) {
                              return SpinnerOutlineTitle(
                                width: 1.0.sw,
                                label: 'اختر الشركة',
                                items:
                                    state.getSpinnerItems(selectedId: request.companyId),
                                onChanged: (item) => request.companyId = item.id,
                                expanded: true,
                                sendFirstItem: true,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60.0).h,
                      child: MyCheckboxWidget(
                        width: .1.sw,
                        items:
                            WeekDays.values.spinnerItemsList(selected: request.getDays),
                        onSelectGetListItems: (list) {
                          request.getDays.clear();
                          request.getDays
                              .addAll(list.map((e) => (e.item as WeekDays)).toList());
                        },
                      ),
                    ),
                    10.0.verticalSpace,
                    BlocBuilder<CreatePlanTripCubit, CreatePlanTripInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButton(
                          text: 'إنشاء',
                          onTap: () {
                            if (request.validateRequest(context)) {
                              context
                                  .read<CreatePlanTripCubit>()
                                  .createPlanTrip(context, request: request);
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
