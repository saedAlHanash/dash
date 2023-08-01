import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:qareeb_dash/features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/note_message.dart';
import '../../../../router/go_route_pages.dart';
import '../../../map/bloc/search_location/search_location_cubit.dart';
import '../../../map/ui/widget/search_location_widget.dart';
import '../../../map/ui/widget/search_widget.dart';
import '../../bloc/get_edged_point_cubit/get_all_points_cubit.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  late final MapControllerCubit mapController;

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();
    context.read<PointsCubit>().getAllPoints(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointsCubit, PointsInitial>(
      listener: (context, state) {
        mapController.addAllPoints(points: state.result);
      },
      child: Scaffold(
        floatingActionButton: isAllowed(AppPermissions.CREATION)
            ? FloatingActionButton(
          onPressed: () {
            context.pushNamed(GoRouteName.pointInfo);
          },
          child: const Icon(Icons.add, color: Colors.white),
        )
            : null,
        body: MapWidget(initialPoint: LatLng(33.30, 36.16), search: () async {
          NoteMessage.showCustomBottomSheet(
            context,
            child: BlocProvider.value(
              value: context.read<SearchLocationCubit>(),
              child: SearchWidget(
                onTap: (SearchLocationItem location) {
                  Navigator.pop(context);
                  context
                      .read<MapControllerCubit>()
                      .movingCamera(point: location.point, zoom: 15.0);
                },
              ),
            ),
          );
        },),
      ),
    );
  }
}
