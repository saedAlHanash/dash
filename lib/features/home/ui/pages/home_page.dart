import 'dart:math';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';
import '../../../../core/widgets/admin_side_bar_widget/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/bloc/search_location/search_location_cubit.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/features/accounts/ui/pages/transfers_page.dart';
import 'package:qareeb_dash/features/car_catigory/bloc/delete_car_cat_cubit/delete_car_cat_cubit.dart';
import 'package:qareeb_dash/features/coupons/ui/pages/coupons_page.dart';
import 'package:qareeb_dash/features/redeems/bloc/redeems_cubit/redeems_cubit.dart';
import 'package:qareeb_dash/features/shared_trip/ui/pages/shared_trips_page.dart';
import 'package:qareeb_dash/features/sos/ui/pages/soss_page.dart';
import 'package:qareeb_dash/features/trip/ui/pages/trips_page.dart';
import "package:universal_html/html.dart";

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/logo_text.dart';
import '../../../../generated/assets.dart';
import '../../../accounts/bloc/pay_to_cubit/pay_to_cubit.dart';
import '../../../accounts/ui/pages/company_transfers_page.dart';
import '../../../admins/ui/pages/admins_page.dart';
import '../../../agencies/bloc/create_agency_cubit/create_agency_cubit.dart';
import '../../../agencies/bloc/delete_agency_cubit/delete_agency_cubit.dart';
import '../../../agencies/ui/pages/agencies_page.dart';
import '../../../agencies/ui/pages/agencies_financial_page.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../../auth/ui/pages/policy_page.dart';
import '../../../car_catigory/ui/pages/car_categories_page.dart';
import '../../../clients/ui/pages/clients_page.dart';
import '../../../companies/bloc/delete_company_cubit/delete_company_cubit.dart';
import '../../../companies/ui/pages/companies_page.dart';
import '../../../company_paths/bloc/delete_compane_path_cubit/delete_company_path_cubit.dart';
import '../../../company_paths/ui/pages/company_paths_page.dart';
import '../../../coupons/bloc/change_coupon_state_cubit/change_coupon_state_cubit.dart';
import '../../../coupons/bloc/create_coupon_cubit/create_coupon_cubit.dart';
import '../../../drivers/bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../../drivers/ui/pages/drivers_page.dart';
import '../../../governorates/bloc/create_governorate_cubit/create_governorate_cubit.dart';
import '../../../governorates/bloc/delete_governorate_cubit/delete_governorate_cubit.dart';
import '../../../governorates/ui/pages/governorates_page.dart';
import '../../../institutions/bloc/delete_institution_cubit/delete_institution_cubit.dart';
import '../../../institutions/ui/pages/institutions_page.dart';
import '../../../notifications/ui/pages/notifications_page.dart';
import '../../../pay_to_drivers/ui/pages/financial_page.dart';
import '../../../plan_trips/bloc/delete_plan_trip_cubit/delete_plan_trip_cubit.dart';
import '../../../plan_trips/ui/pages/attendances_page.dart';
import '../../../plan_trips/ui/pages/plan_trips_page.dart';
import '../../../plans/bloc/delete_plan_cubit/delete_plan_cubit.dart';
import '../../../plans/ui/pages/plans_page.dart';
import '../../../points/ui/pages/points_page.dart';
import '../../../reasons/bloc/create_cubit/create_cubit.dart';
import '../../../reasons/bloc/delete_reason_cubit/delete_reason_cubit.dart';
import '../../../reasons/bloc/get_reasons_cubit/get_reasons_cubit.dart';
import '../../../reasons/ui/pages/reasons_page.dart';
import '../../../roles/bloc/create_role_cubit/create_role_cubit.dart';
import '../../../roles/bloc/delete_role_cubit/delete_role_cubit.dart';
import '../../../roles/ui/pages/roles_page.dart';
import '../../../system_params/bloc/update_system_params_cubit/update_system_params_cubit.dart';
import '../../../system_params/ui/pages/system_params_page.dart';
import '../../../system_settings/bloc/update_system_params_cubit/update_system_settings_cubit.dart';
import '../../../system_settings/ui/pages/system_settings_page.dart';
import '../../../temp_trips/bloc/delete_temp_trip_cubit/delete_temp_trip_cubit.dart';
import '../../../temp_trips/ui/pages/temp_trips_page.dart';
import '../../../ticket/bloc/replay_ticket_cubit/replay_ticket_cubit.dart';
import '../../../ticket/ui/pages/tickets_page.dart';
import '../../../wallet/bloc/change_provider_state_cubit/change_provider_state_cubit.dart';
import '../../../wallet/ui/pages/providers_page.dart';
import '../../bloc/nav_home_cubit/nav_home_cubit.dart';
import '../screens/dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController page = PageController();

  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    context
        .read<NavHomeCubit>()
        .changePage('/${getCurrentQueryParameters()['key'] ?? ''}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      String title = '';
      String body = '';

      if (notification != null) {
        title = notification.title ?? '';
        body = notification.body ?? '';
      } else {
        title = message.data['title'] ?? '';
        body = message.data['body'] ?? '';
      }

      ElegantNotification(
        title: Text(title),
        notificationPosition: NotificationPosition.bottomLeft,
        animation: AnimationType.fromLeft,
        width: 0.5.sw,
        iconSize: 15.0.r,
        progressIndicatorColor: AppColorManager.mainColor,
        toastDuration: const Duration(seconds: 25),
        description: Text(body),
        icon: const ImageMultiType(url: Assets.iconsLogoWithoutText),
      ).show(context);

    });
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavHomeCubit, NavHomeInitial>(
      builder: (context, state) {
        return AdminScaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            toolbarHeight: 80.0.h,
            centerTitle: true,
            title: const LogoText(),
            backgroundColor: AppColorManager.f1,
            leading: window.history.length != 0
                ? IconButton(
                    onPressed: () => window.history.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColorManager.mainColorDark,
                    ))
                : 0.0.verticalSpace,
          ),
          sideBar: SideBar(
            key: (Key(Random().nextInt(100000).toString())),
            activeTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: FontManager.cairoBold.name,
              fontSize: 20.0.sp,
            ),
            activeIconColor: Theme.of(context).primaryColor,
            textStyle: TextStyle(
              color: Colors.grey[800],
              fontFamily: FontManager.cairoBold.name,
              fontSize: 20.0.sp,
            ),
            items: [
              const AdminMenuItem(
                title: 'الرئيسية',
                route: '/',
                icon: Icons.dashboard,
              ),

              if (isAllowed(AppPermissions.TRIPS))
                AdminMenuItem(
                  title: 'الرحلات',
                  icon: Icons.turn_right_sharp,
                  children: [
                    if (isAllowed(AppPermissions.SHARED_TRIP))
                      const AdminMenuItem(
                          title: 'الرحلات التشاركية', route: '/shared_trips'),
                    if (isAllowed(AppPermissions.TRIPS))
                      const AdminMenuItem(title: 'الرحلات العادية', route: '/trips'),
                  ],
                ),
              //المستخدمين
              AdminMenuItem(
                title: 'المستخدمين',
                icon: Icons.supervised_user_circle_sharp,
                children: [
                  if (isAllowed(AppPermissions.CUSTOMERS))
                    const AdminMenuItem(title: 'الزبائن', route: '/customers'),
                  if (isAllowed(AppPermissions.DRIVERS))
                    const AdminMenuItem(title: 'السائقين', route: '/drivers'),
                  if (isAllowed(AppPermissions.USERS))
                    const AdminMenuItem(title: 'مسؤولي النظام', route: '/sys_admins'),
                ],
              ),

              if (isQareebAdmin) ...[
                AdminMenuItem(
                  title: 'الطلبات',
                  icon: Icons.reorder_sharp,
                  children: [
                    if (isAllowed(AppPermissions.EPAYMENT))
                      const AdminMenuItem(
                          title: 'مزودي الدفع',
                          route: '/epayments_provider',
                          icon: Icons.paypal),
                    if (isAllowed(AppPermissions.COUPON))
                      const AdminMenuItem(
                          title: 'قسائم الحسم',
                          route: '/coupons',
                          icon: Icons.candlestick_chart),
                    if (isAllowed(AppPermissions.CAR_CATEGORY))
                      const AdminMenuItem(
                          title: 'أصناف السيارات',
                          route: '/car_categories',
                          icon: Icons.directions_car_filled_sharp),
                  ],
                ),
                AdminMenuItem(
                  title: 'النقاط والمسارات',
                  icon: Icons.timeline_sharp,
                  children: [
                    if (isAllowed(AppPermissions.POINTS))
                      const AdminMenuItem(
                        route: '/points',
                        icon: Icons.location_on_sharp,
                        title: 'النقاط',
                      ),
                    const AdminMenuItem(
                      icon: Icons.linear_scale_rounded,
                      title: 'المسارات',
                      route: "/paths",
                    ),
                  ],
                ),
                AdminMenuItem(
                  title: 'عمليات إدارية',
                  icon: Icons.manage_accounts,
                  children: [
                    const AdminMenuItem(
                      title: 'المحافظات',
                      route: '/government',
                    ),
                    if (isAllowed(AppPermissions.CAR_CATEGORY))
                      const AdminMenuItem(
                          title: 'المؤسسات',
                          route: '/institutions',
                          icon: Icons.home_work_outlined),
                    if (isAllowed(AppPermissions.CAR_CATEGORY))
                      const AdminMenuItem(
                          title: 'الوكلاء',
                          route: '/agencies',
                          icon: Icons.person_pin_outlined),
                    if (isAllowed(AppPermissions.ROLES))
                      const AdminMenuItem(
                          title: 'الأدوار', route: '/roles', icon: Icons.menu_book),
                    const AdminMenuItem(
                      title: 'إعدادات',
                      route: '/systemParams',
                      icon: Icons.settings,
                    ),
                    const AdminMenuItem(
                        title: 'إدارة الإصدارات', route: '/systemVersion'),
                  ],
                ),
                const AdminMenuItem(
                  title: 'الاشتراكات',
                  icon: Icons.ads_click,
                  children: [
                    AdminMenuItem(
                      title: 'الخطط',
                      route: '/allPlans',
                      icon: Icons.stay_primary_landscape_sharp,
                    ),
                    AdminMenuItem(
                      title: 'الشركات',
                      route: '/companies',
                      icon: Icons.home_repair_service,
                    ),
                    AdminMenuItem(
                      icon: Icons.linear_scale_rounded,
                      title: 'مسارات الشركات',
                      route: '/subscriptions',
                    ),
                    AdminMenuItem(
                      icon: Icons.line_axis_sharp,
                      title: 'الرحلات',
                      route: '/planTrips',
                    ),
                    AdminMenuItem(
                      icon: Icons.history,
                      title: 'السجل',
                      route: '/planTripsHistory',
                    ),
                  ],
                ),
                AdminMenuItem(
                  title: 'عمليات مالية',
                  icon: Icons.payments_outlined,
                  children: [
                    if (isAllowed(AppPermissions.REPORTS)) ...[
                      const AdminMenuItem(
                        title: 'التحويلات',
                        icon: Icons.mobiledata_off,
                        route: "/transactions",
                      ),
                      const AdminMenuItem(
                        title: 'عائدات الشركة',
                        icon: Icons.incomplete_circle,
                        route: "/company_transfers",
                      ),
                    ],
                    if (isAllowed(AppPermissions.SETTINGS)) ...[
                      const AdminMenuItem(
                        title: 'محاسبة السائقين',
                        route: "/payToDrivers",
                        icon: Icons.attach_money_outlined,
                      ),
                      const AdminMenuItem(
                        title: 'محاسبة الوكلاء',
                        route: "/payToAgency",
                        icon: Icons.attach_money_outlined,
                      ),
                    ],

                    // const AdminMenuItem(title: 'التقاص', route: "/payToDrivers"),
                  ],
                ),
              ],

              if (isAllowed(AppPermissions.MESSAGES))
                AdminMenuItem(children: [
                  if (isAllowed(AppPermissions.SETTINGS))
                    const AdminMenuItem(
                        icon: Icons.notification_add,
                        title: 'إشعارات الزبائن',
                        route: "/notification"),
                  const AdminMenuItem(
                      icon: Icons.message, title: 'الشكاوى', route: "/ticket"),
                  const AdminMenuItem(
                      icon: Icons.sos, title: 'رسائل الاستغاثة', route: "/sos"),
                ], icon: Icons.support_agent, title: 'التواصل'),

              if (isAllowed(AppPermissions.SETTINGS))
                const AdminMenuItem(
                    icon: Icons.privacy_tip_rounded,
                    title: 'سياسة الخصوصية',
                    route: "/policy"),
            ],
            selectedRoute: state.page,
            onSelected: (item) {
              setState(() {
                context.read<NavHomeCubit>().changePage(item.route!);
              });
            },
            header: InkWell(
              child: Container(
                height: 50,
                width: double.infinity,
                color: AppColorManager.mainColor,
                child: Center(
                  child: DrawableText(
                    color: Colors.white,
                    text: AppSharedPreference.getEmail,
                  ),
                ),
              ),
            ),
            footer: Container(
              height: 50.h,
              alignment: Alignment.center,
              width: double.infinity,
              color: AppColorManager.mainColor,
              child: InkWell(
                onTap: () {
                  // popAllJs();
                  AppSharedPreference.logout();
                  APIService.reInitial();
                  window.location.reload();
                  // context.pushNamed(GoRouteName.loginPage);
                },
                child: const DrawableText(
                  text: 'تسجيل الخروج',
                  selectable: false,
                  matchParent: true,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Builder(builder: (context) {
              addQueryParameters(params: {'key': state.page.replaceAll('/', '')});
              switch (state.page) {
                case "/":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (context) => sl<RedeemsCubit>()..getRedeems(context)),
                      BlocProvider(create: (context) => sl<LoyaltyCubit>()),
                    ],
                    child: const DashboardPage(),
                  );
                case "/policy":
                  return const PrivacyPolicyPage();
                case "/notification":
                  return const NotificationPage();
                case "/drivers":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<LoyaltyCubit>()),
                      BlocProvider(create: (_) => sl<ChangeUserStateCubit>()),
                    ],
                    child: const DriverPage(),
                  );
                case "/shared_trips":
                  return const SharedTripsPage();
                case "/trips":
                  return const TripsPage();
                case "/sys_admins":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<ChangeUserStateCubit>()),
                    ],
                    child: const AdminPage(),
                  );
                case "/customers":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<ChangeUserStateCubit>()),
                    ],
                    child: const ClientsPage(),
                  );
                case "/systemParams":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<UpdateParamsCubit>()),
                    ],
                    child: const ParamsPage(),
                  );
                case "/systemVersion":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<UpdateSettingCubit>()),
                    ],
                    child: const SettingPage(),
                  );
                case "/coupons":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<CreateCouponCubit>()),
                      BlocProvider(create: (context) => sl<ChangeCouponStateCubit>()),
                    ],
                    child: const CouponPage(),
                  );

                case "/roles":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<CreateRoleCubit>()),
                      BlocProvider(create: (context) => sl<DeleteRoleCubit>()),
                    ],
                    child: const RolesPage(),
                  );

                case "/points":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<MapControllerCubit>()),
                      BlocProvider(create: (context) => sl<SearchLocationCubit>()),
                      BlocProvider(create: (context) => sl<AtherCubit>()),
                    ],
                    child: const PointsPage(),
                  );
                case "/epayments_provider":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<ChangeProviderStateCubit>()),
                    ],
                    child: const ProvidersPage(),
                  );

                case "/transactions":
                  return const TransfersPage();
                case "/company_transfers":
                  return const CompanyTransfersPage();

                case "/car_categories":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteCarCatCubit>()),
                    ],
                    child: const CarCategoriesPage(),
                  );
                case "/institutions":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<DeleteInstitutionCubit>()),
                    ],
                    child: const InstitutionsPage(),
                  );

                case "/cancel_reasons":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteReasonCubit>()),
                      BlocProvider(create: (context) => sl<CreateReasonCubit>()),
                      BlocProvider(
                        create: (context) => sl<GetReasonsCubit>()..getReasons(context),
                      ),
                    ],
                    child: const ReasonsPage(),
                  );
                case "/agencies":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteAgencyCubit>()),
                      BlocProvider(create: (context) => sl<CreateAgencyCubit>()),
                    ],
                    child: const AgenciesPage(),
                  );

                case "/government":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteGovernorateCubit>()),
                      BlocProvider(create: (context) => sl<CreateGovernorateCubit>()),
                    ],
                    child: const GovernoratesPage(),
                  );
                case "/ticket":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<ReplayTicketCubit>()),
                    ],
                    child: const TicketsPage(),
                  );
                case "/sos":
                  return const SosPage();
                case "/paths":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteTempTripCubit>()),
                    ],
                    child: const TempTripsPage(),
                  );

                case "/subscriptions":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteCompanyPathCubit>()),
                    ],
                    child: const CompanyPathsPage(),
                  );

                case '/planTrips':
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeletePlanTripCubit>()),
                    ],
                    child: const PlanTripsPage(),
                  );

                case '/planTripsHistory':
                  return const AttendancesPage();

                case "/allPlans":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<DeletePlanCubit>()),
                    ],
                    child: const PlansPage(),
                  );

                case "/companies":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<DeleteCompanyCubit>()),
                    ],
                    child: const CompaniesPage(),
                  );

                case "/payToDrivers":
                  return MultiBlocProvider(
                    providers: [
                      // BlocProvider(
                      //   create: (_) => sl<AllTransfersCubit>()
                      //     ..getAllTransfers(
                      //       _,
                      //       command: Command.initial()
                      //         ..transferFilterRequest =
                      //             TransferFilterRequest(type: TransferType.debit),
                      //     ),
                      // ),
                      BlocProvider(create: (_) => sl<PayToCubit>()),
                    ],
                    child: const FinancialPage(),
                  );

                case "/payToAgency":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<PayToCubit>()),
                    ],
                    child: const AgencyFinancialPage(),
                  );
              }
              return SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  child: const SelectableText(
                    'Dashboard',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

void addQueryParameters({required Map<String, dynamic> params}) {
  final uri = window.location.href;
  final parsedUri = Uri.parse(uri);
  if (!parsedUri.toString().contains('Home')) return;
  // context.pushNamed(GoRouteName.homePage, queryParams: params);

  final newQuery = Map.from(parsedUri.queryParameters)..addAll(params);
  final s = <String, String>{};
  newQuery.forEach((key, value) => s[key.toString()] = value.toString());
  final newUri = Uri(
    scheme: parsedUri.scheme,
    host: parsedUri.host,
    port: parsedUri.port,
    path: parsedUri.path,
    queryParameters: s,
  );
  window.history.pushState(null, '', newUri.toString());
}

// Get query parameters from the current URL
Map<String, String> getCurrentQueryParameters() {
  final uri = Uri.parse(window.location.href);
  return uri.queryParameters;
}
