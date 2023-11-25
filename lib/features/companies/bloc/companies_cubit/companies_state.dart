part of 'companies_cubit.dart';

class AllCompaniesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<CompanyModel> result;
  final String error;
  final Command command;

  const AllCompaniesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllCompaniesInitial.initial() {
    return AllCompaniesInitial(
      result: const <CompanyModel>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.name, item: e));
    }
    return list.isEmpty ? [SpinnerItem(name: 'لا يوجد')] : list;
  }

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: 'لا توجد شركات', id: 0)];
    }
    return result
        .map((e) => SpinnerItem(
      id: e.id,
      name: e.name,
      item: e,
      isSelected: e.id == selectedId,
    ))
        .toList();
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllCompaniesInitial copyWith({
    CubitStatuses? statuses,
    List<CompanyModel>? result,
    String? error,
    Command? command,
  }) {
    return AllCompaniesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
