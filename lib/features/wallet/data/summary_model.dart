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
    return 'سيتم تحويل مبلغ ل'
        '${type == SummaryPayToEnum.requiredFromDriver ? 'للشركة' : 'للسائق'} '
        'وقدره '
        '${payAmount?.formatPrice} ليرة سورية'
        '';
  }
}
