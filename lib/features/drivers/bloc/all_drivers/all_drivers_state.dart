part of 'all_drivers_cubit.dart';

class AllDriversInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverModel> result;
  final String error;

  const AllDriversInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AllDriversInitial.initial() {
    return const AllDriversInitial(
      result: <DriverModel>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllDriversInitial copyWith({
    CubitStatuses? statuses,
    List<DriverModel>? result,
    String? error,
  }) {
    return AllDriversInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}