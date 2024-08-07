import 'package:flutter/src/widgets/framework.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/util/note_message.dart';
import '../response/cards_user_response.dart';

class CreateCardRequest {
  String? name;
  String? description;
  String? adress;
  int? id;
  num? price;
  num? maxActivationCount;

  UploadFile? file;

  CreateCardRequest({
    this.id,
    this.name,
    this.description,
    this.adress,
    this.price,
    this.maxActivationCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': id == 0 ? null : id,
      'Name': name,
      'Description': description,
      'Adress': adress,
      'Price': price,
      'MaxActivationCount': maxActivationCount,
    };
  }

  factory CreateCardRequest.fromUserCard(UserCard model) {
    return CreateCardRequest(
      id: model.id,
      name: model.name,
      description: model.description,
      adress: model.adress,
      price: model.price,
      maxActivationCount: model.maxActivationCount,
    )..file = UploadFile(fileBytes: null, initialImage: model.image, nameField: 'Image');
  }

  bool validateRequest() {
    if (name?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الاسم', context: ctx!);
      return false;
    }
    if (description?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في الوصف', context: ctx!);
      return false;
    }
    if (price?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في رقم السعر', context: ctx!);
      return false;
    }

    if (adress?.isEmpty ?? true) {
      NoteMessage.showErrorSnackBar(message: 'خطأ في العنوان', context: ctx!);
      return false;
    }

    if (maxActivationCount == null) {
      NoteMessage.showErrorSnackBar(
          message: 'خطأ في عدد البطاقات المتاحة', context: ctx!);
      return false;
    }

    return true;
  }
}
