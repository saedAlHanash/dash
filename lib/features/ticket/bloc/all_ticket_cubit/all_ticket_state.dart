part of 'all_ticket_cubit.dart';

class AllTicketsInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Ticket> result;
  final String error;
  final FilterRequest command;

  const AllTicketsInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllTicketsInitial.initial() {
    return AllTicketsInitial(
      result: const <Ticket>[],
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

  AllTicketsInitial copyWith({
    CubitStatuses? statuses,
    List<Ticket>? result,
    String? error,
    FilterRequest? command,
  }) {
    return AllTicketsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}
