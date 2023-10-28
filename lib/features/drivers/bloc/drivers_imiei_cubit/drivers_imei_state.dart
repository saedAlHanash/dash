part of 'drivers_imei_cubit.dart';

class DriversImeiInitial extends Equatable {
  final CubitStatuses statuses;
  final List<DriverImei> result;
  final String error;

  const DriversImeiInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory DriversImeiInitial.initial() {
    return const DriversImeiInitial(
      result: <DriverImei>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  List<String> get getImeisListString => List<String>.from(result.map((e) => e.imei));

  DriverImei? getIdByImei(String imei) => result.firstWhereOrNull((e) => e.imei == imei);

  @override
  List<Object> get props => [statuses, result, error];

  DriversImeiInitial copyWith({
    CubitStatuses? statuses,
    List<DriverImei>? result,
    String? error,
  }) {
    return DriversImeiInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
