part of 'delete_point_cubit.dart';

class DeletePointInitial extends Equatable {
  final CubitStatuses statuses;
  final bool  result;
  final int  id;
  final String error;

  const DeletePointInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeletePointInitial.initial() {
    return const DeletePointInitial(
      result:false,
      id:0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeletePointInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeletePointInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}