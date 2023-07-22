import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/trip/ui/widget/filters/trips_filter_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../router/go_route_pages.dart';
import '../../../admins/ui/widget/admin_data_grid.dart';
import '../../bloc/all_trips_cubit/all_trips_cubit.dart';

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
      body: Column(
        children: [
          DrawableText(
            text: 'الرحلات ',
            matchParent: true,
            size: 28.0.sp,
            textAlign: TextAlign.center,
            padding: const EdgeInsets.symmetric(vertical: 15.0).h,
          ),
          TripsFilterWidget(
            onApply: (request) {
              context.read<AllTripsCubit>().getAllTrips(context, filter: request);
            },
          ),
          const Divider(),
          Expanded(
            child: BlocBuilder<AllTripsCubit, AllTripsInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }

                final list = state.result;

                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد رحلات');

                return SingleChildScrollView(
                  child: SaedTableWidget(
                    title: _tripsTableHeader,
                    data: list
                        .mapIndexed(
                          (index, e) => [
                            e.currentLocationName,
                            e.destinationName,
                            e.getTripsCost,
                            e.clientName,
                            e.driver.name.isEmpty ? '-' : e.driver.name,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
