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

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';

import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../bloc/delete_bus_trip_cubit/delete_bus_trip_cubit.dart';
import '../../bloc/trip_history_cubit/trip_history_cubit.dart';

final _super_userList = [
  'ID',
  'اسم الطالب',
  'اسم الرحلة',
  'اسم الباص',
  'نوع العملية',
  'حالة اشتراك الطالب',
  'تاريخ العملية',
];

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(
        builder: (context, mState) {
          return FloatingActionButton(
            onPressed: () {
              mState(() => loading = true);
              context.read<AllTripHistoryCubit>().getTripHistoryAsync(context).then(
                (value) {
                  if (value == null) return;
                  saveXls(header: value.first, data: value.second);
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
      body: SingleChildScrollView(
        child: Column(
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
                if (list.isEmpty) return const NotFoundWidget(text: 'يرجى إضافة رحلات');
                return SaedTableWidget(
                  command: state.command,
                  title: _super_userList,
                  data: list
                      .mapIndexed(
                        (i, e) => [
                          e.id.toString(),
                          e.busMember.fullName,
                          e.busTrip.name,
                          e.bus.driverName,
                          e.attendanceType.arabicName,
                          e.isSubscribed
                              ? const DrawableText(
                                  text: 'مشترك',
                                  matchParent: true,
                                  color: AppColorManager.mainColor,
                                  textAlign: TextAlign.center,
                                )
                              : const DrawableText(
                                  text: 'غير مشترك',
                                  color: Colors.red,
                                  matchParent: true,
                                  textAlign: TextAlign.center,
                                ),
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
      ),
    );
  }
}
