import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/util/my_style.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/item_shared_trip.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../bloc/shared_trip_by_id_cubit/shared_trip_by_id_cubit.dart';
import '../../bloc/update_shared_cubit/update_shared_cubit.dart';

class ActiveSharedPage extends StatefulWidget {
  const ActiveSharedPage({Key? key}) : super(key: key);

  @override
  State<ActiveSharedPage> createState() => _ActiveSharedPageState();
}

class _ActiveSharedPageState extends State<ActiveSharedPage> {
  late MapControllerCubit mapCubit;

  @override
  void initState() {
    mapCubit = context.read<MapControllerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SharedTripByIdCubit, SharedTripByIdInitial>(
          listenWhen: (p, c) => c.statuses == CubitStatuses.done,
          listener: (context, state) => mapCubit.addPath(path: state.result.path),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(child: MapWidget(    clustering: false,)),
            BlocBuilder<SharedTripByIdCubit, SharedTripByIdInitial>(
              builder: (context, state) {
                if (state.statuses == CubitStatuses.loading) {
                  return MyStyle.loadingWidget();
                }
                var trip = state.result;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0).r,
                  color: Colors.white,
                  child: Column(
                    children: [
                      ItemSharedTrip(trip: state.result, withCard: false),
                      BlocBuilder<UpdateSharedCubit, UpdateSharedInitial>(
                        builder: (context, state) {
                          if (state.statuses == CubitStatuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          if (state.statuses == CubitStatuses.done) {
                            trip = state.result;
                          }

                          return MyButton(
                            margin: const EdgeInsets.symmetric(vertical: 20.0).h,
                            text: trip.tripStatus.sharedTripName(),
                            onTap: () {
                              if (DateTime.now()
                                      .compareTo(trip.schedulingDate ?? DateTime(2030)) <
                                  1) {
                                NoteMessage.showErrorSnackBar(
                                    message: 'لا يمكن بدأ الرحلة قبل الموعد',
                                    context: context);
                                return;
                              }

                              if (trip.tripStatus == SharedTripStatus.closed) {
                                Navigator.pop(context, true);
                                return;
                              }

                              context.read<UpdateSharedCubit>().updateSharedTrip(
                                    context,
                                    trip: trip,
                                    tState: SharedTripStatus.values[trip.tripStatus.index + 1],
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
