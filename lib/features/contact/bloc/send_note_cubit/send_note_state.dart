part of 'send_note_cubit.dart';

class NoteInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const NoteInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory NoteInitial.initial() {
    return const NoteInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  NoteInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return NoteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
