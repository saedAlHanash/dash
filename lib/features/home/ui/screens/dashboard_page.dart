import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../../map/bloc/ather_cubit/ather_cubit.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../map/data/models/my_marker.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late MapControllerCubit mapControllerCubit;
  var stream = Stream.periodic(const Duration(seconds: 5));

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
                  .toList(),
              update: true,
              center: centerMarkers,
            );
            centerMarkers = false;
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              16.0.verticalSpace,
              SizedBox(
                height: 0.7.sh,
                width: 0.7.sw,
                child: MapWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
