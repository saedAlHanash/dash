part of 'reverse_charging_cubit.dart';

class ReverseChargingInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final String processId;

  const ReverseChargingInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.processId,
  });

  factory ReverseChargingInitial.initial() {
    return const ReverseChargingInitial(
      result: false,
      error: '',
      processId: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ReverseChargingInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? processId,
  }) {
    return ReverseChargingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      processId: processId ?? this.processId,
    );
  }

}