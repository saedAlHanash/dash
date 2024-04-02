import 'dart:math';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/features/shared_trip/ui/pages/shared_trips_page.dart';
import 'package:qareeb_dash/features/trip/ui/pages/trips_page.dart';
import "package:universal_html/html.dart";

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/admin_side_bar_widget/admin_scaffold.dart';
import '../../../../core/widgets/logo_text.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../../drivers/bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../../drivers/ui/pages/drivers_page.dart';
import '../../bloc/nav_home_cubit/nav_home_cubit.dart';
import 'home_page.dart';

class TransHomePage extends StatefulWidget {
  const TransHomePage({Key? key}) : super(key: key);

  @override
  State<TransHomePage> createState() => _TransHomePageState();
}

class _TransHomePageState extends State<TransHomePage> {
  PageController page = PageController();

  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    context
        .read<NavHomeCubit>()
        .changePage('/${getCurrentQueryParameters()['key'] ?? ''}');

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
            items: const [
              AdminMenuItem(
                title: 'السائقين',
                route: '/',
                icon: Icons.supervised_user_circle_sharp,
              ),
              AdminMenuItem(
                title: 'الرحلات',
                icon: Icons.turn_right_sharp,
                children: [
                  AdminMenuItem(title: 'الرحلات التشاركية', route: '/shared_trips'),
                  AdminMenuItem(title: 'الرحلات العادية', route: '/trips'),
                ],
              ),
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
                      BlocProvider(create: (_) => sl<LoyaltyCubit>()),
                      BlocProvider(create: (_) => sl<ChangeUserStateCubit>()),
                    ],
                    child: const DriverPage(),
                  );
                case "/shared_trips":
                  return const SharedTripsPage();
                case "/trips":
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
}
