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

bool isAllowed(String permission) {
  return AppSharedPreference.myPermissions.contains(permission);
}

class AppPermissions {
  static const admins = "Create_Permission";
  static const roles = "Update_Permission";
  static const ticket = "Delete_Permission";
  static const buses = "Pages.Epayment";
  static const suberUsers = "Pages.CarCategory";
  static const subscriptions = "Pages.Tenants";
  static const busTrips = "Pages.Users";
  static const tempTrips = "Pages.Users.Activation";
  static const tapTripsTable = "Pages.Roles";
  static const tapTripsHistory = "Pages.Coupon";
  static const tapSubscriptions = "Pages.Reason";
  static const members = "Pages.Reports";
  static const tapMember = "Pages.Customers";
  static const liveTracking = "Pages.Messages";
  static const tapBuses = "Pages.Drivers";
  static const tapSuberUser = "Pages.Trips";
  static const tapTicket = "Pages.Points";
  static const tapRoles = "Pages.SharedTrip";
  static const tapAdmins = "Pages.accept_order";
  static const membersPoints = "Pages.Settings";
}

String tranzlatePermition(String p) {
  if (p == AppPermissions.admins) {
    return 'عمليات مسؤولي لوحة التحكم';
  } else if (p == AppPermissions.roles) {
    //
    return 'عمليات الأدوار';
  } else if (p == AppPermissions.ticket) {
    //
    return 'عمليات الشكاوى';
  } else if (p == AppPermissions.buses) {
    //
    return 'عمليات الباصات';
  } else if (p == AppPermissions.suberUsers) {
    //
    return 'عمليات الأجهزة اللوحية';
  } else if (p == AppPermissions.subscriptions) {
    //
    return 'عمليات الاشتراكات';
  } else if (p == AppPermissions.busTrips) {
    //
    return 'عمليات الرحلات';
  } else if (p == AppPermissions.tempTrips) {
    //
    return 'عمليات نماذج الرحلات';
  } else if (p == AppPermissions.tapTripsTable) {
    //
    return 'عرض جدول الرحلات';
  } else if (p == AppPermissions.tapTripsHistory) {
    //
    return 'سجل الرحلات';
  } else if (p == AppPermissions.tapSubscriptions) {
    //
    return 'عرض الاشتراكات';
  } else if (p == AppPermissions.members) {
    //
    return 'عمليات الطلاب';
  } else if (p == AppPermissions.tapMember) {
    //
    return ' عرض جدول الطلاب';
  } else if (p == AppPermissions.liveTracking) {
    //
    return 'التتبع المباشر';
  } else if (p == AppPermissions.tapBuses) {
  //
    return 'عرض جدول الباصات';
  } else if (p == AppPermissions.tapSuberUser) {
    //
    return 'عرض جدول الأجهزة اللوحية';
  } else if (p == AppPermissions.tapTicket) {
    //
    return 'عرض جدول الشكاوى';
  } else if (p == AppPermissions.tapRoles) {
    //
    return 'عرض جدول الأدوار';
  } else if (p == AppPermissions.tapAdmins) {
    //
    return 'عرض جدول مسؤولي المؤسسة';
  } else if (p == AppPermissions.membersPoints) {
    //
    return 'نقاط الطلاب';
  } //
  return p;
}
