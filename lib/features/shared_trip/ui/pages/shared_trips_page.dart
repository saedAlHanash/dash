import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/util/my_style.dart';

import '../../bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../widget/item_shared_trip.dart';


class SharedTripsPage extends StatelessWidget {
  const SharedTripsPage({super.key});

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


          return Column(
            children: [
              DrawableText(
                text: 'الرحلات التشاركية ',
                matchParent: true,
                size: 28.0.sp,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final item = list[i];
                    return ItemSharedTrip1(item: item);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
