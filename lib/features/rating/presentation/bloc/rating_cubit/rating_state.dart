part of 'rating_cubit.dart';

class RatingInitial extends Equatable {
  final CubitStatuses statuses;
  final RatingResponse result;
  final String error;

  const RatingInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory RatingInitial.initial() {
    return RatingInitial(
      result: RatingResponse.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  RatingInitial copyWith({
    CubitStatuses? statuses,
    RatingResponse? result,
    String? error,
  }) {
    return RatingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
