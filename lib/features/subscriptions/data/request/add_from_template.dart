import 'package:qareeb_dash/core/util/shared_preferences.dart';

class CreateFromTemplate {
  CreateFromTemplate();

   num? templateId;
   List<int> memberIds =[];


  Map<String, dynamic> toJson() => {
        "institutionId": AppSharedPreference.getInstitutionId,
        "templateId": templateId,
        "memberIds": memberIds.map((x) => x).toList(),
      };
}
