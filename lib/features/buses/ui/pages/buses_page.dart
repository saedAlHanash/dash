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

import '../../bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../bloc/delete_buss_cubit/delete_buss_cubit.dart';




final _super_userList = [
  'ID',
  'اسم الباص',
  'رقم هاتف السائق',
  'IME',
  if(isAllowed(AppPermissions.buses))
  'عمليات',
];

class BusesPage extends StatelessWidget {
  const BusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.buses)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createBus),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllBusesCubit, AllBusesInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
          return Column(
            children: [
              DrawableText(
                text: 'الباصات',
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
                        e.driverName,
                        e.driverPhone,
                        e.ime,
                        if(isAllowed(AppPermissions.buses))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                      context.pushNamed(GoRouteName.createBus,
                                          extra: e);
                                    },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocConsumer<DeleteBusCubit,
                                  DeleteBusInitial>(
                                listener: (context, state) {
                                  context
                                      .read<AllBusesCubit>()
                                      .getBuses(context);
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
                                          .read<DeleteBusCubit>()
                                          .deleteBus(context, id: e.id);
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
                      .read<AllBusesCubit>()
                      .getBuses(context, command: command);
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (context, i) {
              //       final item = list[i];
              //       return ItemBus(item: item);
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
