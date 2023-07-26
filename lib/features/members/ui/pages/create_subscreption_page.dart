import 'dart:html';

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../bloc/all_member_cubit/all_member_cubit.dart';
import '../../bloc/create_subscreption_cubit/create_subscreption_cubit.dart';
import '../../bloc/member_by_id_cubit/member_by_id_cubit.dart';
import '../../data/request/create_subcription_request.dart';

class CreateSubscriptionPage extends StatefulWidget {
  const CreateSubscriptionPage({super.key});

  @override
  State<CreateSubscriptionPage> createState() => _CreateSubscriptionPageState();
}

class _CreateSubscriptionPageState extends State<CreateSubscriptionPage> {
  var request = CreateSubscriptionRequest();

  final startDateC = TextEditingController();
  final endDateC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateSubscriptionCubit, CreateSubscriptionInitial>(
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
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'الطلاب',
        ),
        body: BlocBuilder<MemberBuIdCubit, MemberBuIdInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 20.0).r,
              child: Column(
                children: [
                  SaedTableWidget(
                      title: const ['ID', 'بداية', 'نهاية', 'الفعالية'],
                      data: state.result.subscriptions
                          .mapIndexed(
                            (i, e) => [
                              e.id.toString(),
                              e.supscriptionDate?.formatDate,
                              e.expirationDate?.formatDate,
                              (e.expirationDate?.isAfter(getServerDate) ?? false)
                                  ? 'فعال'
                                  : 'منتهي'
                            ],
                          )
                          .toList()),
                  10.0.verticalSpace,
                  MyCardWidget(
                    cardColor: AppColorManager.f1,
                    margin: const EdgeInsets.only(top: 30.0, bottom: 130.0).h,
                    child: Column(
                      children: [
                        DrawableText(
                          text: 'معلومات الاشتراك',
                          size: 25.0.sp,
                          padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                          matchParent: true,
                          drawableAlin: DrawableAlin.withText,
                          textAlign: TextAlign.start,
                          fontFamily: FontManager.cairoBold,
                          drawableEnd: SpinnerWidget(
                            items: [
                              SpinnerItem(
                                name: 'مشترك',
                                isSelected: request.isActive,
                                item: true,
                              ),
                              SpinnerItem(
                                name: 'غير مشترك',
                                isSelected: !request.isActive,
                                item: false,
                              ),
                            ],
                            onChanged: (spinnerItem) {
                              setState(() => request.isActive = spinnerItem.item);
                            },
                          ),
                        ),
                        if (request.isActive)
                          Row(
                            children: [
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'تاريخ بداية الاشتراك',
                                  controller: startDateC,
                                  disableAndKeepIcon: true,
                                  enable: request.isActive,
                                  iconWidget: SelectSingeDateWidget(
                                    initial: request.supscriptionDate,
                                    minDate: DateTime.now(),
                                    onSelect: (selected) {
                                      startDateC.text = selected?.formatDate ?? '';
                                      request.supscriptionDate = selected;
                                    },
                                  ),
                                ),
                              ),
                              15.0.horizontalSpace,
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'تاريخ نهاية الاشتراك',
                                  controller: endDateC,
                                  disableAndKeepIcon: true,
                                  enable: request.isActive,
                                  iconWidget: SelectSingeDateWidget(
                                    initial: request.expirationDate,
                                    minDate: DateTime.now(),
                                    onSelect: (selected) {
                                      endDateC.text = selected?.formatDate ?? '';
                                      request.expirationDate = selected;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        BlocBuilder<CreateSubscriptionCubit, CreateSubscriptionInitial>(
                          builder: (context, state) {
                            if (state.statuses.loading) {
                              return MyStyle.loadingWidget();
                            }
                            return MyButton(
                              text: request.isNotExpired ? 'تعديل' : 'إنشاء اشتراك',
                              onTap: () {
                                if (request.validateRequest(context)) {

                                  context
                                      .read<CreateSubscriptionCubit>()
                                      .createSubscription(context, request: request);
                                }
                              },
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
