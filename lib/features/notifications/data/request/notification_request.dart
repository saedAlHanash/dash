import 'package:qareeb_models/global.dart';

class NotificationRequest {
  UserType? userType;
  List<int>? areaIds;
  List<int>? ids;

  String? title;
  String? body;

  NotificationRequest({
    this.userType,
    this.areaIds,
    this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserType': userType?.index ?? 0,
      'AreaIds': areaIds,
      'Ids': ids,
    };
  }

  Map<String, dynamic> toMapBody() {
    return {
      'title': 'إعلان',
      'body': body,
    };
  }

  void clearFilter() {
    userType = null;
    areaIds = null;
    ids = null;
  }
}
