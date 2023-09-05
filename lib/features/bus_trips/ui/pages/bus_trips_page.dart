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
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';

import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../bloc/delete_bus_trip_cubit/delete_bus_trip_cubit.dart';
import '../widget/trips_filter_widget.dart';

final _super_userList = [
  'ID',
  'اسم',
  'وصف',
  'الباصات',
  'تاريخ الرحلة',
  'وقت الرحلة',
  'عدد اشتراكات الطلاب',
  'حالة الرحلة الآن',
  if (isAllowed(AppPermissions.busTrips)) 'عمليات',
];

class BusTripsPage extends StatefulWidget {
  const BusTripsPage({super.key});

  @override
  State<BusTripsPage> createState() => _BusTripsPageState();
}

class _BusTripsPageState extends State<BusTripsPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.busTrips)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () => context.pushNamed(GoRouteName.createBusTrip),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                10.0.verticalSpace,
                StatefulBuilder(
                  builder: (context, mState) {
                    return FloatingActionButton(
                      onPressed: () {
                        mState(() => loading = true);
                        context.read<AllBusTripsCubit>().getBusAsync(context).then(
                          (value) {
                            if (value == null) return;
                            saveXls(
                              header: value.first,
                              data: value.second,
                              fileName: 'تقرير الرحلات ${DateTime.now().formatDate}',
                            );
                            mState(() => loading = false);
                          },
                        );
                      },
                      child: loading
                          ? const CircularProgressIndicator.adaptive()
                          : const Icon(Icons.file_download, color: Colors.white),
                    );
                  },
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AllBusTripsCubit, AllBusTripsInitial>(
              builder: (context, state) {
                return TripsFilterWidget(
                  command: state.command,
                  onApply: (request) {
                    context.read<AllBusTripsCubit>().getBusTrips(
                          context,
                          command:
                              context.read<AllBusTripsCubit>().state.command.copyWith(
                                    tripsFilterRequest: request,
                                    skipCount: 0,
                                    totalCount: 0,
                                  ),
                        );
                  },
                );
              },
            ),
            BlocBuilder<AllBusTripsCubit, AllBusTripsInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;

                if (list.isEmpty) return const NotFoundWidget(text: 'يرجى إضافة رحلات');
                return SaedTableWidget(
                  command: state.command,
                  title: _super_userList,
                  data: list.mapIndexed(
                    (i, e) {
                      var busesS = '';
                      for (var e in e.buses) {
                        busesS += '${e.driverName}\n';
                      }
                      return [
                        e.id.toString(),
                        e.name,
                        e.description,
                        busesS,
                        '${e.startDate?.formatDate} \n\n ${e.endDate?.formatDate}',
                        '${e.startDate?.formatTime} \n\n ${e.endDate?.formatTime}',
                        e.numberOfParticipation.toString(),
                        e.isActive ? 'جارية' : 'مؤجلة',
                        if (isAllowed(AppPermissions.busTrips))
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
                                child: BlocConsumer<DeleteBusTripCubit,
                                    DeleteBusTripInitial>(
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
                    context
                        .read<AllBusTripsCubit>()
                        .getBusTrips(context, command: command);
                  },
                );
              },
            ),
            50.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
