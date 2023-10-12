part of 'agency_by_id_cubit.dart';

class AgencyBuIdInitial extends Equatable {
  final CubitStatuses statuses;
  final Agency result;
  final String error;

  const AgencyBuIdInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AgencyBuIdInitial.initial() {
    return AgencyBuIdInitial(
      result: Agency.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AgencyBuIdInitial copyWith({
    CubitStatuses? statuses,
    Agency? result,
    String? error,
  }) {
    return AgencyBuIdInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
