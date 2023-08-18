import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';

import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';

import '../../../buses/bloc/delete_buss_cubit/delete_buss_cubit.dart';
import '../../bloc/all_subscriptions_cubit/all_subscriptions_cubit.dart';
import '../../bloc/delete_subscription_cubit/delete_subscription_cubit.dart';

final _super_userList = [
  'ID',
  'اسم الاشتراك',
  'تاريخ البداية',
  'تاريخ النهاية',
  if (isAllowed(AppPermissions.subscriptions)) 'عمليات',
];

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.subscriptions)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createSubscription),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllSubscriptionsCubit, AllSubscriptionsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد نماذج');
          return Column(
            children: [
              DrawableText(
                text: 'نماذج الاشتراكات',
                matchParent: true,
                size: 28.0.sp,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
              ),
              SaedTableWidget(
                command: state.command,
                title: _super_userList,
                data: list
                    .mapIndexed(
                      (i, e) => [
                        e.id.toString(),
                        e.name,
                        e.supscriptionDate?.formatDate,
                        e.expirationDate?.formatDate,
                        if (isAllowed(AppPermissions.subscriptions))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap:  () {
                                        context.pushNamed(
                                          GoRouteName.createSubscription,
                                          queryParams: {'id': e.id.toString()},
                                        );
                                      },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.amber,
                                ),
                              ),
                              InkWell(
                                onTap:  () {
                                        context.pushNamed(
                                          GoRouteName.subscriptionInfo,
                                          queryParams: {'id': e.id.toString()},
                                        );
                                      },
                                child: const Icon(
                                  Icons.group_add,
                                  color: AppColorManager.mainColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocConsumer<DeleteSubscriptionCubit,
                                    DeleteSubscriptionInitial>(
                                  listener: (context, state) {
                                    context
                                        .read<AllSubscriptionsCubit>()
                                        .getSubscriptions(context);
                                  },
                                  listenWhen: (p, c) => c.statuses.done,
                                  buildWhen: (p, c) => c.id == e.id,
                                  builder: (context, state) {
                                    if (state.statuses.loading) {
                                      return MyStyle.loadingWidget();
                                    }
                                    return InkWell(
                                      onTap: () {
                                        context
                                            .read<DeleteSubscriptionCubit>()
                                            .deleteSubscription(
                                              context,
                                              id: e.id ?? -1,
                                            );
                                      },
                                      child: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                      ],
                    )
                    .toList(),
                onChangePage: (command) {
                  context
                      .read<AllSubscriptionsCubit>()
                      .getSubscriptions(context, command: command);
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (context, i) {
              //       final item = list[i];
              //       return ItemSubscription(item: item);
              //     },
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
