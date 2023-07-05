
import 'dart:html';
import 'dart:math';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/logo_text.dart';
import '../../../../router/go_route_pages.dart';
import '../../../drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../../drivers/ui/pages/drivers_page.dart';
import '../../bloc/nav_home_cubit/nav_home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.currentPage}) : super(key: key);

  final String currentPage;

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
            title: const LogoText(),
            backgroundColor: AppColorManager.f1,
            leading: Navigator.canPop(context)
                ? IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColorManager.mainColorDark,
                    ))
                : 0.0.verticalSpace,
          ),
          sideBar: SideBar(
            key: (Key(Random().nextInt(100000).toString())),
            activeTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            activeIconColor: Theme.of(context).primaryColor,
            textStyle: TextStyle(color: Colors.grey[800]),
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
                  if (isAllowed(AppPermissions.ROLES))
                    const AdminMenuItem(title: 'الأدوار', route: '/roles'),
                ],
              ),
              if (isAllowed(AppPermissions.REPORTS))
                const AdminMenuItem(
                    title: 'المعاملات',
                    //   icon:Icons.,
                    route: "/transactions"),
              const AdminMenuItem(
                  icon: Icons.settings, title: 'الاعدادات', route: "/settings"),
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
              loggerObject.wtf(AppSharedPreference.myPermissions);

              setState(() {
                context.read<NavHomeCubit>().changePage(item.route!);
              });
            },
            header: Container(
              height: 50,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: DrawableText(
                  text: AppSharedPreference.getUser.userId.toString(),
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
                    Navigator.pop(context);
                  }
                  context.goNamed(GoRouteName.loginPage);
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
              switch (state.page) {
                case "/":
                case "/policy":
                  return Container(
                      color: Colors.yellowAccent, height: 100.0, width: 100.0);
                case "/drivers":
                  // addQueryParameters(params: {'key': '1'});
                  return const DriverPage();
                case "/shared_trips":
                  return Container(color: Colors.green, height: 100.0, width: 100.0);
                case "/trips":
                case "/sys_admins":
                case "/settings":
                case "/customers":
                case "/coupons":
                case "/roles":
                case "/points":
                case "/epayments_provider":
                case "/transactions":
                case "/car_categories":
                case "/cancel_reasons":
                case "/messages":
                  return Container(color: Colors.red, height: 100.0, width: 100.0);
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

void addQueryParameters({Map<String, dynamic>? params}) {
  final uri = window.location.href;
  final parsedUri = Uri.parse(uri);
  final newQuery = Map.from(parsedUri.queryParameters)..addAll(params ?? {});
  final s = <String, String>{};
  newQuery.forEach((key, value) => s[key.toString()] = value.toString());

  final newUri = Uri(
    scheme: parsedUri.scheme,
    host: parsedUri.host,
    port: parsedUri.port,
    path: parsedUri.path,
    pathSegments: parsedUri.pathSegments,
    fragment: parsedUri.fragment,
    userInfo: parsedUri.userInfo,
    queryParameters: s,
  );
  window.history.pushState(null, '', newUri.toString());
}

String getKeyLink(String key) {
  if (key == '1') return '/Driver';
  return '/';
}
