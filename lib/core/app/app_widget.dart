import 'dart:html' as web;

// import 'package:audioplayers/audioplayers.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:just_audio/just_audio.dart';
import 'package:map_package/map/bloc/set_point_cubit/map_control_cubit.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/features/syrian_agency/data/request/syrian_filter_request.dart';

import '../../features/accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../features/accounts/bloc/company_transfers_cubit/company_transfers_cubit.dart';
import '../../features/accounts/bloc/financial_report_cubit/financial_report_cubit.dart';
import '../../features/admins/bloc/all_admins/all_admins_cubit.dart';
import '../../features/agencies/bloc/agencies_cubit/agencies_cubit.dart';
import '../../features/agencies/bloc/agencies_financial_report_cubit/agencies_financial_report_cubit.dart';
import '../../features/auth/bloc/create_policy_cubit/policy_cubit.dart';
import '../../features/auth/bloc/policy_cubit/create_policy_cubit.dart';
import '../../features/car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../features/clients/bloc/all_clients/all_clients_cubit.dart';
import '../../features/companies/bloc/companies_cubit/companies_cubit.dart';
import '../../features/company_paths/bloc/all_compane_paths_cubit/all_company_paths_cubit.dart';
import '../../features/coupons/bloc/all_coupons_vubit/all_coupons_cubit.dart';
import '../../features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../features/drivers/bloc/drivers_imiei_cubit/drivers_imei_cubit.dart';
import '../../features/governorates/bloc/governorates_cubit/governorates_cubit.dart';
import '../../features/home/bloc/home_cubit/home_cubit/home_cubit.dart';
import '../../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../../features/institutions/bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../features/notifications/bloc/notification_cubit/notification_cubit.dart';
import '../../features/plan_trips/bloc/all_plan_trips_cubit/all_plan_trips_cubit.dart';
import '../../features/plan_trips/bloc/plan_attendances_cubit/plan_attendances_cubit.dart';
import '../../features/plans/bloc/plans_cubit/plans_cubit.dart';
import '../../features/points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../features/roles/bloc/all_roles/all_roles_cubit.dart';
import '../../features/shared_trip/bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../../features/sos/bloc/all_sos_cubit/all_sos_cubit.dart';
import '../../features/syrian_agency/bloc/syrian_agencies_financial_report_cubit/syrian_agencies_financial_report_cubit.dart';
import '../../features/syrian_agency/bloc/syrian_agency_report_cubit/syrian_agency_report_cubit.dart';
import '../../features/system_params/bloc/system_params_cubit/system_params_cubit.dart';
import '../../features/system_settings/bloc/system_settings_cubit/system_settings_cubit.dart';
import '../../features/temp_trips/bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../features/ticket/bloc/all_ticket_cubit/all_ticket_cubit.dart';
import '../../features/trip/bloc/active_trips/active_trips_cubit.dart';
import '../../features/trip/bloc/trips_cubit/trips_cubit.dart';
import '../../features/wallet/bloc/providers_cubit/providers_cubit.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../../router/go_route_pages.dart';
import '../api_manager/api_service.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart';
import '../strings/app_color_manager.dart';
import 'package:elegant_notification/elegant_notification.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      loggerObject.w('Got a message whilst in the foreground!');

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

      player.load().then((value) {
        player.play();
      });

      // web.Notification(
      //   title,
      //   icon: Assets.iconsLogoPng,
      //   body: body,
      // );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(412, 770),
      designSize: const Size(1440, 972),
      minTextAdapt: true,
      builder: (context, child) {
        DrawableText.initial(
          initialColor: AppColorManager.black,
          titleSizeText: 28.0.sp,
          headerSizeText: 30.0.sp,
          initialSize: 22.0.sp,
          initialHeightText: 2.0.h,
          selectable: true,
          renderHtml: true,
          // textDirection: TextDirection.ltr,
        );
        setImageMultiTypeErrorImage(
          const ImageMultiType(url: Assets.iconsLogoWithoutText),
        );
        return MaterialApp.router(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          builder: (context, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<NavHomeCubit>()),
                BlocProvider(create: (_) => sl<MapControlCubit>()),
                BlocProvider(create: (_) => sl<CreatePolicyCubit>()),
                BlocProvider(create: (_) => sl<HomeCubit>()..getHome(_)),
                BlocProvider(create: (_) => sl<AllSosCubit>()..getSos(_)),
                BlocProvider(create: (_) => sl<CreateNotificationCubit>()),
                BlocProvider(create: (_) => sl<TripsCubit>()..getTrips(_)),
                BlocProvider(create: (_) => sl<PolicyCubit>()..getPolicy(_)),
                BlocProvider(create: (_) => sl<AllPlansCubit>()..getPlans(_)),
                BlocProvider(create: (_) => sl<PointsCubit>()..getAllPoints(_)),
                BlocProvider(create: (_) => sl<AgenciesCubit>()..getAgencies(_)),
                BlocProvider(create: (_) => sl<AllRolesCubit>()..getAllRoles(_)),
                BlocProvider(create: (_) => sl<AllTicketsCubit>()..getTickets(_)),
                BlocProvider(create: (_) => sl<AllAdminsCubit>()..getAllAdmins(_)),
                BlocProvider(create: (_) => sl<AllDriversCubit>()..getAllDrivers(_)),
                BlocProvider(create: (_) => sl<AllClientsCubit>()..getAllClients(_)),
                BlocProvider(create: (_) => sl<AllCouponsCubit>()..getAllCoupons(_)),
                BlocProvider(create: (_) => sl<AllPlanTripsCubit>()..getPlanTrips(_)),
                BlocProvider(create: (_) => sl<FinancialReportCubit>()..getReport(_)),
                BlocProvider(create: (_) => sl<AgenciesReportCubit>()..getReport(_)),
                BlocProvider(create: (_) => sl<AllTempTripsCubit>()..getTempTrips(_)),
                BlocProvider(create: (_) => sl<AllCompaniesCubit>()..getCompanies(_)),
                BlocProvider(create: (_) => sl<ActiveTripsCubit>()..getActiveTrips(_)),
                BlocProvider(create: (_) => sl<DriversImeiCubit>()..getDriversImei(_)),
                BlocProvider(create: (_) => sl<GovernoratesCubit>()..getGovernorate(_)),
                BlocProvider(create: (_) => sl<AllTransfersCubit>()..getAllTransfers(_)),
                BlocProvider(create: (_) => sl<GetSharedTripsCubit>()..getSharesTrip(_)),
                BlocProvider(create: (_) => sl<SystemParamsCubit>()..getSystemParams(_)),
                BlocProvider(create: (_) => sl<ProvidersCubit>()..getAllEpayProviders(_)),
                BlocProvider(
                    create: (_) =>
                        sl<SyrianAgenciesFinancialReportCubit>()..getReport(_)),
                BlocProvider(
                  create: (_) => sl<SyrianAgencyReportCubit>()
                    ..getSyrianAgencyReport(
                      _,
                      command: Command.initial()
                          .copyWith(syrianFilterRequest: SyrianFilterRequest()),
                    ),
                ),
                BlocProvider(
                    create: (_) => sl<PlanAttendancesCubit>()..getAttendances(_)),
                BlocProvider(
                  create: (_) => sl<CompanyTransfersCubit>()..getCompanyTransfers(_),
                ),
                BlocProvider(
                  create: (_) => sl<AllCompanyPathsCubit>()..getCompanyPaths(_),
                ),
                BlocProvider(
                  create: (_) => sl<SystemSettingsCubit>()..getSystemSettings(_),
                ),
                BlocProvider(
                  create: (_) => sl<AllInstitutionsCubit>()..getInstitutions(_),
                ),
                BlocProvider(
                  create: (_) => sl<AllCarCategoriesCubit>()..getCarCategories(_),
                ),
              ],
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              ),
            );
          },
          routerConfig: appGoRouter,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
