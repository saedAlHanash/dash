import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_dash/features/trip/bloc/nav_trip_cubit/nav_trip_cubit.dart';

import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../map/ui/widget/map_widget.dart';
import '../../bloc/trip_by_id/trip_by_id_cubit.dart';
import '../widget/trip_widget.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  ///map controller cubit init when stat is initial
  late MapControllerCubit mapController;

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();

    final trip = AppSharedPreference.getCashedTrip();

    if (trip.id != 0) {
      initTrip();
    } else {
      context.read<NavTripCubit>().changeScreen(NavTrip.waiting);
    }

    super.initState();
  }

  void initTrip() {
    final tripState = AppSharedPreference.getTripState();

    context.read<NavTripCubit>().changeScreen(tripState);

    if (tripState != NavTrip.waiting) {
      final trip = AppSharedPreference.getCashedTrip();
      mapController.addTrip(trip: trip);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripByIdCubit, TripByIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) => initTrip(),
        ),
        BlocListener<NavTripCubit, NavTripInitial>(
          listener: (context, state) {
            if (state.navState == NavTrip.waiting) {
            } else {
              mapController.addTrip(trip: AppSharedPreference.getCashedTrip());
            }
          },
        )
      ],
      child: const Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            Expanded(child: MapWidget()),
            TripWidget(),
          ],
        ),
      ),
    );
  }
}
