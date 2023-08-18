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

import '../../../buses/bloc/delete_buss_cubit/delete_buss_cubit.dart';
import '../../bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../bloc/delete_temp_trip_cubit/delete_temp_trip_cubit.dart';

final _super_userList = [
  'ID',
  'اسم النموذج',
  'المسافة الكلية',
  if(isAllowed(AppPermissions.tempTrips))
  'عمليات',
];

class TempTripsPage extends StatelessWidget {
  const TempTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  (isAllowed(AppPermissions.tempTrips))
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createTempTrip),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllTempTripsCubit, AllTempTripsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد نماذج');
          return Column(
            children: [
              DrawableText(
                text: 'نماذج الرحلات',
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
                        e.description,
                        e.distance.toString(),
                        if(isAllowed(AppPermissions.tempTrips))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                      context.pushNamed(
                                        GoRouteName.tempTripInfo,
                                        queryParams: {'id': e.id.toString()},
                                      );
                                    },
                              child: const Icon(
                                Icons.info_outline_rounded,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocConsumer<DeleteTempTripCubit,
                                  DeleteTempTripInitial>(
                                listener: (context, state) {
                                  context.read<AllTempTripsCubit>().getTempTrips(context);
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
                                          .read<DeleteTempTripCubit>()
                                          .deleteTempTrip(context, id: e.id);
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
                      .read<AllTempTripsCubit>()
                      .getTempTrips(context, command: command);
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (context, i) {
              //       final item = list[i];
              //       return ItemTempTrip(item: item);
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
