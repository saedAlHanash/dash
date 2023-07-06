part of 'create_cubit.dart';

class CreateReasonInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateReasonInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateReasonInitial.initial() {
    return const CreateReasonInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateReasonInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateReasonInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
