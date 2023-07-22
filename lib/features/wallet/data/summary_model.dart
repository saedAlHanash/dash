import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../core/strings/enum_manager.dart';

class SummaryModel {
  int? driverId;
  num? cutAmount;
  num? payAmount;
  SummaryPayToEnum? type;

  String get message {
    return 'سيتم تحويل مبلغ ل'
        '${type == SummaryPayToEnum.requireDriverPay ? 'للشركة' : 'للسائق'} '
        'وقدره '
        '${payAmount?.formatPrice} ليرة سورية'
        '';
  }
}
