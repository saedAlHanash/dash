import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/bus_trips/ui/widget/trips_history_filter_widget.dart';

import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';

import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../bloc/delete_bus_trip_cubit/delete_bus_trip_cubit.dart';
import '../../bloc/trip_history_cubit/trip_history_cubit.dart';

final _super_userList = [
  'ID',
  'اسم الطالب',
  'اسم الرحلة',
  'رقم الباص',
  'نوع العملية',
  'حالة اشتراك الطالب',
  'تاريخ العملية',
];

class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TripsHistoryFilterWidget(
            onApply: (request) {
              context.read<AllTripHistoryCubit>().getTripHistory(
                    context,
                    command: context.read<AllTripHistoryCubit>().state.command.copyWith(
                          historyRequest: request,
                          skipCount: 0,
                          totalCount: 0,
                        ),
                  );
            },
          ),
          BlocBuilder<AllTripHistoryCubit, AllTripHistoryInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              final list = state.result;
              if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد سجل');
              return SaedTableWidget(
                command: state.command,
                title: _super_userList,
                data: list
                    .mapIndexed(
                      (i, e) => [
                        e.id.toString(),
                        e.busMember.fullName,
                        e.busTrip.name,
                        e.busTrip.name,
                        e.attendanceType.arabicName,
                        e.isParticipated ? 'مشترك' : 'غير مشترك',
                        e.date?.formatDateTime,
                      ],
                    )
                    .toList(),
                onChangePage: (command) {
                  context
                      .read<AllTripHistoryCubit>()
                      .getTripHistory(context, command: command);
                },
              );
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
      ),
    );
  }
}
