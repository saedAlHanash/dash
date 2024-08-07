part of 'all_institutions_cubit.dart';

class AllInstitutionsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<InstitutionModel> result;
  final String error;
  final FilterRequest command;

  const AllInstitutionsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllInstitutionsInitial.initial() {
    return AllInstitutionsInitial(
      result: const <InstitutionModel>[],
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.name, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllInstitutionsInitial copyWith({
    CubitStatuses? statuses,
    List<InstitutionModel>? result,
    String? error,
    FilterRequest? command,
  }) {
    return AllInstitutionsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
