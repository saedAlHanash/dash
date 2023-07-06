part of 'get_reasons_cubit.dart';

class GetReasonsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Reasons>  result;
  final String error;

  const GetReasonsInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory GetReasonsInitial.initial() {
    return const GetReasonsInitial(
      result: <Reasons>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  GetReasonsInitial copyWith({
    CubitStatuses? statuses,
    List<Reasons>? result,
    String? error,
  }) {
    return GetReasonsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}