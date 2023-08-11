import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/features/trip/ui/widget/screen/end_trip_widget.dart';
import 'package:qareeb_dash/features/trip/ui/widget/screen/final_trip.dart';
import 'package:qareeb_dash/features/trip/ui/widget/screen/have_trip_widget.dart';
import 'package:qareeb_dash/features/trip/ui/widget/screen/start_trip_widget.dart';
import 'package:qareeb_dash/features/trip/ui/widget/screen/waiting_widget.dart';
import 'dart:html';
import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../bloc/nav_trip_cubit/nav_trip_cubit.dart';
import '../../bloc/trip_status_cubit/trip_status_cubit.dart';

class TripWidget extends StatefulWidget {
  const TripWidget({Key? key}) : super(key: key);

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  /// to control life circle
  var isPaused = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripStatusCubit, TripStatusInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            if (state.tripStatus == TripStatus.reject) {
              window.history.back();
              return;
            }
            checkTrip();
          },
        ),
        BlocListener<NavTripCubit, NavTripInitial>(
          listenWhen: (p, c) => c.navState == NavTrip.have,
          listener: (context, state) {
            // context
            //     .read<TripByIdCubit>()
            //     .tripById(context, tripId: AppSharedPreference.getCashedTrip().id);
          },
        )
      ],
      child: BlocBuilder<NavTripCubit, NavTripInitial>(
        buildWhen: (p, c) => p.navState != c.navState,
        builder: (context, state) {
          return Container(
            width: 1.0.sw,
            color: state.navState == NavTrip.have ? null : AppColorManager.f1,
            child: Builder(
              builder: (context) {
                switch (state.navState) {
                  case NavTrip.waiting:
                    return const WaitingWidget();

                  case NavTrip.have:
                    return const HaveTripWidget();

                  case NavTrip.acceptor:
                    return const StartTripWidget();

                  case NavTrip.start:
                    return const EndTripWidget();

                  case NavTrip.end:
                    return const FinalTripWidget();
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> checkTrip() async {
    final tripState = await AppSharedPreference.getTripStateAsync();

    if (context.mounted) {
      if (tripState != NavTrip.waiting) {
        context.read<NavTripCubit>().changeScreen(tripState);
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        checkTrip();
        break;

      case AppLifecycleState.paused:
        isPaused = true;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}

//        return DraggableScrollableSheet(
//           maxChildSize: state.navState.maxBottomSheet,
//           initialChildSize: state.navState.initBottomSheet,
//           minChildSize: state.navState.minBottomSheet,
//           builder: (context, scrollController) {
//             return SingleChildScrollView(
//               controller: scrollController,
//               child: Container(
//                 width: 1.0.sw,
//                 height: state.navState.maxBottomSheet.sh - 22.0.h,
//                 color: state.navState == NavTrip.acceptor ? null : AppColorManager.f1,
//                 child: Builder(
//                   builder: (context) {
//                     switch (state.navState) {
//                       case NavTrip.waiting:
//                         return const WaitingWidget();
//
//                       case NavTrip.acceptor:
//                         return const AcceptorWidget();
//
//                       case NavTrip.start:
//                         return const StartTripWidget();
//
//                       case NavTrip.end:
//                         return const EndTRipWidget();
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//         );
