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
import 'package:map_package/map/data/response/ather_response.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/features/drivers/bloc/drivers_imiei_cubit/drivers_imei_cubit.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/home/data/response/drivers_imei_response.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../widget/statistics_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            16.0.verticalSpace,
            if (isQareebAdmin) const LoyaltyWidget(),
            DashboardScreen(statistics: statistics),
            FutureBuilder(
              future: getBestDriver(),
              builder: (context, snapShot) {
                if (!snapShot.hasData) return MyStyle.loadingWidget();

                final bestDriver = snapShot.data!;
                if (bestDriver.driverId == 0) return 0.0.verticalSpace;
                return Column(
                  children: [
                    30.0.verticalSpace,
                    DrawableText(
                      text: 'أفضل سائق',
                      matchParent: true,
                      size: 28.0.sp,
                      textAlign: TextAlign.center,
                      padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                    ),
                    MyCardWidget(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                      child: Row(
                        children: [
                          Expanded(
                            child: DrawableText(
                              text: 'اسم السائق: ${bestDriver.driverName}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          Expanded(
                            child: DrawableText(
                              text: 'عدد الرحلات: ${bestDriver.tripsCount}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          Expanded(
                            child: DrawableText(
                              text:
                                  'عدد الرحلات التشاركية: ${bestDriver.sharedTripsCount}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          Expanded(
                            child: DrawableText(
                              text:
                                  'الكيلومترات: ${(bestDriver.totalMeters / 1000).round()}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.pushNamed(GoRouteName.driverInfo,
                                    queryParams: {'id': bestDriver.driverId.toString()});
                              },
                              icon: const Icon(Icons.info_outline_rounded))
                        ],
                      ),
                    ),
                    30.0.verticalSpace,
                  ],
                );
              },
            ),
            DrawableText(
              text: 'التتبع المباشر',
              size: 24.0.sp,
              fontFamily: FontManager.cairoBold,
            ),
            10.0.verticalSpace,
            SizedBox(
              height: 500.0.h,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => sl<MapControllerCubit>()),
                  BlocProvider(create: (_) => sl<AtherCubit>()),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 128.0).r,
                  child: const BusesMap(),
                ),
              ),
            ),
            10.0.verticalSpace,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DrawableText(
                  text: ' متاح ومحرك يعمل',
                  drawableStart: Icon(
                    Icons.circle,
                    color: AppColorManager.mainColor,
                  ),
                ),
                DrawableText(
                  text: 'متاح محرك لا يعمل',
                  drawableStart: Icon(
                    Icons.circle,
                    color: AppColorManager.ampere,
                  ),
                ),
                DrawableText(
                  text: ' غير متاح والمحرك يعمل',
                  drawableStart: Icon(
                    Icons.circle,
                    color: Colors.blue,
                  ),
                ),
                DrawableText(
                  text: ' غير متاح والمحرك لا يعمل',
                  drawableStart: Icon(
                    Icons.circle,
                    color: AppColorManager.red,
                  ),
                ),
              ],
            ),
            150.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}

Future<BestDriver> getBestDriver() async {
  final result = await APIService().getApi(url: GetUrl.bestDriver);

  if (result.statusCode == 200) {
    return BestDriverResponse.fromJson(result.json).result;
  }

  return BestDriver.fromJson({});
}

class BestDriverResponse {
  BestDriverResponse({
    required this.result,
  });

  final BestDriver result;

  factory BestDriverResponse.fromJson(Map<String, dynamic> json) {
    return BestDriverResponse(
      result: BestDriver.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class BestDriver {
  BestDriver({
    required this.driverId,
    required this.driverName,
    required this.tripsCount,
    required this.sharedTripsCount,
    required this.totalMeters,
  });

  final num driverId;
  final String driverName;
  final num tripsCount;
  final num sharedTripsCount;
  final num totalMeters;

  factory BestDriver.fromJson(Map<String, dynamic> json) {
    return BestDriver(
      driverId: json["driverId"] ?? 0,
      driverName: json["driverName"] ?? "",
      tripsCount: json["tripsCount"] ?? 0,
      sharedTripsCount: json["sharedTripsCount"] ?? 0,
      totalMeters: json["totalMeters"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "driverName": driverName,
        "tripsCount": tripsCount,
        "sharedTripsCount": sharedTripsCount,
        "totalMeters": totalMeters,
      };
}

class BusesMap extends StatefulWidget {
  const BusesMap({super.key});

  @override
  State<BusesMap> createState() => _BusesMapState();
}

class _BusesMapState extends State<BusesMap> {
  late MapControllerCubit mapControllerCubit;

  bool centerMarkers = true;

  @override
  void initState() {
    mapControllerCubit = context.read<MapControllerCubit>();

    context.read<DriversImeiCubit>().getDriversImei(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AtherCubit, AtherInitial>(
          listener: (context, state) {
            mapControllerCubit
              ..clearMap(true)
              ..addMarkers(
                  marker: state.result.mapIndexed(
                    (i, e) {
                      final driver =
                          context.read<DriversImeiCubit>().state.getIdByImei(e.ime);
                      return MyMarker(
                        point: e.getLatLng(),
                        markerSize: Size(50.0.r, 50.0.r),
                        costumeMarker: Transform.rotate(
                          angle: -e.angle,
                          child: InkWell(
                            onTap: () {
                              context.pushNamed(GoRouteName.driverInfo,
                                  queryParams: {'id': driver?.id.toString()});
                            },
                            child: ImageMultiType(
                              url: Assets.iconsLocator,
                              height: 50.0.spMin,
                              width: 50.0.spMin,
                              color: getColor(e, driver),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList()
                    ..removeWhere((element) => element.point.latitude == 0),
                  update: true,
                  centerZoom: centerMarkers);
          },
        ),
        BlocListener<DriversImeiCubit, DriversImeiInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            if (centerMarkers) {
              context.read<AtherCubit>().getDriverLocation(state.getImeisListString);
              centerMarkers = false;
            }
            Future.delayed(
              const Duration(minutes: 1),
              () {
                context.read<AtherCubit>().getDriverLocation(state.getImeisListString);
              },
            );
          },
        )
      ],
      child: BlocBuilder<DriversImeiCubit, DriversImeiInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return const MapWidget(atherListener: false);
        },
      ),
    );
  }
}

Color getColor(Ime e, DriverImei? driver) {
  final isEnginOn = e.params.acc == '1';
  final driverUnAvailable = driver?.status == DriverStatus.unAvailable;
  if (!driverUnAvailable && isEnginOn) {
    return AppColorManager.mainColor; // متاح ومحرك يعمل
  } else if (!driverUnAvailable && !isEnginOn) {
    return AppColorManager.ampere; //متاح محرك لا يعمل
  } else if (driverUnAvailable && isEnginOn) {
    return Colors.blue; // غير متاح والمحرك يعمل
  } else {
    return AppColorManager.red; // غير متاح والمحرك لا يعمل
  }
}
