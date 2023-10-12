part of 'create_agency_cubit.dart';

class CreateAgencyInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateAgencyInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateAgencyInitial.initial() {
    return const CreateAgencyInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateAgencyInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateAgencyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}