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
import '../../../members/ui/pages/create_member_page.dart';
import '../../bloc/all_subscriptions_cubit/all_subscriptions_cubit.dart';
import '../../bloc/create_subscriptions_cubit/create_subscriptions_cubit.dart';
import '../../bloc/subscriptions_by_id_cubit/subscriptions_by_id_cubit.dart';
import '../../data/response/subscriptions_response.dart';

class CreateSubscriptionPage extends StatefulWidget {
  const CreateSubscriptionPage({super.key});

  @override
  State<CreateSubscriptionPage> createState() => _CreateSubscriptionPageState();
}

class _CreateSubscriptionPageState extends State<CreateSubscriptionPage> {
  var request = SubscriptionModel();

  final supscriptionDateC = TextEditingController();
  final expirationDateC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateSubscriptionCubit, CreateSubscriptionInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AllSubscriptionsCubit>().getSubscriptions(context);
            window.history.back();
          },
        ),
        BlocListener<SubscriptionBuIdCubit, SubscriptionBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            setState(() {
              request = state.result;
              supscriptionDateC.text = request.supscriptionDate?.formatDate ?? '';
              expirationDateC.text = request.expirationDate?.formatDate ?? '';
            });
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'نماذج الرحلات',
        ),
        body: BlocBuilder<SubscriptionBuIdCubit, SubscriptionBuIdInitial>(
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
                      ],
                    ),
                    30.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'تاريخ بداية الاشتراك',
                            controller: supscriptionDateC,
                            disableAndKeepIcon: true,
                            textDirection: TextDirection.ltr,
                            iconWidget: SelectSingeDateWidget(
                              initial: request.supscriptionDate,
                              minDate: DateTime.now(),
                              onSelect: (selected) {
                                supscriptionDateC.text = selected?.formatDate ?? '';
                                request.supscriptionDate = selected;
                              },
                            ),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'تاريخ نهاية الاشتراك',
                            controller: expirationDateC,
                            disableAndKeepIcon: true,
                            textDirection: TextDirection.ltr,
                            iconWidget: SelectSingeDateWidget(
                              initial: request.expirationDate,
                              minDate: DateTime.now(),
                              onSelect: (selected) {
                                expirationDateC.text = selected?.formatDate ?? '';
                                request.expirationDate = selected;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    10.0.verticalSpace,
                    BlocBuilder<CreateSubscriptionCubit, CreateSubscriptionInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButton(
                          text: request.id == null ? 'إنشاء' : 'تعديل',
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
            );
          },
        ),
      ),
    );
  }
}
