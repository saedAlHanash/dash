part of 'all_temp_trips_cubit.dart';

class AllTempTripsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TripPath> result;
  final String error;
  final FilterRequest command;

  const AllTempTripsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllTempTripsInitial.initial() {
    return AllTempTripsInitial(
      result: const <TripPath>[],
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.arName, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllTempTripsInitial copyWith({
    CubitStatuses? statuses,
    List<TripPath>? result,
    String? error,
    FilterRequest? command,
  }) {
    return AllTempTripsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
