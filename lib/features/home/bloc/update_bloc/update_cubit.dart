import 'package:bloc/bloc.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateState.initial());

  void update() {
    emit(state.copyWith(data: state.data + 1));
  }
}
