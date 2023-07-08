part of 'delete_car_cat_cubit.dart';

class DeleteCarCatInitial extends Equatable {
  final CubitStatuses statuses;
  final bool  result;
  final int  id;
  final String error;

  const DeleteCarCatInitial({
    required this.statuses,
    required this.result,
    required this.id,
    required this.error,
  });

  factory DeleteCarCatInitial.initial() {
    return const DeleteCarCatInitial(
      result:false,
      id:0,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteCarCatInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    int? id,
    String? error,
  }) {
    return DeleteCarCatInitial(
      statuses: statuses ?? this.statuses,
      id: id ?? this.id,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}