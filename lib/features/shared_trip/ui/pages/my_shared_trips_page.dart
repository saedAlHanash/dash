import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../widget/item_shared_trip.dart';


class MySharedTripsPage extends StatefulWidget {
  const MySharedTripsPage({super.key});

  @override
  State<MySharedTripsPage> createState() => _MySharedTripsPageState();
}

class _MySharedTripsPageState extends State<MySharedTripsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: SharedTripsTapScreen(),
    );
  }
}

class SharedTripsTapScreen extends StatefulWidget {
  const SharedTripsTapScreen({super.key});

  @override
  State<SharedTripsTapScreen> createState() => _SharedTripsTapScreenState();
}

class _SharedTripsTapScreenState extends State<SharedTripsTapScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    context.read<GetSharedTripsCubit>().getSharesTrip(context);

    Future.delayed(const Duration(seconds: 1), () {
      context.read<GetSharedTripsCubit>().getSharesTrip(context, tripState: [
        SharedTripStatus.canceled,
        SharedTripStatus.closed,
      ]);

    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0).w,
      child: Column(
        children: [
          20.0.verticalSpace,
          Container(
            height: 42.h,
            decoration: BoxDecoration(
              boxShadow: MyStyle.lightShadow,
              color: AppColorManager.whit,
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0.r),
                color: AppColorManager.mainColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColorManager.mainColor,
              tabs: const [
                Tab(text: 'الحالية'),
                Tab(text: 'السابقة'),
              ],
            ),
          ),
          10.0.verticalSpace,
          // tab bar view here
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SharedTripsScreen(),
                SharedTripsScreen(
                  status: [
                    SharedTripStatus.canceled,
                    SharedTripStatus.closed,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SharedTripsScreen extends StatelessWidget {
  const SharedTripsScreen({super.key, this.status});

  final List<SharedTripStatus>? status;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSharedTripsCubit, GetSharedTripsInitial>(
      buildWhen: (p, c) => status == null
          ? p.currentTrips.hashCode != c.currentTrips.hashCode
          : p.oldTrips.hashCode != c.oldTrips.hashCode,
      builder: (context, state) {
        if (state.statuses.isLoading) return MyStyle.loadingWidget();
        if ((state.currentTrips.isEmpty && status == null) ||
            (state.oldTrips.isEmpty && status != null)) {
          return const NotFoundWidget(text: 'لا يوجد رحلات');
        }

        final list = status == null ? state.currentTrips : state.oldTrips;

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) => ItemSharedTrip(trip: list[i]),
        );
      },
    );
  }
}
