import 'dart:html';
import 'dart:math';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/bloc/search_location/search_location_cubit.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_dash/features/accounts/ui/pages/transfers_page.dart';
import 'package:qareeb_dash/features/car_catigory/bloc/delete_car_cat_cubit/delete_car_cat_cubit.dart';
import 'package:qareeb_dash/features/coupons/ui/pages/coupons_page.dart';

import 'package:qareeb_dash/features/messages/ui/pages/messages_page.dart';
import 'package:qareeb_dash/features/redeems/bloc/redeems_cubit/redeems_cubit.dart';
import 'package:qareeb_dash/features/shared_trip/ui/pages/shared_trips_page.dart';
import 'package:qareeb_dash/features/trip/ui/pages/trips_page.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/logo_text.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../../accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../../accounts/data/request/transfer_filter_request.dart';
import '../../../admins/ui/pages/admins_page.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../../auth/ui/pages/policy_page.dart';
import '../../../car_catigory/ui/pages/car_categories_page.dart';
import '../../../clients/ui/pages/clients_page.dart';
import '../../../coupons/bloc/create_coupon_cubit/create_coupon_cubit.dart';
import '../../../drivers/bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../../drivers/ui/pages/drivers_page.dart';
import '../../../institutions/bloc/delete_institution_cubit/delete_institution_cubit.dart';
import '../../../institutions/ui/pages/institutions_page.dart';

import '../../../pay_to_drivers/bloc/pay_to_cubit/pay_to_cubit.dart';
import '../../../pay_to_drivers/ui/pages/pay_to_drivers_page.dart';

import '../../../points/ui/pages/points_page.dart';
import '../../../reasons/bloc/create_cubit/create_cubit.dart';
import '../../../reasons/bloc/delete_reason_cubit/delete_reason_cubit.dart';
import '../../../reasons/bloc/get_reasons_cubit/get_reasons_cubit.dart';
import '../../../reasons/ui/pages/reasons_page.dart';
import '../../../roles/bloc/create_role_cubit/create_role_cubit.dart';
import '../../../roles/bloc/delete_role_cubit/delete_role_cubit.dart';
import '../../../roles/ui/pages/roles_page.dart';
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
            leading: Navigator.canPop(context)
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
              AdminMenuItem(
                title: 'المستخدمين',
                icon: Icons.supervised_user_circle_sharp,
                route: "/drivers",
                children: [
                  if (isAllowed(AppPermissions.CUSTOMERS))
                    const AdminMenuItem(title: 'الزبائن', route: '/customers'),
                  if (isAllowed(AppPermissions.DRIVERS))
                    const AdminMenuItem(title: 'السائقين', route: '/drivers'),
                  if (isAllowed(AppPermissions.USERS))
                    const AdminMenuItem(title: 'مسؤولي النظام', route: '/sys_admins'),
                ],
              ),
              AdminMenuItem(
                title: 'الطلبات',
                route: "/epayments",
                children: [
                  if (isAllowed(AppPermissions.POINTS))
                    const AdminMenuItem(title: 'النقاط', route: '/points'),
                  if (isAllowed(AppPermissions.REASON))
                    const AdminMenuItem(title: 'أسباب الإلغاء', route: '/cancel_reasons'),
                  if (isAllowed(AppPermissions.EPAYMENT))
                    const AdminMenuItem(
                        title: 'مزودي الدفع', route: '/epayments_provider'),
                  if (isAllowed(AppPermissions.COUPON))
                    const AdminMenuItem(title: 'قسائم الحسم', route: '/coupons'),
                  if (isAllowed(AppPermissions.CAR_CATEGORY))
                    const AdminMenuItem(
                        title: 'أصناف السيارات', route: '/car_categories'),
                  if (isAllowed(AppPermissions.CAR_CATEGORY))
                    const AdminMenuItem(title: 'المؤسسات', route: '/institutions'),
                  if (isAllowed(AppPermissions.ROLES))
                    const AdminMenuItem(title: 'الأدوار', route: '/roles'),
                ],
              ),
              if (isAllowed(AppPermissions.REPORTS))
                const AdminMenuItem(
                    title: 'المعاملات',
                    //   icon:Icons.,
                    route: "/transactions"),
              if (isAllowed(AppPermissions.SETTINGS))
                const AdminMenuItem(
                    icon: Icons.payments_outlined,
                    title: 'دفعات السائقين',
                    route: "/payToDrivers"),
              if (isAllowed(AppPermissions.SETTINGS))
                const AdminMenuItem(
                    icon: Icons.privacy_tip_rounded,
                    title: 'سياسة الخصوصية',
                    route: "/policy"),
              if (isAllowed(AppPermissions.MESSAGES))
                const AdminMenuItem(
                    icon: Icons.message, title: 'الرسائل', route: "/messages"),
            ],
            selectedRoute: state.page,
            onSelected: (item) {
              setState(() {
                context.read<NavHomeCubit>().changePage(item.route!);
              });
            },
            header: Container(
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
            footer: Container(
              height: 50,
              alignment: Alignment.center,
              width: double.infinity,
              color: AppColorManager.mainColor,
              child: InkWell(
                onTap: () {
                  AppSharedPreference.logout();
                  while (Navigator.canPop(context)) {
                    window.history.back();
                  }
                  context.pushNamed(GoRouteName.loginPage);
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
                case "/drivers":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<LoyaltyCubit>()),
                      BlocProvider(create: (context) => sl<ChangeUserStateCubit>()),
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
                case "/coupons":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<CreateCouponCubit>()),
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
                case "/messages":
                  return const MessagesPage();
                case "/payToDrivers":
                  final request = TransferFilterRequest();
                  request
                    ..userId = 1
                    ..type = TransferType.debit;

                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => sl<AllTransfersCubit>()
                          ..getAllTransfers(
                            _,
                            command: Command.initial()..transferFilterRequest = request,
                          ),
                      ),
                      BlocProvider(create: (_) => sl<PayToCubit>()),
                      BlocProvider(create: (_) => sl<AccountAmountCubit>()),
                    ],
                    child: const PayToDriversPage(),
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
}
