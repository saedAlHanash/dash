part of 'clients_cubit.dart';

class ClientsInitial extends AbstractState<List<Driver>> {
  // final Command request;
  // final  bool clientParam;
  const ClientsInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.clientParam,
    super.command,
    super.statuses,
  }); //

  factory ClientsInitial.initial() {
    return  ClientsInitial(
      result: [],
      error: '',
      command: Command.initial(),
      // clientParam: false,
      // request: Command(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props =>
      [statuses, result, error, if (command != null) command!];

  ClientsInitial copyWith({
    CubitStatuses? statuses,
    List<Driver>? result,
    String? error,
    Command? command,
    // bool? clientParam,
  }) {
    return ClientsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
      // request: request ?? this.request,
      // clientParam: clientParam ?? this.clientParam,
    );
  }
}
