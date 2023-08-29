import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../router/go_route_pages.dart';
import '../../../admins/ui/pages/admins_page.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../../bus_trips/bloc/delete_bus_trip_cubit/delete_bus_trip_cubit.dart';
import '../../../bus_trips/ui/pages/bus_trips_page.dart';
import '../../../bus_trips/ui/pages/trip_history_page.dart';
import '../../../buses/bloc/delete_buss_cubit/delete_buss_cubit.dart';
import '../../../buses/ui/pages/buses_page.dart';
import '../../../map/bloc/ather_cubit/ather_cubit.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../map/bloc/set_point_cubit/map_control_cubit.dart';
import '../../../members/ui/pages/memberss_page.dart';
import '../../../roles/bloc/create_role_cubit/create_role_cubit.dart';
import '../../../roles/bloc/delete_role_cubit/delete_role_cubit.dart';
import '../../../roles/ui/pages/roles_page.dart';
import '../../../subscriptions/bloc/delete_subscription_cubit/delete_subscription_cubit.dart';
import '../../../subscriptions/ui/pages/subscriptions_page.dart';
import '../../../super_user/bloc/delete_super_user_cubit/delete_super_user_cubit.dart';
import '../../../super_user/ui/pages/super_users_page.dart';
import '../../../temp_trips/bloc/delete_temp_trip_cubit/delete_temp_trip_cubit.dart';
import '../../../temp_trips/ui/pages/temp_trips_page.dart';
import '../../../ticket/bloc/replay_ticket_cubit/replay_ticket_cubit.dart';
import '../../../ticket/ui/pages/tickets_page.dart';
import '../../bloc/home1_cubit/home1_cubit.dart';
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
    context.read<Home1Cubit>().getHome1(context);
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
            actionsIconTheme: const IconThemeData(color: AppColorManager.mainColor),
            toolbarHeight: 80.0.h,
            centerTitle: true,
            title: BlocBuilder<Home1Cubit, Home1Initial>(
              builder: (context, state1) {
                return DrawableText(
                  text: state1.result.name,
                  fontFamily: FontManager.cairoBold,
                );
              },
            ),
            backgroundColor: AppColorManager.f1,
            actions: [
              BlocBuilder<Home1Cubit, Home1Initial>(
                builder: (context, state1) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                    child: ImageMultiType(
                      url: state1.result.imageUrl,
                    ),
                  );
                },
              )
            ],
            leading: context.canPop()
                ? IconButton(
                    onPressed: () => window.history.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColorManager.mainColorDark,
                    ),
                  )
                : 0.0.verticalSpace,
          ),
          sideBar: SideBar(
            key: UniqueKey(),
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
                route: NamePaths.home,
                icon: Icons.dashboard,
              ),
              if (isAllowed(AppPermissions.tapBuses) &&
                  isAllowed(AppPermissions.tapSuberUser))
                AdminMenuItem(
                  title: 'الباصات',
                  icon: Icons.bus_alert_sharp,
                  children: [
                    if (isAllowed(AppPermissions.tapBuses))
                      const AdminMenuItem(title: 'قائمة الباصات', route: NamePaths.buses),
                    if (isAllowed(AppPermissions.tapSuberUser))
                      const AdminMenuItem(
                          title: 'الأجهزة اللوحية', route: NamePaths.superUser),
                  ],
                ),
              AdminMenuItem(
                title: 'الرحلات',
                icon: Icons.supervised_user_circle_sharp,
                children: [
                  const AdminMenuItem(title: 'نماذج الرحلات', route: NamePaths.tempTrips),
                  if (isAllowed(AppPermissions.tapTripsTable))
                    const AdminMenuItem(title: 'جدول الرحلات', route: NamePaths.trips),
                  if (isAllowed(AppPermissions.tapTripsHistory))
                    const AdminMenuItem(
                        title: 'سجل الرحلات', route: NamePaths.tripHistory),
                ],
              ),
              AdminMenuItem(
                title: 'الطلاب',
                icon: Icons.group,
                children: [
                  if (isAllowed(AppPermissions.tapSubscriptions))
                    const AdminMenuItem(
                        title: 'نماذج الاشتراكات', route: NamePaths.subscriptions),
                  const AdminMenuItem(title: 'الطلاب', route: NamePaths.members),
                ],
              ),
              if (isAllowed(AppPermissions.tapRoles) &&
                  isAllowed(AppPermissions.tapAdmins))
                AdminMenuItem(
                  title: 'مستخدمي لوحة التحكم',
                  icon: Icons.admin_panel_settings,
                  children: [
                    if (isAllowed(AppPermissions.tapRoles))
                      const AdminMenuItem(title: 'الأدوار', route: NamePaths.roles),
                    if (isAllowed(AppPermissions.tapAdmins))
                      const AdminMenuItem(title: 'مسؤولي النظام', route: '/sys_admins'),
                  ],
                ),
              const AdminMenuItem(title: 'الشكاوى', route: '/ticket'),
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

                  // while (Navigator.canPop(context)) {
                  //   window.history.back();
                  // }

                  window.location.reload();

                  // context.pushNamed(GoRouteName.loginPage);
                },
                child: const DrawableText(
                  text: 'تسجيل الخروج',
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
                case NamePaths.home:
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<AtherCubit>()),
                      BlocProvider(create: (context) => sl<MapControlCubit>()),
                      BlocProvider(create: (context) => sl<MapControllerCubit>()),
                    ],
                    child: const DashboardPage(),
                  );
                case NamePaths.buses:
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteBusCubit>()),
                    ],
                    child: const BusesPage(),
                  );
                case NamePaths.superUser:
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteSuperUserCubit>()),
                    ],
                    child: const SuperUsersPage(),
                  );
                case NamePaths.tempTrips:
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteTempTripCubit>()),
                    ],
                    child: const TempTripsPage(),
                  );

                case NamePaths.trips:
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteBusTripCubit>()),
                    ],
                    child: const BusTripsPage(),
                  );

                case NamePaths.tripHistory:
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<DeleteBusTripCubit>()),
                    ],
                    child: const TripHistoryPage(),
                  );

                case NamePaths.members:
                  return const MembersPage();

                case NamePaths.subscriptions:
                  return BlocProvider(
                    create: (context) => DeleteSubscriptionCubit(),
                    child: const SubscriptionsPage(),
                  );
                case "/roles":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<CreateRoleCubit>()),
                      BlocProvider(create: (context) => sl<DeleteRoleCubit>()),
                    ],
                    child: const RolesPage(),
                  );
                case "/sys_admins":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<ChangeUserStateCubit>()),
                    ],
                    child: const AdminPage(),
                  );
                case "/ticket":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<ReplayTicketCubit>()),
                    ],
                    child: const TicketsPage(),
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

class NamePaths {
  static const home = '/';
  static const buses = '/buses';
  static const superUser = '/superUser';
  static const tempTrips = '/tempTrips';
  static const trips = '/trips';
  static const members = '/members';
  static const subscriptions = '/subscriptions';
  static const tripHistory = '/tripHistory';
  static const roles = '/roles';
}
