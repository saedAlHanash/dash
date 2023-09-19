part of 'areas_cubit.dart';

class AreasInitial extends Equatable {
  final CubitStatuses statuses;
  final List<AreaModel> result;
  final String error;
  final Command command;
  final int id;

  const AreasInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
    required this.id,
  });

  factory AreasInitial.initial() {
    return AreasInitial(
      result: const <AreaModel>[],
      error: '',
      command: Command.noPagination(),
      id: 0,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AreasInitial copyWith({
    CubitStatuses? statuses,
    List<AreaModel>? result,
    String? error,
    Command? command,
    int? id,
  }) {
    return AreasInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
      id: id ?? this.id,
    );
  }
  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: 'لا توجد مناطق', id: 0)];
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
}
