import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';

import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../admins/ui/widget/admin_data_grid.dart';
import '../../bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../../data/response/shared_trip.dart';
import '../widget/item_shared_trip.dart';

const _tripsTableHeader = [
  'السائق',
  'المقاعد المحجوزة',
  'كلفة المقعد',
  'تاريخ',
  'الحالة',
  'العمليات',
];

class SharedTripsPage extends StatefulWidget {
  const SharedTripsPage({super.key});

  @override
  State<SharedTripsPage> createState() => _SharedTripsPageState();
}

class _SharedTripsPageState extends State<SharedTripsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetSharedTripsCubit, GetSharedTripsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }

          final list = state.currentTrips;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد رحلات تشاركية');

          return SaedTableWidget(
            title: _tripsTableHeader,
            data: list
                .mapIndexed(
                  (index, e) => [
                    e.driver.name,
                    e.reservedSeats.toString(),
                    (e.seatCost).formatPrice,
                    e.schedulingDate?.formatDateTime ?? '',
                    SharedTripStatus.values[e.status()].sharedTripName(),
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
    );
  }


}
