part of 'create_redeem_cubit.dart';
class CreateRedeemInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final RedeemRequest request;
  final String error;

  const CreateRedeemInitial({
    required this.statuses,
    required this.request,
    required this.result,
    required this.error,
  });

  factory CreateRedeemInitial.initial() {
    return  CreateRedeemInitial(
      result: false,
      request: RedeemRequest(),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CreateRedeemInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    RedeemRequest? request,
    String? error,
  }) {
    return CreateRedeemInitial(
      statuses: statuses ?? this.statuses,
      request: request ?? this.request,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}