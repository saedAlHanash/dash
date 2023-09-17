part of 'create_governorate_cubit.dart';

class CreateGovernmentInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;
  final GovernmentModel request;

  const CreateGovernmentInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory CreateGovernmentInitial.initial() {
    return CreateGovernmentInitial(
      result: false,
      error: '',
      request: GovernmentModel.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateGovernmentInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    GovernmentModel? request,
  }) {
    return CreateGovernmentInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
