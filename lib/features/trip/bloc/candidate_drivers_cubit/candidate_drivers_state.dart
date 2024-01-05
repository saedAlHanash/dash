part of 'candidate_drivers_cubit.dart';

class CandidateDriversInitial extends Equatable {
  final CubitStatuses statuses;
  final List<CandidateDriver> result;
  final String error;

  const CandidateDriversInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory CandidateDriversInitial.initial() {
    return const CandidateDriversInitial(
      result: <CandidateDriver>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  List<String> get getImeisListString {
    final l = <String>[];
    for (var e in result) {
      if (!e.isAccepted) l.add(e.driver.imei);
    }
    return l;
  }

  List<int> get getDriverIds => List<int>.from(result.map((e) => e.driverId));

  CandidateDriver? getIdByImei(String imei) =>
      result.firstWhereOrNull((e) => e.driver.imei == imei);

  @override
  List<Object> get props => [statuses, result, error];

  CandidateDriversInitial copyWith({
    CubitStatuses? statuses,
    List<CandidateDriver>? result,
    String? error,
  }) {
    return CandidateDriversInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
