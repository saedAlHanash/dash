import 'package:qareeb_models/global.dart';

class NotificationRequest {
  UserType? userType;
  List<int>? areaIds;
  int? governorateId;
  List<int>? ids;

  String? title;
  String? body;

  NotificationRequest({
    this.userType,
    this.areaIds,
    this.governorateId,
    this.ids,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserType': userType?.index ?? 0,
      'AreaIds': areaIds,
      'GovernorateId': governorateId,
      'Ids': ids,
    };
  }

  Map<String, dynamic> toMapBody() {
    return {
      'title': title,
      'body': body,
    };
  }

  void clearFilter() {
    userType = null;
    governorateId = null;
    areaIds = null;
    ids = null;
  }
}
