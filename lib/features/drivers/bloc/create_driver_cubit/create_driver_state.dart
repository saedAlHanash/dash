part of 'create_driver_cubit.dart';

class CreateDriverInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateDriverInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateDriverInitial.initial() {
    return const CreateDriverInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateDriverInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateDriverInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}