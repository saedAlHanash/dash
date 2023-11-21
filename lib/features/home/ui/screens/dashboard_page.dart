import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_expansion/item_expansion.dart';
import 'package:qareeb_dash/core/widgets/my_expansion/my_expansion_widget.dart';
import 'package:qareeb_dash/features/home/data/response/home_response.dart';
import 'package:qareeb_dash/features/map/bloc/set_point_cubit/map_control_cubit.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../../map/bloc/ather_cubit/ather_cubit.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../map/data/models/my_marker.dart';
import '../../bloc/home1_cubit/home1_cubit.dart';
import '../../bloc/home_cubit/home_cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late MapControllerCubit mapControllerCubit;

  @override
  void initState() {
    mapControllerCubit = context.read<MapControllerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 128.0).w,
        child: BlocConsumer<HomeCubit, HomeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            mapControllerCubit.addMarkers(
              marker: state.result.notificationPoints
                  .map(
                    (e) => MyMarker(
                      point: e.getLatLng,
                      item: e,
                      type: MyMarkerType.point,
                      nou: e.subscriperCount as int,
                    ),
                  )
                  .toList(),
              center: true,
              update: true,
            );
            // mapControllerCubit.addHome();
          },
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.0.verticalSpace,
                BlocBuilder<Home1Cubit, Home1Initial>(
                  builder: (context, state1) {
                    return  MyExpansionWidget(
                      items: [
                        ItemExpansion(
                            body: Column(
                              children: [
                                TotalWidget(
                                  text: 'عدد باصات ${state1.result.name}',
                                  icon: Assets.iconsBuses,
                                  number: state.result.imeis.length,
                                ),
                                TotalWidget(
                                  text: 'عدد طلاب ${state1.result.name}',
                                  icon: Assets.iconsStudents,
                                  number: state.result.membersCount,
                                ),
                                TotalWidget(
                                  text:
                                      'عدد طلاب ${state1.result.name} المشتركين في النقل',
                                  icon: Assets.iconsCheckCircle,
                                  number: state.result.membersWithSubscription,
                                ),
                                TotalWidget(
                                  text:
                                      'عدد طلاب ${state1.result.name} الغير مشتركين في النقل',
                                  icon: Assets.iconsReject,
                                  number: state.result.membersWithoutSubscription,
                                ),
                              ],
                            ),
                            isExpanded: false,

                            headerText: 'التفاصيل'),

                      ],
                    );
                    return Column(
                      children: [
                        TotalWidget(
                          text: 'عدد باصات ${state1.result.name}',
                          icon: Assets.iconsBuses,
                          number: state.result.imeis.length,
                        ),
                        TotalWidget(
                          text: 'عدد طلاب ${state1.result.name}',
                          icon: Assets.iconsStudents,
                          number: state.result.membersCount,
                        ),
                        TotalWidget(
                          text: 'عدد طلاب ${state1.result.name} المشتركين في النقل',
                          icon: Assets.iconsCheckCircle,
                          number: state.result.membersWithSubscription,
                        ),
                        TotalWidget(
                          text: 'عدد طلاب ${state1.result.name} الغير مشتركين في النقل',
                          icon: Assets.iconsReject,
                          number: state.result.membersWithoutSubscription,
                        ),
                      ],
                    );
                  },
                ),
                16.0.verticalSpace,
                if (isAllowed(AppPermissions.home)) ...[
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
                        BlocProvider(create: (_) => sl<MapControlCubit>()),
                        BlocProvider(create: (_) => sl<AtherCubit>()),
                      ],
                      child: BusesMap(data: state.result),
                    ),
                  ),
                  50.0.verticalSpace,
                ],
                if (isAllowed(AppPermissions.membersPoints))
                  DrawableText(
                    text: 'نقاط الطلاب',
                    size: 24.0.sp,
                    fontFamily: FontManager.cairoBold,
                  ),
                10.0.verticalSpace,
                if (isAllowed(AppPermissions.membersPoints))
                  SizedBox(
                    height: 500.0.h,
                    child: const MapWidget(),
                  ),
                100.0.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.number,
  });

  final String text;
  final String icon;
  final num number;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          Expanded(
            child: DrawableText(
              text: text,
              color: Colors.black,
              fontFamily: FontManager.cairoBold,
              drawablePadding: 10.0.w,
              drawableStart: ImageMultiType(
                url: icon,
                width: 35.0.r,
                height: 35.0.r,
              ),
            ),
          ),
          DrawableText(
            text: number.toString(),
            color: Colors.black,
            fontFamily: FontManager.cairoBold,
          ),
          40.0.horizontalSpace,
        ],
      ),
    );
  }
}

class BusesMap extends StatefulWidget {
  const BusesMap({super.key, required this.data});

  final HomeResult data;

  @override
  State<BusesMap> createState() => _BusesMapState();
}

class _BusesMapState extends State<BusesMap> {
  late MapControllerCubit mapControllerCubit;

  var stream = Stream.periodic(const Duration(seconds: 10));

  bool centerMarkers = true;

  @override
  void initState() {
    mapControllerCubit = context.read<MapControllerCubit>();
    context
        .read<AllBusesCubit>()
        .getBuses(
          context,
          command: Command.noPagination(),
        )
        .then((value) {
      if (mounted) {
        context.read<AtherCubit>().getDriverLocation();
      }

      stream.takeWhile((element) {
        return mounted;
      }).listen((event) {
        if (!mounted) return;
        context.read<AtherCubit>().getDriverLocation();
      });
    });

    listString = widget.data.getCurrentTripIme;
    super.initState();
  }

  var listString = <String>[];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AtherCubit, AtherInitial>(
          listener: (context, state) {
            mapControllerCubit.addMarkers(
              marker: state.result.mapIndexed(
                (i, e) {
                  return MyMarker(
                    point: e.getLatLng(),
                    item: context.read<AllBusesCubit>().getBusByImei(e),
                    bearing: -e.angle,
                    type: MyMarkerType.bus,
                    nou: widget.data.getCountByImei(e.ime),
                    key: e.ime,
                  );
                },
              ).toList()
                ..removeWhere((element) => element.point.latitude == 0),
              update: true,
              center: centerMarkers,
            );
            centerMarkers = false;
          },
        ),
      ],
      child: const MapWidget(),
    );
  }
}
