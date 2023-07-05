import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../../../../core/strings/enum_manager.dart';

part 'nav_trip_state.dart';

class NavTripCubit extends Cubit<NavTripInitial> {
  NavTripCubit() : super(NavTripInitial.initial());

  void changeScreen(NavTrip navState) {
    emit(state.copyWith(navState: navState));
  }

  void initial() {
    var s = AppSharedPreference.getTripState();

    emit(state.copyWith(navState: s));
  }
}
