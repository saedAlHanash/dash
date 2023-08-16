import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/features/map/bloc/set_point_cubit/map_control_cubit.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../../map/bloc/ather_cubit/ather_cubit.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../map/data/models/my_marker.dart';
import '../../bloc/home_cubit/home_cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late MapControllerCubit mapControllerCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<HomeCubit, HomeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {},
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                20.0.verticalSpace,
                _TotalWidget(
                  text: 'عدد باصاتك',
                  icon: Assets.iconsBuses,
                  number: state.result.imeis.length,
                ),
                _TotalWidget(
                  text: 'عدد طلابك',
                  icon: Assets.iconsStudents,
                  number: state.result.membersCount,
                ),
                16.0.verticalSpace,
                Row(
                  children: [
                    const Expanded(
                      child: DrawableText(text: 'نقاط الطلاب'),
                    ),
                    50.0.horizontalSpace,
                    const Expanded(
                      child: DrawableText(text: 'التتبع المباشر'),
                    ),
                  ],
                ),
                10.0.verticalSpace,
                SizedBox(
                  height: 500.0.h,
                  child: Row(
                    children: [
                      const Expanded(
                        child: MapWidget(),
                      ),
                      50.0.horizontalSpace,
                      Expanded(
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (_) => sl<MapControllerCubit>()),
                            BlocProvider(create: (_) => sl<MapControlCubit>()),
                            BlocProvider(create: (_) => sl<AtherCubit>()),
                          ],
                          child: const BusesMap(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TotalWidget extends StatelessWidget {
  const _TotalWidget({
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
  const BusesMap({super.key});

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
      context.read<AtherCubit>().getDriverLocation();

      stream.takeWhile((element) {
        return mounted;
      }).listen((event) {
        if (!mounted) return;
        context.read<AtherCubit>().getDriverLocation();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AtherCubit, AtherInitial>(
          listener: (context, state) {
            mapControllerCubit.addMarkers(
              marker: state.result
                  .mapIndexed(
                    (i, e) => MyMarker(
                      point: e.getLatLng(),
                      item: e,
                      bearing: -e.angle,
                      type: MyMarkerType.bus,
                      key: e.ime,
                    ),
                  )
                  .toList()
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
