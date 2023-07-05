part of 'nav_trip_cubit.dart';

class NavTripInitial {
  const NavTripInitial({required this.navState});

  final NavTrip navState;

  factory NavTripInitial.initial() {
    return const NavTripInitial(navState: NavTrip.waiting);
  }

  NavTripInitial copyWith({
    NavTrip? navState,
  }) {
    return NavTripInitial(
      navState: navState ?? this.navState,
    );
  }
}
