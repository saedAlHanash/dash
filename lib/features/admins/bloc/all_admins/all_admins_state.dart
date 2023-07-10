part of 'all_admins_cubit.dart';

class AllAdminsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverModel> result;
  final String error;

  const AllAdminsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AllAdminsInitial.initial() {
    return const AllAdminsInitial(
      result: <DriverModel>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllAdminsInitial copyWith({
    CubitStatuses? statuses,
    List<DriverModel>? result,
    String? error,
  }) {
    return AllAdminsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}