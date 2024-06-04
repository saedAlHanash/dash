import 'package:collection/collection.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../services/caching_service/caching_service.dart';
import '../../../drivers/data/response/drivers_response.dart';

part 'clients_state.dart';

class ClientsCubit extends MCubit<ClientsInitial> {
  ClientsCubit() : super(ClientsInitial.initial());

  @override
  String get nameCache => 'clients';

  @override
  String get filter => state.command?.getKey ?? '';

  Future<void> getClients() async {
    if (await checkCashed()) return;

    final pair = await _getClients();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!.items);
      state.command?.totalCount = pair.first!.totalCount;
      emit(state.copyWith(
          statuses: CubitStatuses.done, result: pair.first?.items));
    }
  }

  Future<Pair<DriversResult?, String?>> _getClients() async {
    final response = await APIService().getApi(
      url: GetUrl.getAllClients,
      query: state.command?.toJson() ?? {},
    );

    if (response.success) {
      return Pair(DriversResponse.fromJson(response.json).result, null);
    } else {
      return response.getPairError;
    }
  }

  void setRequest(Map<String, dynamic> map) => state.command?.setFilter = map;

  Future<bool> checkCashed() async {
    try {
      final cacheType = await needGetData();

      emit(
        state.copyWith(
          statuses: cacheType.getState,
          result:
              (await getListCached()).map((e) => Driver.fromJson(e)).toList(),
        ),
      );

      if (cacheType == NeedUpdateEnum.no) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> getBusAsync() async {
    var oldSkipCount = state.command?.skipCount;
    state.command!
      ..maxResultCount = 1.maxInt
      ..skipCount = 0;

    final pair = await _getClients();
    state.command!
      ..maxResultCount = 20
      ..skipCount = oldSkipCount;

    if (pair.first != null) {
      final value = _getXlsData(pair.first!.items);
      saveXls(
        header: value.first,
        data: value.second,
        fileName: 'تقرير المستخدمين ${DateTime.now().formatDate}',
      );
    } else {
      showErrorFromApi(state);
    }
  }

  Pair<List<String>, List<List<dynamic>>> _getXlsData(List<Driver> data) {
    return Pair(
        [
          'ID',
          'الاسم الكامل',
          'تاريخ الميلاد',
          'العنوان',
          'رقم الهاتف',
          'حالة الزبون',
          ' OTP',
          'تاريخ الاشتراك',
          'الجنس',
          'ملاحظات',
        ],
        data
            .mapIndexed(
              (index, element) => [
                element.id,
                element.fullName,
                element.birthdate?.formatDate,
                element.address,
                element.phoneNumber,
                element.isActive,
                element.emailConfirmationCode,
                element.creationTime?.formatDate,
                element.gender == 0 ? 'M' : 'F',
              ],
            )
            .toList());
  }
}
