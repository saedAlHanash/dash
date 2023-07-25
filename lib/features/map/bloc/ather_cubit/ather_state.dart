part of 'ather_cubit.dart';

class AtherInitial extends Equatable {
  final CubitStatuses statuses;
  final Ime result;
  final List<Ime> allCars;
  final bool trackCar;
  final String error;

  const AtherInitial({
    required this.statuses,
    required this.result,
    required this.allCars,
    required this.error,
    required this.trackCar,
  });

  factory AtherInitial.initial() {
    return AtherInitial(
      result: Ime.fromJson({}),
      allCars: const <Ime>[],
      error: '',
      trackCar: true,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, trackCar];

  AtherInitial copyWith({
    CubitStatuses? statuses,
    Ime? result,
    List<Ime>? allCars,
    bool? trackCar,
    String? error,
  }) {
    return AtherInitial(
      statuses: statuses ?? this.statuses,
      trackCar: trackCar ?? this.trackCar,
      result: result ?? this.result,
      allCars: allCars ?? this.allCars,
      error: error ?? this.error,
    );
  }
}
