import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_dash/core/util/my_style.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/item_shared_trip.dart';

import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
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
    AppSharedPreference.cashShared(true);
    // startSendLocation();

    super.initState();
  }

  @override
  void dispose() {
    AppSharedPreference.cashShared(false);
    // stopSendLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SharedTripByIdCubit, SharedTripByIdInitial>(
          listenWhen: (p, c) => c.statuses == CubitStatuses.done,
          listener: (context, state) => mapCubit.addPath(trip: state.result),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(child: MapWidget()),
            BlocBuilder<SharedTripByIdCubit, SharedTripByIdInitial>(
              builder: (context, state) {
                if (state.statuses == CubitStatuses.loading) {
                  return MyStyle.loadingWidget();
                }
                var trip = state.result;
                var list = state.result.path.getPointsName;
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
                          final tStateIndex = trip.status();

                          return MyButton(
                            margin: const EdgeInsets.symmetric(vertical: 20.0).h,
                            text: SharedTripStatus.values[tStateIndex].sharedTripName(),
                            onTap: () {
                              if (DateTime.now()
                                      .compareTo(trip.schedulingDate ?? DateTime(2030)) <
                                  1) {
                                NoteMessage.showErrorSnackBar(
                                    message: 'لا يمكن بدأ الرحلة قبل الموعد',
                                    context: context);
                                return;
                              }
                              if (tStateIndex == SharedTripStatus.closed.index) {
                                Navigator.pop(context, true);
                                return;
                              }
                              context.read<UpdateSharedCubit>().updateSharedTrip(
                                    context,
                                    trip: trip,
                                    tState: SharedTripStatus.values[tStateIndex + 1],
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
