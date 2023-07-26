import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';

import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/all_member_cubit/all_member_cubit.dart';

final _super_userList = [
  'عمليات',
  'ID',
  'اسم الطالب',
  'عنوان الطالب',
  'حالة الاشتراك في النقل',
  'عمليات الاشتراكات',
];

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createMember),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllMembersCubit, AllMembersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
          return Column(
            children: [
              DrawableText(
                text: 'الطلاب',
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
                      (index, e) => [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: !isAllowed(AppPermissions.UPDATE)
                                  ? null
                                  : () {
                                context.pushNamed(GoRouteName.createMember,
                                    queryParams: {'id': e.id.toString()});
                                    },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        e.id.toString(),
                        e.fullName,
                        e.address,
                        (e.subscriptions.isEmpty)
                            ? 'غير مشترك'
                            : e.subscriptions.lastOrNull!.isActive
                                ? 'مشترك'
                                : 'اشتراك منتهي',
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: !isAllowed(AppPermissions.UPDATE)
                                  ? null
                                  : () {
                                      context.pushNamed(GoRouteName.createSubscription,
                                          queryParams: {'id': e.id.toString()});
                                    },
                              child: const Icon(
                                Icons.edit_calendar,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: !isAllowed(AppPermissions.CREATION) ? null : () {
                                context.pushNamed(GoRouteName.createSubscription,
                                    queryParams: {'id': e.id.toString()});
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    .toList(),
                onChangePage: (command) {
                  context.read<AllMembersCubit>().getMembers(context, command: command);
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (context, i) {
              //       final item = list[i];
              //       return ItemMember(item: item);
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
