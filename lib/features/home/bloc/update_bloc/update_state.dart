part of 'update_cubit.dart';

class UpdateState {
  final int data;


  const UpdateState({
    required this.data,
  });

  factory UpdateState.initial() {
    return const UpdateState(
      data: 0,

    );
  }

  UpdateState copyWith({
    int? data,
  }) {
    return UpdateState(
      data: data ?? this.data,
    );
  }
}
