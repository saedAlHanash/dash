part of 'delete_reason_cubit.dart';

class DeleteReasonInitial extends Equatable {
  final CubitStatuses statuses;
  final bool  result;
  final int  id;
  final String error;

  const DeleteReasonInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeleteReasonInitial.initial() {
    return const DeleteReasonInitial(
      result:false,
      id:0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteReasonInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeleteReasonInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}