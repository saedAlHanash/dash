import 'dart:html';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/all_member_cubit/all_member_cubit.dart';
import '../../bloc/create_subscreption_cubit/create_subscreption_cubit.dart';
import '../../bloc/member_by_id_cubit/member_by_id_cubit.dart';
import '../../data/request/create_subcription_request.dart';

class CreateSubscriptionPage1 extends StatefulWidget {
  const CreateSubscriptionPage1({super.key});

  @override
  State<CreateSubscriptionPage1> createState() => _CreateSubscriptionPage1State();
}

class _CreateSubscriptionPage1State extends State<CreateSubscriptionPage1> {
  var request = CreateSubscriptionRequest();

  final startDateC = TextEditingController();
  final endDateC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateSubscriptionCubit1, CreateSubscriptionInitial1>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AllMembersCubit>().getMembers(context);
            window.history.back();
          },
        ),
        BlocListener<MemberBuIdCubit, MemberBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            request = CreateSubscriptionRequest.fromMember(state.result);

            if (!request.isNotExpired) request.id = null;
            startDateC.text = request.supscriptionDate?.formatDate ?? '';
            endDateC.text = request.expirationDate?.formatDate ?? '';
          },
        ),
      ],
      child: BlocBuilder<MemberBuIdCubit, MemberBuIdInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 128.0, vertical: 20.0).r,
            child: Column(
              children: [
                SaedTableWidget(
                    fullHeight: 0.4.sh,
                    title: const ['ID', 'بداية', 'نهاية', 'الفعالية'],
                    data: state.result.subscriptions
                        .mapIndexed(
                          (i, e) => [
                            e.id.toString(),
                            e.supscriptionDate?.formatDate,
                            e.expirationDate?.formatDate,
                            e.isActive
                                ? (e.expirationDate?.isAfter(getServerDate) ?? false)
                                    ? 'فعال'
                                    : 'منتهي'
                                : 'ملغي'
                          ],
                        )
                        .toList()),
                10.0.verticalSpace,
                MyCardWidget(
                  cardColor: AppColorManager.f1,
                  margin: const EdgeInsets.only(top: 30.0, bottom: 30.0).h,
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: MyTextFormNoLabelWidget(
                      //         label: 'تاريخ بداية الاشتراك',
                      //         controller: startDateC,
                      //         disableAndKeepIcon: true,
                      //         enable: request.isActive,
                      //         iconWidget: SelectSingeDateWidget(
                      //           initial: request.supscriptionDate,
                      //           minDate: DateTime.now(),
                      //           onSelect: (selected) {
                      //             startDateC.text = selected?.formatDate ?? '';
                      //             request.supscriptionDate = selected;
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //     15.0.horizontalSpace,
                      //     Expanded(
                      //       child: MyTextFormNoLabelWidget(
                      //         label: 'تاريخ نهاية الاشتراك',
                      //         controller: endDateC,
                      //         disableAndKeepIcon: true,
                      //         enable: request.isActive,
                      //         iconWidget: SelectSingeDateWidget(
                      //           initial: request.expirationDate,
                      //           minDate: DateTime.now(),
                      //           onSelect: (selected) {
                      //             endDateC.text = selected?.formatDate ?? '';
                      //             request.expirationDate = selected;
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      BlocBuilder<CreateSubscriptionCubit1, CreateSubscriptionInitial1>(
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // MyButton(
                              //   text: request.isNotExpired ? 'تعديل' : 'إنشاء',
                              //   onTap: () {
                              //     if (request.validateRequest(context)) {
                              //       context
                              //           .read<CreateSubscriptionCubit1>()
                              //           .createSubscription(context, request: request);
                              //     }
                              //   },
                              // ),
                              // 20.0.horizontalSpace,
                              if (isAllowed(AppPermissions.subscriptions))
                              if (request.isNotExpired)
                                MyButton(
                                  textColor: Colors.white,
                                  color: Colors.black,
                                  text: 'إلغاء الاشتراك',
                                  onTap: () {
                                    context
                                        .read<CreateSubscriptionCubit1>()
                                        .createSubscription(
                                          context,
                                          request: request..isActive = false,
                                        );
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SelectSingeDateWidget extends StatelessWidget {
  const SelectSingeDateWidget({
    super.key,
    this.onSelect,
    this.initial,
    this.maxDate,
    this.minDate,
  });

  final DateTime? initial;
  final DateTime? maxDate;
  final DateTime? minDate;
  final Function(DateTime? selected)? onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      constraints: BoxConstraints(maxHeight: 1.0.sh, maxWidth: 1.0.sw),
      splashRadius: 0.001,
      color: Colors.white,
      padding: const EdgeInsets.all(5.0).r,
      elevation: 2.0,
      iconSize: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0.r),
      ),
      itemBuilder: (context) {
        return [
          // PopupMenuItem 1
          PopupMenuItem(
            value: 1,
            enabled: false,
            // row with 2 children
            child: SizedBox(
              height: 400.0.spMin,
              width: 300.0.spMin,
              child: Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: SfDateRangePicker(
                    initialSelectedDate: initial,
                    maxDate: maxDate,
                    minDate: minDate,
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs range) {
                      if (range.value is DateTime) {
                        onSelect?.call(range.value);
                        Navigator.pop(context);
                      } else if (range.value is PickerDateRange) {}
                    },
                    selectionMode: DateRangePickerSelectionMode.single,
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      child: Container(
        padding: const EdgeInsets.all(15.0).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0.r),
          color: AppColorManager.offWhit.withOpacity(0.5),
        ),
        child: Icon(
          Icons.date_range,
          size: 40.0.r,
        ),
      ),
    );
  }
}
