import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

class SummaryModel {
  int? driverId;
  int? agencyId;

  ///المبلغ الذي سيتم اقتطاعه بأول عملية تحويل
  num? cutAmount;

  ///المبلغ الثاني في عملية التحويل
  num? payAmount;

  String? note;

  ///
  SummaryPayToEnum? type;

  String get message {
    final m = agencyId != null
        ? 'سيتم تحويل مبلغ من الشركة للوكيل'
        : type!.d2c
            ? 'سيتم استلام مبلغ من السائق'
            : 'سيتم تحويل مبلغ من الشركة';

    return '$m وقدره \n${payAmount?.formatPrice}\n ليرة سورية';
  }
}
