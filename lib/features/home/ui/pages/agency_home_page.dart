import 'dart:math';

import 'package:drawable_text/drawable_text.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/features/shared_trip/ui/pages/shared_trips_page.dart';
import 'package:qareeb_dash/features/trip/ui/pages/trips_page.dart';
import 'package:qareeb_models/global.dart';
import "package:universal_html/html.dart";

import '../../../../core/injection/injection_container.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/logo_text.dart';
import '../../../accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../../accounts/bloc/pay_to_cubit/pay_to_cubit.dart';
import '../../../accounts/data/request/transfer_filter_request.dart';
import '../../../agencies/bloc/agency_report_cubit/agency_report_cubit.dart';
import '../../../agencies/ui/pages/agency_report_page.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../../drivers/bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../../drivers/ui/pages/drivers_page.dart';
import '../../../pay_to_drivers/ui/pages/financial_page.dart';
import '../../../redeems/bloc/redeems_cubit/redeems_cubit.dart';
import '../../../ticket/bloc/replay_ticket_cubit/replay_ticket_cubit.dart';
import '../../../ticket/ui/pages/tickets_page.dart';
import '../../bloc/nav_home_cubit/nav_home_cubit.dart';
import '../screens/dashboard_page.dart';

class AgencyHomePage extends StatefulWidget {
  const AgencyHomePage({Key? key}) : super(key: key);

  @override
  State<AgencyHomePage> createState() => _AgencyHomePageState();
}

class _AgencyHomePageState extends State<AgencyHomePage> {
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
                title: 'الرئيسية',
                route: '/',
                icon: Icons.dashboard,
              ),
              //المستخدمين
              AdminMenuItem(
                title: 'السائقين',
                route: '/drivers',
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

              AdminMenuItem(
                title: 'محاسبة السائقين',
                route: "/payToDrivers",
                icon: Icons.payments_outlined,
              ),

              AdminMenuItem(
                title: 'سجل دفعاتي',
                route: "/payToAgency",
                icon: Icons.history,
              ),

              AdminMenuItem(icon: Icons.message, title: 'الشكاوى', route: "/ticket"),
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

                case "/ticket":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => sl<ReplayTicketCubit>()),
                    ],
                    child: const TicketsPage(),
                  );

                case "/payToDrivers":
                  final request = TransferFilterRequest();
                  request.type = TransferType.debit;

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
                    ],
                    child: const FinancialPage(),
                  );

                case "/payToAgency":
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => sl<AgencyReportCubit>()
                          ..getAgencyReport(
                            _,
                            id: AppSharedPreference.getAgencyId,
                          ),
                      ),
                    ],
                    child: const AgencyReportPage(),
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
