part of 'delete_governorate_cubit.dart';

class DeleteGovernmentInitial extends Equatable {
  final CubitStatuses statuses;
  final bool  result;
  final int  id;
  final String error;

  const DeleteGovernmentInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeleteGovernmentInitial.initial() {
    return const DeleteGovernmentInitial(
      result:false,
      id:0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteGovernmentInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeleteGovernmentInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}