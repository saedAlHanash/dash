part of 'create_area_cubit.dart';

class CreateAreaInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final AreaModel request;

  const CreateAreaInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory CreateAreaInitial.initial() {
    return CreateAreaInitial(
      result: false,
      error: '',
      request: AreaModel.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateAreaInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    AreaModel? request,
  }) {
    return CreateAreaInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
