import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/plans/data/response/enrollments.dart';

import '../../../../core/api_manager/api_service.dart'; import 'package:qareeb_dash/core/strings/enum_manager.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/caching_service/caching_service.dart';

part 'enrollments_state.dart';

class EnrollmentCubit extends MCubit<EnrollmentInitial> {
  EnrollmentCubit() : super(EnrollmentInitial.initial());

  @override
  String get nameCache => 'enrollment';

  Future<void> getEnrollment() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      state.filterRequest?.totalCount = pair.first!.totalCount.toInt();
      emit(state.copyWith(
          statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<EnrollmentsResponse1?, String?>> _getDataApi() async {
    final response = await APIService().callApi(type: ApiType.get,url: GetUrl.enrollment);

    if (response.success) {
      return Pair(
          EnrollmentsResponse1.fromJson(response.json['result'] ?? {}), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result:
            (await getListCached()).map((e) => Enrollment.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
