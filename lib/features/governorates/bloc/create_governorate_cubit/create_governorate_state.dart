part of 'create_governorate_cubit.dart';

class CreateGovernorateInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final GovernorateModel request;

  const CreateGovernorateInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory CreateGovernorateInitial.initial() {
    return CreateGovernorateInitial(
      result: false,
      error: '',
      request: GovernorateModel.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateGovernorateInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    GovernorateModel? request,
  }) {
    return CreateGovernorateInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
