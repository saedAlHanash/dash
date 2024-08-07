part of 'delete_card_cubit.dart';

class DeleteCardInitial extends AbstractState<bool> {
  const DeleteCardInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  factory DeleteCardInitial.initial() {
    return const DeleteCardInitial(
      result: false,
      error: '',
      request: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
    statuses,
    result,
    error,
    if (request != null) request,
    if (filterRequest != null) filterRequest!
  ];
  DeleteCardInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    int? request,
  }) {
    return DeleteCardInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
