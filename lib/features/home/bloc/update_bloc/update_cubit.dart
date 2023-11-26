import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateState.initial());

  void update() {
    emit(state.copyWith(data: state.data + 1));
  }
}
