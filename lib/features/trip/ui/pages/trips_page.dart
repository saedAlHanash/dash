import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/filters/shared_trips_filter_widget.dart';
import 'package:qareeb_dash/features/trip/ui/widget/filters/trips_filter_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_trips_cubit/all_trips_cubit.dart';
import '../widget/filters/trips_history_filter_widget.dart';

const _tripsTableHeader = [
  'انطلاق',
  'وجهة',
  'الكلفة',
  'الزبون',
  'السائق',
  'الحالة',
  'تاريخ بداية',
  'العمليات',
];

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'الرحلات'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100.0).h,
        child: Column(
          children: [
            BlocBuilder<AllTripsCubit, AllTripsInitial>(
              builder: (context, state) {
                return TripsFilterWidget(
                  command: state.command,
                  onApply: (request) {
                    context.read<AllTripsCubit>().getAllTrips(context,
                        command: state.command.copyWith(filterTripRequest: request));
                  },
                );
              },
            ),
            BlocBuilder<AllTripsCubit, AllTripsInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }

                final list = state.result;

                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد رحلات');

                return SaedTableWidget(
                  onChangePage: (command) {
                    context
                        .read<AllTripsCubit>()
                        .getAllTrips(context, command: command);
                  },
                  fullHeight: 1.8.sh,
                  title: _tripsTableHeader,
                  data: list
                      .mapIndexed(
                        (index, e) => [
                          e.currentLocationName,
                          e.destinationName,
                          e.getTripsCost,
                          e.clientName,
                          e.driver.fullName.isEmpty ? '-' : e.driver.fullName,
                          e.tripStateName,
                          e.startDate?.formatDateTime ?? '-',
                          InkWell(
                            onTap: () {
                              context.pushNamed(GoRouteName.tripInfo,
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