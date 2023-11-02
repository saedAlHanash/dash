part of 'all_car_categories_cubit.dart';

class AllCarCategoriesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<CarCategory> result;
  final String error;
  final Command command;

  const AllCarCategoriesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllCarCategoriesInitial.initial() {
    return AllCarCategoriesInitial(
      result: const <CarCategory>[],
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
    return list;
  }
  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: 'لا توجد تصنيفات', id: 0)];
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

  AllCarCategoriesInitial copyWith({
    CubitStatuses? statuses,
    List<CarCategory>? result,
    String? error,
    Command? command,
  }) {
    return AllCarCategoriesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
