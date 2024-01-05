import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/api_manager/api_service.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';

class DriverLiveTracking extends StatefulWidget {
  const DriverLiveTracking({super.key, required this.imei});

  final String imei;

  @override
  State<DriverLiveTracking> createState() => _DriverLiveTrackingState();
}

class _DriverLiveTrackingState extends State<DriverLiveTracking> {
  @override
  void initState() {
    MapWidget.initImeis([widget.imei]);
    loggerObject.w(widget.imei);
    // context.read<AtherCubit>().getDriverLocation([widget.imei]);
    super.initState();
  }

  @override
  void dispose() {
    MapWidget.initImeis([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0).r,

      child: const MapWidget(),
    );
  }
}
