part of 'active_cards_cubit.dart';

class ActiveCardsInitial extends AbstractState<List<ActiveCard>> {
  const ActiveCardsInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.statuses,
  }); //

  factory ActiveCardsInitial.initial() {
    return const ActiveCardsInitial(
      result: [],
      error: '',
      filterRequest: null,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (filterRequest != null) filterRequest!
      ];

  ActiveCardsInitial copyWith({
    CubitStatuses? statuses,
    List<ActiveCard>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
  }) {
    return ActiveCardsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
    );
  }
}
