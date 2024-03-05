part of 'all_charging_cubit.dart';

class AllChargingInitial extends Equatable {
  final CubitStatuses statuses;
  final List<Charging> result;
  final String error;
  final Command command;

  const AllChargingInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.command,
  });

  factory AllChargingInitial.initial() {
    return AllChargingInitial(
      result: const <Charging>[],
      error: '',
      command: Command.initial(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllChargingInitial copyWith({
    CubitStatuses? statuses,
    List<Charging>? result,
    String? error,
    Command? command,
  }) {
    return AllChargingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      command: command ?? this.command,
    );
  }
}


class ChargingResult {
  ChargingResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<Charging> items;

  factory ChargingResult.fromJson(Map<String, dynamic> json) {
    return ChargingResult(
      totalCount: json["totalCount"] ?? 0,
      items: json["items"] == null
          ? []
          : List<Charging>.from(json["items"]!.map((x) => Charging.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items.map((x) => x.toJson()).toList(),
      };
}
