part of 'change_provider_state_cubit.dart';

class ChangeProviderStateInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final int id;
  final String error;

  const ChangeProviderStateInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.id,
  });

  factory ChangeProviderStateInitial.initial() {
    return const ChangeProviderStateInitial(
      result: false,
      error: '',
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ChangeProviderStateInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return ChangeProviderStateInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
    );
  }

}