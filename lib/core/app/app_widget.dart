import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';

import '../../features/accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../features/admins/bloc/all_admins/all_admins_cubit.dart';
import '../../features/auth/bloc/create_policy_cubit/policy_cubit.dart';
import '../../features/auth/bloc/policy_cubit/create_policy_cubit.dart';
import '../../features/bus_trips/bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../features/bus_trips/bloc/failed_attendances_cubit/failed_attendances_cubit.dart';
import '../../features/bus_trips/bloc/trip_history_cubit/trip_history_cubit.dart';
import '../../features/buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../features/buses/bloc/bus_by_imei_cubti/bus_by_imei_cubit.dart';
import '../../features/car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../features/home/bloc/home1_cubit/home1_cubit.dart';
import '../../features/home/bloc/home_cubit/home_cubit.dart';
import '../../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../../features/institutions/bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../features/map/bloc/set_point_cubit/map_control_cubit.dart';
import '../../features/members/bloc/all_member_cubit/all_member_cubit.dart';
import '../../features/messages/bloc/all_messages/all_messages_cubit.dart';
import '../../features/points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../features/roles/bloc/all_roles/all_roles_cubit.dart';
import '../../features/subscriptions/bloc/all_member_without_subscription_cubit/all_member_without_subscription_cubit.dart';
import '../../features/subscriptions/bloc/all_subscriber_cubit/all_subscriber_cubit.dart';
import '../../features/subscriptions/bloc/all_subscriptions_cubit/all_subscriptions_cubit.dart';
import '../../features/super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../features/temp_trips/bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../features/ticket/bloc/all_ticket_cubit/all_ticket_cubit.dart';

import '../../router/go_route_pages.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart';
import '../strings/app_color_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    APIService().getServerTime();
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
          renderHtml: true,
        );

        return MaterialApp.router(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          locale: const Locale.fromSubtags(languageCode: 'en'),
          builder: (context, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<NavHomeCubit>()),
                BlocProvider(create: (_) => sl<BusByImeiCubit>()),
                BlocProvider(create: (_) => sl<MapControlCubit>()),
                BlocProvider(create: (_) => sl<AllMessagesCubit>()),
                BlocProvider(create: (_) => sl<CreatePolicyCubit>()),
                BlocProvider(create: (_) => sl<AllSubscriberCubit>()),
                BlocProvider(create: (_) => sl<HomeCubit>()..getHome(_)),
                BlocProvider(create: (_) => sl<Home1Cubit>()..getHome1(_)),
                BlocProvider(create: (_) => sl<PolicyCubit>()..getPolicy(_)),
                BlocProvider(create: (_) => sl<AllBusesCubit>()..getBuses(_)),
                BlocProvider(create: (_) => sl<PointsCubit>()..getAllPoints(_)),
                BlocProvider(create: (_) => sl<AllRolesCubit>()..getAllRoles(_)),
                BlocProvider(create: (_) => sl<AllTicketsCubit>()..getTickets(_)),
                BlocProvider(create: (_) => sl<AllMembersCubit>()..getMembers(_)),
                BlocProvider(create: (_) => sl<AllAdminsCubit>()..getAllAdmins(_)),
                BlocProvider(create: (_) => sl<AllBusTripsCubit>()..getBusTrips(_)),
                BlocProvider(create: (_) => sl<AllDriversCubit>()..getAllDrivers(_)),
                BlocProvider(create: (_) => sl<AllTempTripsCubit>()..getTempTrips(_)),
                BlocProvider(create: (_) => sl<AllSuperUsersCubit>()..getSuperUsers(_)),
                BlocProvider(create: (_) => sl<AllTripHistoryCubit>()..getTripHistory(_)),
                BlocProvider(create: (_) => sl<AllMemberWithoutSubscriptionCubit>()),
                BlocProvider(
                  create: (_) => sl<FailedAttendancesCubit>()..getFailedAttendances(_),
                ),
                BlocProvider(
                  create: (_) => sl<AllSubscriptionsCubit>()..getSubscriptions(_),
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
