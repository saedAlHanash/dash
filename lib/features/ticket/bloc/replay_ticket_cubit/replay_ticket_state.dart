part of 'replay_ticket_cubit.dart';

class ReplayTicketInitial extends Equatable {
  final CubitStatuses statuses;
  final String result;
  final String error;

  const ReplayTicketInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory ReplayTicketInitial.initial() {
    return const ReplayTicketInitial(
      result: '',
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ReplayTicketInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
  }) {
    return ReplayTicketInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}