part of 'create_edge_cubit.dart';

class CreateEdgeInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateEdgeInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateEdgeInitial.initial() {
    return const CreateEdgeInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateEdgeInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateEdgeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}