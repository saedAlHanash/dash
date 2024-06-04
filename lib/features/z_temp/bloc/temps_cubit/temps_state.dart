part of 'temps_cubit.dart';

class TempsInitial extends AbstractState<List<Temp>> {
  // final Command request;
  // final  bool tempParam;
  const TempsInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.command,
    super.statuses,
  }); //

  factory TempsInitial.initial() {
    return const TempsInitial(
      result: [],
      error: '',
      command: null,
      // tempParam: false,
      // request: Command(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props =>
      [statuses, result, error, if (command != null) command!];

  TempsInitial copyWith({
    CubitStatuses? statuses,
    List<Temp>? result,
    String? error,
    Command? command,
    // bool? tempParam,
  }) {
    return TempsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
