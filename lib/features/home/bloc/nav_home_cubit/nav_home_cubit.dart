import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

part 'nav_home_state.dart';

class NavHomeCubit extends Cubit<NavHomeInitial> {
  NavHomeCubit() : super(NavHomeInitial.initial());

  changePage(String pageRoute) {
    emit(state.copyWith(page: pageRoute));
  }
}
