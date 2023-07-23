// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

import '../strings/app_string_manager.dart';

String? checkPhoneNumber(BuildContext? context, String phone) {
  if (phone.startsWith('963') && phone.length > 10) return phone;
  if (phone.length < 9) {
    NoteMessage.showSnakeBar(context: context, message: AppStringManager.wrongPhone);
    return null;
  } else if (phone.startsWith("0") && phone.length < 10) {
    NoteMessage.showSnakeBar(context: context, message: AppStringManager.wrongPhone);
    return null;
  }

  if (phone.length > 9 && phone.startsWith("0")) phone = phone.substring(1);

  phone = '963$phone';

  return phone;
}

bool checkEmail(BuildContext context, String? email) {
  final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email ?? '');
  if (!emailValid) {
    NoteMessage.showSnakeBar(context: context, message: AppStringManager.wrongEmail);
  }
  return emailValid;
}

bool isAllowed(String permission){
  return AppSharedPreference.myPermissions.contains(permission);
}

class AppPermissions {
  static String CREATION = "Create_Permission";
  static String UPDATE = "Update_Permission";
  static String DELETE = "Delete_Permission";
  static String EPAYMENT = "Pages.Epayment";
  static String CAR_CATEGORY = "Pages.CarCategory";

  static String TENANTS = "Pages.Tenants";
  static String USERS = "Pages.Users";
  static String USERS_ACTIVATION = "Pages.Users.Activation";
  static String ROLES = "Pages.Roles";
  static String COUPON = "Pages.Coupon";
  static String REASON = "Pages.Reason";
  static String REPORTS = "Pages.Reports";
  static String CUSTOMERS = "Pages.Customers";
  static String MESSAGES = "Pages.Messages";
  static String DRIVERS = "Pages.Drivers";
  static String TRIPS = "Pages.Trips";
  static String POINTS = "Pages.Points";
  static String SHARED_TRIP = "Pages.SharedTrip";
  static String ACCEPT_ORDER = "Pages.accept_order";
  static String SETTINGS = "Pages.Settings";

}