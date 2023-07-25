import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/features/trip/ui/pages/trips_page.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/logo_text.dart';
import '../../../../router/go_route_pages.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../../buses/bloc/delete_buss_cubit/delete_buss_cubit.dart';
import '../../../buses/ui/pages/buses_page.dart';
import '../../../drivers/bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../../drivers/ui/pages/drivers_page.dart';
import '../../../super_user/bloc/delete_super_user_cubit/delete_super_user_cubit.dart';
import '../../../super_user/ui/pages/super_users_page.dart';
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
            items: const [
              AdminMenuItem(
                title: 'الرئيسية',
                route: NamePaths.home,
                icon: Icons.dashboard,
              ),
              AdminMenuItem(
                title: 'الباصات',
                icon: Icons.bus_alert_sharp,
                children: [
                  AdminMenuItem(title: 'قائمة الباصات', route: NamePaths.buses),
                  AdminMenuItem(title: 'المشرفين', route: NamePaths.superUser),
                ],
              ),
              AdminMenuItem(
                title: 'الرحلات',
                icon: Icons.supervised_user_circle_sharp,
                children: [
                  AdminMenuItem(title: 'نماذج الرحلات', route: NamePaths.tempTrips),
                  AdminMenuItem(title: 'جدول الرحلات', route: NamePaths.trips),
                ],
              ),
              AdminMenuItem(title: 'الطلاب', route: NamePaths.members),
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
                      BlocProvider(create: (context) => sl<LoyaltyCubit>()),
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
                  return const TripsPage();
                case NamePaths.trips:
                  return const TripsPage();
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
}
