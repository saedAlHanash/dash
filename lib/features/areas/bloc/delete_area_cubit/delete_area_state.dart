part of 'delete_area_cubit.dart';

class DeleteAreaInitial extends Equatable {
  final CubitStatuses statuses;
  final bool  result;
  final int  id;
  final String error;

  const DeleteAreaInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeleteAreaInitial.initial() {
    return const DeleteAreaInitial(
      result:false,
      id:0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteAreaInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeleteAreaInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}