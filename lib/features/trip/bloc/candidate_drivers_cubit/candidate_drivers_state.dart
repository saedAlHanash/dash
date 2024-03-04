part of 'candidate_drivers_cubit.dart';

class CandidateDriversInitial extends Equatable {
  final CubitStatuses statuses;
  final List<CandidateDriver> result;
  final List<DriversPool> pools;
  final String error;

  const CandidateDriversInitial({
    required this.statuses,
    required this.result,
    required this.pools,
    required this.error,
  });

  factory CandidateDriversInitial.initial() {
    return const CandidateDriversInitial(
      result: <CandidateDriver>[],
      pools: <DriversPool>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  List<String> get getImeisListString {
    final l = <String>[];
    for (var e in result) {
      if (!e.isAccepted) l.add(e.driver.imei);
    }
    return l;
  }

  List<int> get getDriverIds => List<int>.from(result.map((e) => e.driverId));

  CandidateDriver? getIdByImei(String imei) =>
      result.firstWhereOrNull((e) => e.driver.imei == imei);

  Future<void> addMarkers(
    MapControllerCubit mapController,
    BuildContext context,
    DriverBuIdCubit driverBuIdCubit,
    Trip trip,
  ) async {
    pools.removeWhere((e) {
      final distance  = distanceBetween(trip.startPoint, e.point);
      print('$distance ${distance > AppSharedPreference.distanceDriverRange}');
      return distance > AppSharedPreference.distanceDriverRange;
    });

    mapController.addMarkers(
      marker: pools.mapIndexed(
        (i, e) {
          return MyMarker(
            key: e.driverId,
            point: LatLng(e.driverLat.toDouble(), e.driverLng.toDouble()),
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
                              id: e.driverId,
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
                  child: ImageMultiType(
                    url: Assets.iconsLocator,
                    height: 50.0.spMin,
                    width: 50.0.spMin,
                    color: AppColorManager.red,
                  ),
                ),
                5.0.verticalSpace,
                Container(
                  color: AppColorManager.red,
                  padding: const EdgeInsets.all(1.0).r,
                  child: DrawableText(
                    text: e.driverName,
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
    final l = await AtherCubit.getDriverLocationApi(getImeisListString);
    mapController.addMarkers(
      marker: (l.first ?? []).mapIndexed(
        (i, e) {
          final isEnginOn = e.params.acc == '1';
          final driver = getIdByImei(e.ime);
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
                              if (statuses.loading) {
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
                  color:
                      isEnginOn ? AppColorManager.mainColorDark : AppColorManager.ampere,
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
  }

  @override
  List<Object> get props => [statuses, result, error];

  CandidateDriversInitial copyWith({
    CubitStatuses? statuses,
    List<CandidateDriver>? result,
    List<DriversPool>? pools,
    String? error,
  }) {
    return CandidateDriversInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      pools: pools ?? this.pools,
      error: error ?? this.error,
    );
  }
}
