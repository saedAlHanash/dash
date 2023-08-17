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

import '../../bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../bloc/delete_super_user_cubit/delete_super_user_cubit.dart';




final _super_userList = [
  'ID',
  'اسم المشرف',
  'رقم هاتف المشرف',
  'باص المشرف',
  'عمليات',
];

class SuperUsersPage extends StatelessWidget {
  const SuperUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createSuperUsers),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllSuperUsersCubit, AllSuperUsersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
          return Column(
            children: [
              DrawableText(
                text: 'الأجهزة اللوحية',
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
                        e.id.toString(),
                        e.fullName,
                        e.phone,
                        e.bus.driverName,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: !isAllowed(AppPermissions.UPDATE)
                                  ? null
                                  : () {
                                      context.pushNamed(GoRouteName.createSuperUsers,
                                          extra: e);
                                    },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocConsumer<DeleteSuperUserCubit,
                                  DeleteSuperUserInitial>(
                                listener: (context, state) {
                                  context
                                      .read<AllSuperUsersCubit>()
                                      .getSuperUsers(context);
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
                                          .read<DeleteSuperUserCubit>()
                                          .deleteSuperUsers(context, id: e.id);
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
                      .read<AllSuperUsersCubit>()
                      .getSuperUsers(context, command: command);
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (context, i) {
              //       final item = list[i];
              //       return ItemSuperUsers(item: item);
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
