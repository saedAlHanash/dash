part of 'temp_cubit.dart';

class TempInitial extends AbstractState<Temp> {
  final String tempId;
  // final bool tempParam;

  const TempInitial({
    required super.result,
    super.error,
    required this.tempId,
    // required this.tempParam,
    super.statuses,
  });

  factory TempInitial.initial() {
    return TempInitial(
      result: Temp.fromJson({}),
      error: '',
      // tempParam: false,
      tempId: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  TempInitial copyWith({
    CubitStatuses? statuses,
    Temp? result,
    String? error,
    String? tempId,
    // bool? tempParam,
  }) {
    return TempInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      tempId: tempId ?? this.tempId,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
