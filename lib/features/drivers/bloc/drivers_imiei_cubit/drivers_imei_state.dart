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


  List<String> getNames(List<int> selected) {
    final list = <String>[];
    for (var e in result) {
      if (!selected.contains(e.id)) continue;
      list.add(e.name);
    }
    return list;
  }

  List<String> get getImeisListString => List<String>.from(result.map((e) => e.imei));

  DriverImei? getIdByImei(String imei) => result.firstWhereOrNull((e) => e.imei == imei);

  List<SpinnerItem> get getSpinnerItem {
    final list = <SpinnerItem>[];
    for (var e in result) {
      list.add(SpinnerItem(id: e.id, name: e.name, item: e));
    }
    return list;
  }

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
