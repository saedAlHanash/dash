part of 'ather_cubit.dart';

class AtherInitial extends Equatable {
  final CubitStatuses statuses;
  final Ime result;
  final bool trackCar;
  final String error;

  const AtherInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.trackCar,
  });

  factory AtherInitial.initial() {
    return AtherInitial(
      result: Ime.fromJson({}),
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
    bool? trackCar,
    String? error,
  }) {
    return AtherInitial(
      statuses: statuses ?? this.statuses,
      trackCar: trackCar ?? this.trackCar,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
