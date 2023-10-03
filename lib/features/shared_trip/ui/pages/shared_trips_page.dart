import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../widget/filters/shared_trips_filter_widget.dart';

const _tripsTableHeader = [
  'السائق',
  'المقاعد المحجوزة',
  'كلفة المقعد',
  'تاريخ',
  'الحالة',
  'العمليات',
];

class SharedTripsPage extends StatefulWidget {
  const SharedTripsPage({super.key, this.isClientTrips});

  final bool? isClientTrips;

  @override
  State<SharedTripsPage> createState() => _SharedTripsPageState();
}

class _SharedTripsPageState extends State<SharedTripsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'الرحلات التشاركية '),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100.0).h,
        child: Column(
          children: [
            BlocBuilder<GetSharedTripsCubit, GetSharedTripsInitial>(
              builder: (context, state) {
                return TripsFilterWidget(
                  command: state.command,
                  onApply: (request) {
                    context.read<GetSharedTripsCubit>().getSharesTrip(
                          context,
                          command: state.command.copyWith(
                            filterTripRequest: request,
                            skipCount: 0,
                            totalCount: 0,
                          ),
                        );
                  },
                );
              },
            ),
            BlocBuilder<GetSharedTripsCubit, GetSharedTripsInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }

                final list = state.currentTrips;
                if (list.isEmpty) {
                  return const NotFoundWidget(text: 'لا يوجد رحلات تشاركية');
                }

                return SaedTableWidget(
                  fullHeight: 1.8.sh,
                  onChangePage: (command) {
                    context
                        .read<GetSharedTripsCubit>()
                        .getSharesTrip(context, command: command);
                  },
                  title: _tripsTableHeader,
                  data: list
                      .mapIndexed(
                        (index, e) => [
                          e.driver.fullName,
                          e.reservedSeats.toString(),
                          (e.seatCost).formatPrice,
                          e.schedulingDate?.formatDateTime ?? '',
                          e.tripStatus.arabicName,
                          InkWell(
                            onTap: () {
                              context.pushNamed(GoRouteName.sharedTripInfo,
                                  queryParams: {'id': e.id.toString()});
                            },
                            child: const CircleButton(
                              color: Colors.grey,
                              icon: Icons.info_outline_rounded,
                            ),
                          ),
                        ],
                      )
                      .toList(),
                  command: state.command,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension SharedTripStatusHelper on SharedTripStatus {
  String get arabicName {
    switch (this) {
      case SharedTripStatus.pending:
        return 'لم تبدأ';
      case SharedTripStatus.started:
        return 'جارية';
      case SharedTripStatus.closed:
        return 'منتهية';
      case SharedTripStatus.canceled:
        return 'ملغية';
    }
  }
}
