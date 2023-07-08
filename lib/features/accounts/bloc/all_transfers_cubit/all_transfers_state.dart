part of 'all_transfers_cubit.dart';

class AllTransfersInitial extends Equatable {
  final CubitStatuses statuses;
  final List<TransferResult> result;
  final String error;

  const AllTransfersInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AllTransfersInitial.initial() {
    return const AllTransfersInitial(
      result: <TransferResult>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllTransfersInitial copyWith({
    CubitStatuses? statuses,
    List<TransferResult>? result,
    String? error,
  }) {
    return AllTransfersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}