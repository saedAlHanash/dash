import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/set_point_cubit/map_control_cubit.dart';

import '../../features/accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../features/admins/bloc/all_admins/all_admins_cubit.dart';
import '../../features/auth/bloc/create_policy_cubit/policy_cubit.dart';
import '../../features/auth/bloc/policy_cubit/create_policy_cubit.dart';
import '../../features/car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../features/clients/bloc/all_clients/all_clients_cubit.dart';
import '../../features/coupons/bloc/all_coupons_vubit/all_coupons_cubit.dart';
import '../../features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../features/governorates/bloc/governorates_cubit/governorates_cubit.dart';
import '../../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../../features/institutions/bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../features/messages/bloc/all_messages/all_messages_cubit.dart';
import '../../features/notifications/bloc/notification_cubit/notification_cubit.dart';
import '../../features/pay_to_drivers/bloc/financial_report_cubit/financial_report_cubit.dart';
import '../../features/points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../features/roles/bloc/all_roles/all_roles_cubit.dart';
import '../../features/shared_trip/bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../../features/system_params/bloc/system_params_cubit/system_params_cubit.dart';
import '../../features/system_settings/bloc/system_settings_cubit/system_settings_cubit.dart';
import '../../features/temp_trips/bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../features/ticket/bloc/all_ticket_cubit/all_ticket_cubit.dart';
import '../../features/trip/bloc/active_trips/active_trips_cubit.dart';
import '../../features/trip/bloc/trips_cubit/trips_cubit.dart';
import '../../features/wallet/bloc/providers_cubit/providers_cubit.dart';
import '../../router/go_route_pages.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart';
import '../strings/app_color_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                BlocProvider(create: (_) => sl<AllMessagesCubit>()),
                BlocProvider(create: (_) => sl<CreateNotificationCubit>()),
                BlocProvider(create: (_) => sl<PolicyCubit>()..getPolicy(_)),
                BlocProvider(create: (_) => sl<PointsCubit>()..getAllPoints(_)),
                BlocProvider(create: (_) => sl<AllRolesCubit>()..getAllRoles(_)),
                BlocProvider(create: (_) => sl<TripsCubit>()..getTrips(_)),
                BlocProvider(create: (_) => sl<AllTicketsCubit>()..getTickets(_)),
                BlocProvider(create: (_) => sl<AllAdminsCubit>()..getAllAdmins(_)),
                BlocProvider(create: (_) => sl<AllDriversCubit>()..getAllDrivers(_)),
                BlocProvider(create: (_) => sl<AllClientsCubit>()..getAllClients(_)),
                BlocProvider(create: (_) => sl<AllCouponsCubit>()..getAllCoupons(_)),
                BlocProvider(create: (_) => sl<AllTempTripsCubit>()..getTempTrips(_)),
                BlocProvider(create: (_) => sl<FinancialReportCubit>()..getReport(_)),
                BlocProvider(create: (_) => sl<ActiveTripsCubit>()..getActiveTrips(_)),
                BlocProvider(create: (_) => sl<GovernoratesCubit>()..getGovernorate(_)),
                BlocProvider(create: (_) => sl<AllTransfersCubit>()..getAllTransfers(_)),
                BlocProvider(create: (_) => sl<GetSharedTripsCubit>()..getSharesTrip(_)),
                BlocProvider(create: (_) => sl<ProvidersCubit>()..getAllEpayProviders(_)),
                BlocProvider(create: (_) => sl<SystemParamsCubit>()..getSystemParams(_)),
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
