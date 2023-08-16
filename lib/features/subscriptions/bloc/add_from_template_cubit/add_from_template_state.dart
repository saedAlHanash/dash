part of 'add_from_template_cubit.dart';

class AddFromTemplateInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final CreateFromTemplate request;
  final String error;

  const AddFromTemplateInitial({
    required this.statuses,
    required this.result,
    required this.request,
    required this.error,
  });

  factory AddFromTemplateInitial.initial() {
    return AddFromTemplateInitial(
      result: false,
      request: CreateFromTemplate(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AddFromTemplateInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    CreateFromTemplate? request,
    String? error,
  }) {
    return AddFromTemplateInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      request: request ?? this.request,
      error: error ?? this.error,
    );
  }
}
