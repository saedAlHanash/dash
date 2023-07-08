part of 'create_car_category_cubit.dart';

class CreateCarCategoryInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateCarCatRequest request;
  final String error;

  const CreateCarCategoryInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory CreateCarCategoryInitial.initial() {
    return CreateCarCategoryInitial(
      result: false,
      request: CreateCarCatRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateCarCategoryInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateCarCatRequest? request,
    String? error,
  }) {
    return CreateCarCategoryInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
