import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../bloc/delete_temp_trip_cubit/delete_temp_trip_cubit.dart';

final _titleList = [
  'ID',
  'اسم المسار',
  'عدد النقاط',
  'طول المسار',
  // 'الوقت المقدر للمسار',
  'عمليات',
];

class TempTripsPage extends StatelessWidget {
  const TempTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(GoRouteName.createTempTrip);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<AllTempTripsCubit, AllTempTripsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'يرجى إضافة نماذج للرحلات');
          return SingleChildScrollView(
            child: SaedTableWidget(
              command: state.command,
              title: _titleList,
              data: list
                  .mapIndexed(
                    (i, e) => [
                      e.id.toString(),
                      e.arName,
                      (e.edges.length + 1).toString(),
                      '${(e.distance / 1000).round()} km',
                      // '${(e.duration / 60).round()} min',
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
                          InkWell(
                            onTap: () {
                              context.pushNamed(
                                GoRouteName.createTempTrip,
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
                            child:
                                BlocConsumer<DeleteTempTripCubit, DeleteTempTripInitial>(
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
                context.read<AllTempTripsCubit>().getTempTrips(context, command: command);
              },
            ),
          );
        },
      ),
    );
  }
}
