import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/features/members/ui/pages/memberss_page.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../bloc/add_from_template_cubit/add_from_template_cubit.dart';
import '../../bloc/all_member_without_subscription_cubit/all_member_without_subscription_cubit.dart';
import '../../bloc/all_subscriber_cubit/all_subscriber_cubit.dart';
import '../../bloc/create_subscriptions_cubit/create_subscriptions_cubit.dart';
import '../../data/request/add_from_template.dart';

class SubscriptionInfoPage extends StatefulWidget {
  const SubscriptionInfoPage({super.key, required this.id});

  final int id;

  @override
  State<SubscriptionInfoPage> createState() => _CreateSubscriptionPageState();
}

class _CreateSubscriptionPageState extends State<SubscriptionInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  final selected = <int>[];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFromTemplateCubit, AddFromTemplateInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        NoteMessage.showDoneDialog(
          context,
          text: 'تم التحديث بنجاح',
          onCancel: () => window.history.back(),
        );
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'معلومات الاشتراك',
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<AddFromTemplateCubit, AddFromTemplateInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return MyButton(
                  text: 'تحديث',
                  onTap: () {
                    final request = CreateFromTemplate();
                    request.templateId = widget.id;
                    request.memberIds.addAll(selected);
                    context.read<AddFromTemplateCubit>().addFromTemplate(
                          context,
                          request: request,
                        );
                  },
                );
              },
            ),
            10.0.verticalSpace,
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AllSubscriberCubit, AllSubscriberInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    var q = '';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawableText(
                          fontFamily: FontManager.cairoBold,
                          text:
                              'الطلاب المشتركين بهذا النموذج   ( ${state.result.length} طالب )',
                          color: Colors.black,
                        ),
                        StatefulBuilder(builder: (context, mState) {
                          return SaedTableWidget(
                            command: state.command,
                            onChangePage: (command) {
                              context.read<AllSubscriberCubit>().getSubscriber(context,
                                  tId: widget.id, command: command);
                            },
                            filters: Row(
                              children: [
                                SizedBox(
                                  width: 250.0.w,
                                  child: MyTextFormNoLabelWidget(
                                    hint: 'بحث',
                                    iconWidget: const Icon(Icons.search),
                                    onChanged: (val) => mState(() => q = val),
                                  ),
                                ),
                              ],
                            ),
                            fullHeight: 0.6.sh,
                            title: const [
                              'ID',
                              'اسم الطالب',
                              'الكلية',
                              'رقم هاتف',
                              'عمليات',
                            ],
                            data: state
                                .filter(q)
                                .map(
                                  (e) => [
                                    e.id.toString(),
                                    e.fullName,
                                    e.facility,
                                    e.phoneNo,
                                    IconButton(
                                      onPressed: () {
                                        dialogSubscription(context, e.id);
                                      },
                                      icon: const Icon(
                                        Icons.info_outline_rounded,
                                      ),
                                    ),
                                  ],
                                )
                                .toList(),
                          );
                        }),
                      ],
                    );
                  },
                ),
                const Divider(),
                const DrawableText(
                    fontFamily: FontManager.cairoBold,
                    text: 'الطلاب الغير مشتركين ',
                    color: Colors.black),
                BlocBuilder<AllMemberWithoutSubscriptionCubit,
                    AllMemberWithoutSubscriptionInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    var q = '';
                    return StatefulBuilder(builder: (context, mState) {
                      return SaedTableWidget(

                        filters: Row(
                          children: [
                            SizedBox(
                              width: 250.0.w,
                              child: MyTextFormNoLabelWidget(
                                hint: 'بحث',
                                iconWidget: const Icon(Icons.search),
                                onChanged: (val) => mState(() => q = val),
                              ),
                            ),
                          ],
                        ),
                        fullHeight: 0.6.sh,
                        title: const [
                          'ID',
                          'اسم الطالب',
                          'الكلية',
                          'رقم هاتف',
                          'مشترك؟',
                        ],
                        data: state
                            .filter(q)
                            .map(
                              (e) => [
                                e.id.toString(),
                                e.fullName,
                                e.facility,
                                e.phoneNo,
                                StatefulBuilder(builder: (context, myState) {
                                  return Checkbox(
                                    value: selected.contains(e.id),
                                    onChanged: (value) {
                                      myState(
                                        () {
                                          if (value ?? false) {
                                            selected.add(e.id);
                                          } else {
                                            selected.remove(e.id);
                                          }
                                        },
                                      );
                                    },
                                  );
                                }),
                              ],
                            )
                            .toList(),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
