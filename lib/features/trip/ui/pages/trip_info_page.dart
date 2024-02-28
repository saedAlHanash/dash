import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/features/drivers/bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../bloc/candidate_drivers_cubit/candidate_drivers_cubit.dart';
import '../../bloc/trip_by_id/trip_by_id_cubit.dart';
import '../../bloc/trip_status_cubit/trip_status_cubit.dart';
import '../widget/trip_info_list_widget.dart';

class TripInfoPage extends StatefulWidget {
  const TripInfoPage({Key? key}) : super(key: key);

  @override
  State<TripInfoPage> createState() => _TripInfoPageState();
}

class _TripInfoPageState extends State<TripInfoPage> {
  late final MapControllerCubit mapController;
  late final DriverBuIdCubit driverBuIdCubit;
  var tripId = 0;
  late Trip trip;

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();
    driverBuIdCubit = context.read<DriverBuIdCubit>();
    super.initState();
  }

  @override
  void dispose() {
    MapWidget.initImeis([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripByIdCubit, TripByIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            trip = state.result;
            tripId = state.result.id;
            mapController.addTrip(trip: state.result);
            if (state.result.driver.id > 0) {
              MapWidget.initImeis([state.result.driver.imei]);
            }
          },
        ),
        BlocListener<ChangeTripStatusCubit, ChangeTripStatusInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<TripByIdCubit>().tripById(context, tripId: tripId);
          },
        ),
        BlocListener<CandidateDriversCubit, CandidateDriversInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) async {
            if (state.getImeisListString.isEmpty) return;
            state.addMarkers(mapController, context, driverBuIdCubit, trip);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(actions: [
          IconButton(
            onPressed: () =>
                context.read<TripByIdCubit>().tripById(context, tripId: tripId),
            icon: const ImageMultiType(
              url: Icons.refresh,
              color: AppColorManager.mainColor,
            ),
          )
        ]),
        body: Row(
          children: [
            Expanded(
              flex: 6,
              child: BlocBuilder<TripByIdCubit, TripByIdInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return TripInfoListWidget(trip: state.result);
                },
              ),
            ),
            20.0.horizontalSpace,
            const Expanded(
              flex: 4,
              child: MapWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
