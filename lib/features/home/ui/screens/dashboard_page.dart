import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';

import '../../../../core/strings/enum_manager.dart';
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
  var stream = Stream.periodic(const Duration(seconds: 30));

  @override
  void initState() {
    mapControllerCubit = context.read<MapControllerCubit>();

    context.read<AtherCubit>().getAll();

    stream.takeWhile((element) {
      return mounted;
    }).listen((event) {
      if (!mounted) return;
      context.read<AtherCubit>().getAll();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AtherCubit, AtherInitial>(
      listener: (context, state) {
        mapControllerCubit.addMarkers(
          marker: state.allCars
              .mapIndexed(
                (i, e) => MyMarker(
                  point: e.getLatLng(),
                  item: e,
                  bearing: e.angle,
                  type: MyMarkerType.bus,
                  key: e.imei,
                ),
              )
              .toList(),
          update: true,
        );
      },
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
              MyButton(
                onTap: () {
                  context.read<AtherCubit>().getAll();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
