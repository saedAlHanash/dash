part of 'nav_home_cubit.dart';

class NavHomeInitial {
  final String page;
  final List<Driver> drivers;

  const NavHomeInitial({
    required this.page,
    required this.drivers,
  });

  factory NavHomeInitial.initial() {
    return const NavHomeInitial(
      page: '/',
      drivers: <Driver>[],
    );
  }

  NavHomeInitial copyWith({
    String? page,
    List<Driver>? drivers,
  }) {
    return NavHomeInitial(
      page: page ?? this.page,
      drivers: drivers ?? this.drivers,
    );
  }
}
