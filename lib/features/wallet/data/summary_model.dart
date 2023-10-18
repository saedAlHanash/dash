import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

class SummaryModel {
  int? driverId;

  ///المبلغ الذي سيتم اقتطاعه بأول عملية تحويل
  num? cutAmount;

  ///المبلغ الثاني في عملية التحويل
  num? payAmount;

  ///
  SummaryPayToEnum? type;

  String get message {
    final m = type!.d2c
        ? 'سيتم استلام مبلغ من السائق'
        : 'سيتم تحويل مبلغ من الشركة';
    return '$m وقدره \n${payAmount?.formatPrice}\n ليرة سورية';
  }
}
