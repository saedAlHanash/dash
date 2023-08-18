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

import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../bloc/delete_bus_trip_cubit/delete_bus_trip_cubit.dart';

final _super_userList = [
  'ID',
  'اسم',
  'وصف',
  'الباصات',
  'تاريخ الرحلة',
  'وقت الرحلة',
  if(isAllowed(AppPermissions.busTrips))
  'عمليات',
];

class BusTripsPage extends StatelessWidget {
  const BusTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.busTrips)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createBusTrip),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllBusTripsCubit, AllBusTripsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;

          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
          return Column(
            children: [
              SaedTableWidget(
                command: state.command,
                title: _super_userList,
                data: list.mapIndexed(
                  (i, e) {
                    var busesS = '';
                    for (var e in e.buses) {
                      busesS+='${e.driverName}\n';
                    }
                    return [
                      e.id.toString(),
                      e.name,
                      e.description,
                      busesS,
                      '${e.startDate?.formatDate} \n\n ${e.endDate?.formatDate}spy',

                      '${e.startDate?.formatTime} \n\n ${e.endDate?.formatTime}spy',
                      if(isAllowed(AppPermissions.busTrips))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: !isAllowed(AppPermissions.busTrips)
                                ? null
                                : () {
                                    context.pushNamed(
                                      GoRouteName.createBusTrip,
                                      queryParams: {'id': e.id.toString()},
                                    );
                                  },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocConsumer<DeleteBusTripCubit, DeleteBusTripInitial>(
                              listener: (context, state) {
                                context.read<AllBusTripsCubit>().getBusTrips(context);
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
                                        .read<DeleteBusTripCubit>()
                                        .deleteBusTrip(context, id: e.id);
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
                    ];
                  },
                ).toList(),
                onChangePage: (command) {
                  context.read<AllBusTripsCubit>().getBusTrips(context, command: command);
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (context, i) {
              //       final item = list[i];
              //       return ItemBusTrip(item: item);
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
