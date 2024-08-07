part of 'cards_cubit.dart';

class CardsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<UserCard> result;
  final String error;
  final FilterRequest command;

  const CardsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory CardsInitial.initial() {
    return CardsInitial(
      result: const <UserCard>[],
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.description, item: e));
    }
    return list;
  }

  @override
  List<Object> get props => [statuses, result, error];

  CardsInitial copyWith({
    CubitStatuses? statuses,
    List<UserCard>? result,
    String? error,
    FilterRequest? command,
  }) {
    return CardsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
