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
  }
  if (phone.startsWith("0") && phone.length < 10) {
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

bool get canPopJs => window.history.length > 1;

bool get allowedNormalTrips =>
    AppSharedPreference.myPermissions.contains(AppPermissions.normalTrips);

bool get allowedManageNormalTrips =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageNormalTrips);

bool get allowedSharedTrips =>
    AppSharedPreference.myPermissions.contains(AppPermissions.sharedTrips);

bool get allowedManageSharedTrips =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageSharedTrips);

bool get allowedClients =>
    AppSharedPreference.myPermissions.contains(AppPermissions.clients);

bool get allowedManageClients =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageClients);

bool get allowedDrivers =>
    AppSharedPreference.myPermissions.contains(AppPermissions.drivers);

bool get allowedManageDrivers =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageDrivers);

bool get allowedLoyalty =>
    AppSharedPreference.myPermissions.contains(AppPermissions.loyalty);

bool get allowedAdmins =>
    AppSharedPreference.myPermissions.contains(AppPermissions.admins);

bool get allowedCarCategories =>
    AppSharedPreference.myPermissions.contains(AppPermissions.carCategories);

bool get allowedEPayments =>
    AppSharedPreference.myPermissions.contains(AppPermissions.ePayments);

bool get allowedCoupons =>
    AppSharedPreference.myPermissions.contains(AppPermissions.coupons);

bool get allowedPoints =>
    AppSharedPreference.myPermissions.contains(AppPermissions.points);

bool get allowedManagePoints =>
    AppSharedPreference.myPermissions.contains(AppPermissions.managePoints);

bool get allowedConnectPoint =>
    AppSharedPreference.myPermissions.contains(AppPermissions.connectPoint);

bool get allowedPaths => AppSharedPreference.myPermissions.contains(AppPermissions.paths);

bool get allowedManagePaths =>
    AppSharedPreference.myPermissions.contains(AppPermissions.managePaths);

bool get allowedGovernorate =>
    AppSharedPreference.myPermissions.contains(AppPermissions.governorate);

bool get allowedInstitutions =>
    AppSharedPreference.myPermissions.contains(AppPermissions.institutions);

bool get allowedManageInstitutions =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageInstitutions);

bool get allowedAgency =>
    AppSharedPreference.myPermissions.contains(AppPermissions.agency);

bool get allowedManageAgency =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageAgency);

bool get allowedRoles => AppSharedPreference.myPermissions.contains(AppPermissions.roles);

bool get allowedManageRoles =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageRoles);

bool get allowedSystemParams =>
    AppSharedPreference.myPermissions.contains(AppPermissions.systemParams);

bool get allowedVersionControl =>
    AppSharedPreference.myPermissions.contains(AppPermissions.versionControl);

bool get allowedPlans => AppSharedPreference.myPermissions.contains(AppPermissions.plans);

bool get allowedManagePlans =>
    AppSharedPreference.myPermissions.contains(AppPermissions.managePlans);

bool get allowedEnrollments =>
    AppSharedPreference.myPermissions.contains(AppPermissions.enrollments);

bool get allowedManageEnrollments =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageEnrollments);

bool get allowedCompanies =>
    AppSharedPreference.myPermissions.contains(AppPermissions.companies);

bool get allowedManageCompanies =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageCompanies);

bool get allowedCompanyPaths =>
    AppSharedPreference.myPermissions.contains(AppPermissions.companyPaths);

bool get allowedManageCompanyPaths =>
    AppSharedPreference.myPermissions.contains(AppPermissions.manageCompanyPaths);

bool get allowedPlanTrips =>
    AppSharedPreference.myPermissions.contains(AppPermissions.planTrips);

bool get allowedManagePlanTrips =>
    AppSharedPreference.myPermissions.contains(AppPermissions.managePlanTrips);

bool get allowedPlanTripsHistory =>
    AppSharedPreference.myPermissions.contains(AppPermissions.planTripsHistory);

bool get allowedTransactions =>
    AppSharedPreference.myPermissions.contains(AppPermissions.transactions);

bool get allowedRePay => AppSharedPreference.myPermissions.contains(AppPermissions.rePay);

bool get allowedChargeWallet =>
    AppSharedPreference.myPermissions.contains(AppPermissions.chargeWallet);

bool get allowedCompanyIncome =>
    AppSharedPreference.myPermissions.contains(AppPermissions.companyIncome);

bool get allowedPayToSyrian =>
    AppSharedPreference.myPermissions.contains(AppPermissions.payToSyrian);

bool get allowedSyrianIncome =>
    AppSharedPreference.myPermissions.contains(AppPermissions.syrianIncome);

bool get allowedPayToDriver =>
    AppSharedPreference.myPermissions.contains(AppPermissions.payToDriver);

bool get allowedPayToAgency =>
    AppSharedPreference.myPermissions.contains(AppPermissions.payToAgency);

bool get allowedNotifications =>
    AppSharedPreference.myPermissions.contains(AppPermissions.notifications);

bool get allowedTickets =>
    AppSharedPreference.myPermissions.contains(AppPermissions.tickets);

bool get allowedSos => AppSharedPreference.myPermissions.contains(AppPermissions.sos);

bool get allowedPolicy =>
    AppSharedPreference.myPermissions.contains(AppPermissions.policy);

class AppPermissions {
  static String normalTrips = "Pages.Reason";
  static String manageNormalTrips = "Pages.Reports";
  static String sharedTrips = "Pages.Trips";
  static String manageSharedTrips = "Pages.Messages";
  static String clients = "Pages.Customers";
  static String manageClients = "Pages.Drivers";
  static String drivers = "Pages.Coupon";
  static String manageDrivers = "Create_Permission";
  static String loyalty = "Update_Permission";
  static String admins = "Delete_Permission";
  static String carCategories = "Pages.CarCategory";
  static String ePayments = "Pages.Epayment";
  static String coupons = "Pages.Settings";
  static String points = "Pages.Points";
  static String managePoints = "Pages.SharedTrip";
  static String connectPoint = "Pages.Users";
  static String paths = "Pages.Roles";
  static String managePaths = "Pages.Users.Activation";

  static String governorate = "admin.governorate";
  static String institutions = "admin.institutions";
  static String manageInstitutions = "admin.manageInstitutions";
  static String agency = "admin.agency";
  static String manageAgency = "admin.manageAgency";
  static String roles = "admin.roles";
  static String manageRoles = "admin.manageRoles";
  static String systemParams = "admin.systemParams";
  static String versionControl = "admin.versionControl";
  static String plans = "admin.plans";
  static String managePlans = "admin.managePlans";
  static String enrollments = "admin.enrollments";
  static String manageEnrollments = "admin.manageEnrollments";
  static String companies = "admin.companies";
  static String manageCompanies = "admin.manageCompanies";
  static String companyPaths = "admin.companyPaths";
  static String manageCompanyPaths = "admin.manageCompanyPaths";
  static String planTrips = "admin.planTrips";
  static String managePlanTrips = "admin.managePlanTrips";
  static String planTripsHistory = "admin.planTripsHistory";
  static String transactions = "admin.transactions";
  static String rePay = "admin.rePay";
  static String chargeWallet = "admin.chargeWallet";
  static String companyIncome = "admin.companyIncome";
  static String payToSyrian = "admin.payToSyrian";
  static String syrianIncome = "admin.syrianIncome";
  static String payToDriver = "admin.payToDriver";
  static String payToAgency = "admin.payToAgency";
  static String notifications = "admin.notifications";
  static String tickets = "admin.tickets";
  static String sos = "admin.sos";
  static String policy = "admin.policy";
}

String translatePermission(String p) {
  if (p == AppPermissions.normalTrips) {
    return 'عرض الرحلات العادية';
  }
  if (p == AppPermissions.manageNormalTrips) {
    return 'إدارة الرحلات العادية';
  }
  if (p == AppPermissions.sharedTrips) {
    return 'عرض الرحلات التشاركية';
  }
  if (p == AppPermissions.manageSharedTrips) {
    return 'إدارة الرحلات التشاركية';
  }
  if (p == AppPermissions.clients) {
    return 'عرض الزبائن';
  }
  if (p == AppPermissions.manageClients) {
    return 'إدارة الزبائن';
  }
  if (p == AppPermissions.drivers) {
    return 'عرض السائقين';
  }
  if (p == AppPermissions.manageDrivers) {
    return 'إدارة السائقين';
  }
  if (p == AppPermissions.loyalty) {
    return 'إدارة الولاء';
  }
  if (p == AppPermissions.admins) {
    return 'عرض المدراء';
  }
  if (p == AppPermissions.carCategories) {
    return 'عرض وإدارة أصناف السيارات';
  }
  if (p == AppPermissions.ePayments) {
    return 'عرض وإدارة مزودات الدفع ';
  }
  if (p == AppPermissions.coupons) {
    return 'عرض وإدارة قسائم الحسم';
  }
  if (p == AppPermissions.points) {
    return 'عرض النقاط';
  }
  if (p == AppPermissions.managePoints) {
    return 'إدارة النقاط';
  }
  if (p == AppPermissions.connectPoint) {
    return 'توصيل النقاط';
  }
  if (p == AppPermissions.paths) {
    return 'عرض المسارات';
  }
  if (p == AppPermissions.managePaths) {
    return 'إدارة المسارات';
  }
  if (p == AppPermissions.governorate) {
    return 'العمليات الإدارية';
  }

  if (p == AppPermissions.governorate) {
    return 'المحافظات';
  }
  if (p == AppPermissions.institutions) {
    return 'المؤسسات';
  }
  if (p == AppPermissions.manageInstitutions) {
    return 'إدارة المؤسسات';
  }
  if (p == AppPermissions.agency) {
    return 'الوكلاء';
  }
  if (p == AppPermissions.manageAgency) {
    return 'إدارة الوكلاء';
  }
  if (p == AppPermissions.roles) {
    return 'الأدوار';
  }
  if (p == AppPermissions.manageRoles) {
    return 'إدارة الأدوار';
  }
  if (p == AppPermissions.systemParams) {
    return 'متغيرات النظام والإعدادات';
  }
  if (p == AppPermissions.versionControl) {
    return 'إدارة الإصدارات';
  }
  if (p == AppPermissions.plans) {
    return 'الخطط والباقات';
  }
  if (p == AppPermissions.managePlans) {
    return 'إدارة الخطط والباقات';
  }
  if (p == AppPermissions.enrollments) {
    return 'المشتركين';
  }
  if (p == AppPermissions.manageEnrollments) {
    return 'إدارة المشتركين';
  }
  if (p == AppPermissions.companies) {
    return 'الشركات';
  }
  if (p == AppPermissions.manageCompanies) {
    return 'إدارة الشركات';
  }
  if (p == AppPermissions.companyPaths) {
    return 'مسارات الشركات';
  }
  if (p == AppPermissions.manageCompanyPaths) {
    return 'إدارة مسارات الشركات';
  }
  if (p == AppPermissions.planTrips) {
    return 'رحلات الاشتراكات';
  }
  if (p == AppPermissions.managePlanTrips) {
    return 'إدارة رحلات الاشتراكات';
  }
  if (p == AppPermissions.planTripsHistory) {
    return 'سجل رحلات الاشتراكات';
  }
  if (p == AppPermissions.transactions) {
    return 'التحويلات المالية';
  }
  if (p == AppPermissions.rePay) {
    return 'الشحن التعويضي';
  }
  if (p == AppPermissions.chargeWallet) {
    return 'شحن رصيد';
  }
  if (p == AppPermissions.companyIncome) {
    return 'عائدات الشركة';
  }
  if (p == AppPermissions.payToSyrian) {
    return 'محاسبة الهيئة';
  }
  if (p == AppPermissions.syrianIncome) {
    return 'عائدات الهيئة';
  }
  if (p == AppPermissions.payToDriver) {
    return 'محاسبة السائقين';
  }
  if (p == AppPermissions.payToAgency) {
    return 'محاسبة الوكلاء';
  }
  if (p == AppPermissions.notifications) {
    return 'إرسال إشعارات';
  }
  if (p == AppPermissions.tickets) {
    return 'الشكاوى والردود';
  }
  if (p == AppPermissions.sos) {
    return 'رسائل الاستغاثة';
  }
  if (p == AppPermissions.policy) {
    return 'سياسة الخصوصية';
  }
  return p;
}
