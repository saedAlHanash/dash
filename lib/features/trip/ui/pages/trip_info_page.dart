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
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/features/drivers/bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import 'package:qareeb_dash/features/drivers/ui/pages/driver_info_page.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

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
            if (state.result.tripStatus == TripStatus.pending) {
              context.read<DriversImeiCubit>().getDriversImei(
                    context,
                    startPoint: trip.startPoint,
                    status: DriverStatus.unAvailable,
                  );
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
            final l = await AtherCubit.getDriverLocationApi(state.getImeisListString);
            mapController.addMarkers(
              marker: (l.first ?? []).mapIndexed(
                (i, e) {
                  final isEnginOn = e.params.acc == '1';
                  final driver =
                      context.read<CandidateDriversCubit>().state.getIdByImei(e.ime);
                  return MyMarker(
                    key: driver?.driverId,
                    point: e.getLatLng(),
                    markerSize: Size(120.0.r, 120.0.r),
                    costumeMarker: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            NoteMessage.showMyDialog(context,
                                child: BlocProvider.value(
                                  value: driverBuIdCubit
                                    ..getDriverBuId(
                                      context,
                                      id: driver!.driverId.toInt(),
                                    ),
                                  child: BlocBuilder<DriverBuIdCubit, DriverBuIdInitial>(
                                    builder: (context, state) {
                                      if (state.statuses.loading) {
                                        return MyStyle.loadingWidget();
                                      }
                                      return DriverTableInfo(driver: state.result);
                                    },
                                  ),
                                ));
                          },
                          child: Transform.rotate(
                            angle: -e.angle,
                            child: ImageMultiType(
                              url: Assets.iconsLocator,
                              height: 50.0.spMin,
                              width: 50.0.spMin,
                              color: isEnginOn
                                  ? AppColorManager.mainColorDark
                                  : AppColorManager.ampere,
                            ),
                          ),
                        ),
                        5.0.verticalSpace,
                        Container(
                          color: isEnginOn
                              ? AppColorManager.mainColorDark
                              : AppColorManager.ampere,
                          padding: const EdgeInsets.all(1.0).r,
                          child: DrawableText(
                            text: driver?.driver.name ?? '-',
                            color: Colors.white,
                            size: 17.0.sp,
                            fontFamily: FontManager.cairoBold.name,
                          ),
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
        BlocListener<DriversImeiCubit, DriversImeiInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) async {
            if (state.getImeisListString.isEmpty) return;
            mapController.addMarkers(
              marker: state.atherResult.mapIndexed(
                (i, e) {
                  final driver =
                      context.read<DriversImeiCubit>().state.getIdByImei(e.ime);
                  return MyMarker(
                    key: driver?.id,
                    point: e.getLatLng(),
                    markerSize: Size(120.0.r, 120.0.r),
                    costumeMarker: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            NoteMessage.showMyDialog(context,
                                child: BlocProvider.value(
                                  value: driverBuIdCubit
                                    ..getDriverBuId(
                                      context,
                                      id: driver!.id,
                                    ),
                                  child: BlocBuilder<DriverBuIdCubit, DriverBuIdInitial>(
                                    builder: (context, state) {
                                      if (state.statuses.loading) {
                                        return MyStyle.loadingWidget();
                                      }
                                      return DriverTableInfo(driver: state.result);
                                    },
                                  ),
                                ));
                          },
                          child: Transform.rotate(
                            angle: -e.angle,
                            child: ImageMultiType(
                              url: Assets.iconsLocator,
                              height: 50.0.spMin,
                              width: 50.0.spMin,
                              color: AppColorManager.red,
                            ),
                          ),
                        ),
                        5.0.verticalSpace,
                        Container(
                          color: AppColorManager.red,
                          padding: const EdgeInsets.all(1.0).r,
                          child: DrawableText(
                            text: driver?.name ?? '-',
                            color: Colors.white,
                            size: 16.0.sp,
                            maxLines: 1,
                            fontFamily: FontManager.cairoBold.name,
                          ),
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
