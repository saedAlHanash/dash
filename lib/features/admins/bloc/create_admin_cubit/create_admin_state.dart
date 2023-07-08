part of 'create_admin_cubit.dart';

class CreateAdminInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const CreateAdminInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CreateAdminInitial.initial() {
    return const CreateAdminInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateAdminInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return CreateAdminInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}