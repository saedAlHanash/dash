import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/data/models/my_marker.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_route_pages.dart';
import '../../../drivers/bloc/drivers_imiei_cubit/drivers_imei_cubit.dart';
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
  var tripId = 0;

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();
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
            if(state.getImeisListString.isEmpty)return;
            final l = await AtherCubit.getDriverLocationApi(state.getImeisListString);
            mapController.addMarkers(
              marker: (l.first ?? []).mapIndexed(
                (i, e) {
                  final driver =
                      context.read<CandidateDriversCubit>().state.getIdByImei(e.ime);
                  return MyMarker(
                    key: driver?.driverId,
                    point: e.getLatLng(),
                    markerSize: Size(100.0.r, 100.0.r),
                    costumeMarker: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(GoRouteName.driverInfo,
                                queryParams: {'id': driver?.driverId.toString()});
                          },
                          child: Transform.rotate(
                            angle: -e.angle,
                            child: ImageMultiType(
                              url: Assets.iconsLocator,
                              height: 50.0.spMin,
                              width: 50.0.spMin,
                              color: AppColorManager.mainColorDark,
                            ),
                          ),
                        ),
                        5.0.verticalSpace,
                        DrawableText(
                          text: driver?.driver.name ?? '-',
                          color: Colors.black,
                          size: 14.0.sp,
                          fontFamily: FontManager.cairoBold.name,
                        ),
                      ],
                    ),
                  );
                },
              ).toList()
                ..removeWhere((element) => element.point.latitude == 0),
              update: true,
              centerZoom: true,
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(),
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
