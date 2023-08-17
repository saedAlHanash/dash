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
  static const CREATION = "Create_Permission";
  static const UPDATE = "Update_Permission";
  static const DELETE = "Delete_Permission";
  static const EPAYMENT = "Pages.Epayment";
  static const CAR_CATEGORY = "Pages.CarCategory";
  static const TENANTS = "Pages.Tenants";
  static const USERS = "Pages.Users";
  static const USERS_ACTIVATION = "Pages.Users.Activation";
  static const ROLES = "Pages.Roles";
  static const COUPON = "Pages.Coupon";
  static const REASON = "Pages.Reason";
  static const REPORTS = "Pages.Reports";
  static const CUSTOMERS = "Pages.Customers";
  static const MESSAGES = "Pages.Messages";
  static const DRIVERS = "Pages.Drivers";
  static const TRIPS = "Pages.Trips";
  static const POINTS = "Pages.Points";
  static const SHARED_TRIP = "Pages.SharedTrip";
  static const ACCEPT_ORDER = "Pages.accept_order";
  static const SETTINGS = "Pages.Settings";
}

String tranzlatePermition(String p) {
  if (p == AppPermissions.CREATION) {
    return 'عمليات مسرولي لوحة التحكم';
  } else if (p == AppPermissions.UPDATE) {
    return 'عمليات الأدوار';
  } else if (p == AppPermissions.DELETE) {
    return 'الشكاوى';
  } else if (p == AppPermissions.EPAYMENT) {
    return 'عمليات الباصات';
  } else if (p == AppPermissions.CAR_CATEGORY) {
    return 'عمليات الأجهزة اللوحية';
  } else if (p == AppPermissions.TENANTS) {
    return 'عمليات الاشتراكات';
  } else if (p == AppPermissions.USERS) {
    return 'عمليات الرحلات';
  } else if (p == AppPermissions.USERS_ACTIVATION) {
    return 'عمليات نماذج الرحلات';
  } else if (p == AppPermissions.ROLES) {
    return 'عمليات الأدوار';
  } else if (p == AppPermissions.COUPON) {
    return 'عرض سجب الرحلات';
  } else if (p == AppPermissions.REASON) {
    return 'عمليات الاشتراكات';
  } else if (p == AppPermissions.REPORTS) {
    return '';
  } else if (p == AppPermissions.CUSTOMERS) {
    return '';
  } else if (p == AppPermissions.MESSAGES) {
    return '';
  } else if (p == AppPermissions.DRIVERS) {
    return '';
  } else if (p == AppPermissions.TRIPS) {
    return '';
  } else if (p == AppPermissions.POINTS) {
    return '';
  } else if (p == AppPermissions.SHARED_TRIP) {
    return '';
  } else if (p == AppPermissions.ACCEPT_ORDER) {
    return '';
  } else if (p == AppPermissions.SETTINGS) {
    return '';
  }
  return '';
}
