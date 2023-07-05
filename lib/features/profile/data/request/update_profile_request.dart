import 'package:image_picker/image_picker.dart';

import '../../../../core/util/shared_preferences.dart';

class UpdateProfileRequest {
  String? name;
  String? surname;
  String? address;
  DateTime? birthdate;
  int? gender;
  XFile? file;
  String? initialImage;

  UpdateProfileRequest({
    this.name,
    this.surname,
    this.address,
    this.birthdate,
    this.gender,
    this.initialImage,
  });

  factory UpdateProfileRequest.initial() {
    final item = AppSharedPreference.getProfileInfo();
    return UpdateProfileRequest(
      name: item?.name,
      surname: item?.surname,
      initialImage: item?.avatar,
      address: item?.address,
      birthdate: item?.birthdate,
      gender: item?.gender.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': AppSharedPreference.getMyId,
      'Name': name,
      'Surname': surname,
      'Address': address,
      'Birthdate': birthdate?.toIso8601String(),
      'Gender': gender ?? 0,
    };
  }
}
