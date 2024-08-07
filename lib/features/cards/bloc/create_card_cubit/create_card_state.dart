part of 'create_card_cubit.dart';

class CreateCardInitial extends AbstractState<bool> {
  const CreateCardInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  CreateCardRequest get mRequest => request;

  factory CreateCardInitial.initial() {
    return CreateCardInitial(
      result: false,
      error: '',
      request: CreateCardRequest(),
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

  CreateCardInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    CreateCardRequest? request,
  }) {
    return CreateCardInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
