part of 'governorates_cubit.dart';

class GovernoratesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<GovernorateModel> result;
  final String error;
  final Command command;

  const GovernoratesInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory GovernoratesInitial.initial() {
    return GovernoratesInitial(
      result: const <GovernorateModel>[],
      error: '',
      command: Command.noPagination(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    if (result.isEmpty) {
      return [SpinnerItem(name: 'لا توجد محافظات', id: 0)];
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

  GovernoratesInitial copyWith({
    CubitStatuses? statuses,
    List<GovernorateModel>? result,
    String? error,
    Command? command,
  }) {
    return GovernoratesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
