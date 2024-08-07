part of 'my_cards_cubit.dart';

class MyCardsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<ActiveCard> result;
  final String error;
  final FilterRequest command;

  const MyCardsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory MyCardsInitial.initial() {
    return MyCardsInitial(
      result: const <ActiveCard>[],
      error: '',
      command: FilterRequest.initial(),
      statuses: CubitStatuses.init,
    );
  }


  @override
  List<Object> get props => [statuses, result, error];

  MyCardsInitial copyWith({
    CubitStatuses? statuses,
    List<ActiveCard>? result,
    String? error,
    FilterRequest? command,
  }) {
    return MyCardsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
