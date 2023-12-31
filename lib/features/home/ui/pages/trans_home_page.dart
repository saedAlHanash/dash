import 'dart:math';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
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
import '../../../accounts/bloc/pay_to_cubit/pay_to_cubit.dart';
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
