part of 'create_point_cubit.dart';

class CreatePointInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreatePointInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreatePointInitial.initial() {
    return const CreatePointInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreatePointInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreatePointInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}