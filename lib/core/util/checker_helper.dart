// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import "package:universal_html/html.dart";

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

bool isAllowed(String permission) {
  return AppSharedPreference.myPermissions.contains(permission);
}

bool get canPopJs => window.history.length > 1;

void popAllJs() {
  while (canPopJs) {
    window.history.go(-1);
  }
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
  //
  // static const creation = "Create_Permission";
  // static const roles = "Update_Permission";
  // static const ticket = "Delete_Permission";
  // static const buses = "Pages.Epayment";
  // static const suberUsers = "Pages.CarCategory";
  // static const busTrips = "Pages.Users";
  // static const tempTrips = "Pages.Users.Activation";
  // static const tapTripsTable = "Pages.Roles";
  // static const tapTripsHistory = "Pages.Coupon";
  // static const tapSubscriptions = "Pages.Reason";
  // static const members = "Pages.Reports";
  // static const home = "Pages.Customers";
  // static const subscriptions = "Pages.Messages";
  // static const tapBuses = "Pages.Drivers";
  // static const tapSuberUser = "Pages.Trips";
  // static const suberUserAdmin = "Pages.Points";
  // static const tapRoles = "Pages.SharedTrip";
  // static const tapAdmins = "Pages.accept_order";
  // static const membersPoints = "Pages.Settings";
}

// String tranzlatePermition(String p) {
//   if (p == AppPermissions.creation) {
//     return 'عمليات الإنشاء';
//   } else if (p == AppPermissions.roles) {
//     //
//     return 'عمليات الأدوار';
//   } else if (p == AppPermissions.ticket) {
//     //
//     return 'عمليات الشكاوى';
//   } else if (p == AppPermissions.buses) {
//     //
//     return 'عمليات الباصات';
//   } else if (p == AppPermissions.suberUsers) {
//     //
//     return 'عمليات الأجهزة اللوحية';
//   } else if (p == AppPermissions.subscriptions) {
//     //
//     return 'عمليات الاشتراكات';
//   } else if (p == AppPermissions.busTrips) {
//     //
//     return 'عمليات الرحلات';
//   } else if (p == AppPermissions.tempTrips) {
//     //
//     return 'عمليات نماذج الرحلات';
//   } else if (p == AppPermissions.tapTripsTable) {
//     //
//     return 'عرض جدول الرحلات';
//   } else if (p == AppPermissions.tapTripsHistory) {
//     //
//     return 'سجل الرحلات';
//   } else if (p == AppPermissions.tapSubscriptions) {
//     //
//     return 'عرض الاشتراكات';
//   } else if (p == AppPermissions.members) {
//     //
//     return 'عمليات الطلاب';
//   } else if (p == AppPermissions.home) {
//     //
//     return 'التتبع المباشر';
//   } else if (p == AppPermissions.tapBuses) {
//     //
//     return 'عرض جدول الباصات';
//   } else if (p == AppPermissions.tapSuberUser) {
//     //
//     return 'عرض جدول الأجهزة اللوحية';
//   } else if (p == AppPermissions.suberUserAdmin) {
//     //
//     return 'مفتش الباصات';
//   } else if (p == AppPermissions.tapRoles) {
//     //
//     return 'عرض جدول الأدوار';
//   } else if (p == AppPermissions.tapAdmins) {
//     //
//     return 'عرض جدول مسؤولي المؤسسة';
//   } else if (p == AppPermissions.membersPoints) {
//     //
//     return 'نقاط الطلاب';
//   } //
//   return p;
// }
