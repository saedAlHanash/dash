import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../features/admins/bloc/all_admins/all_admins_cubit.dart';
import '../../features/auth/bloc/create_policy_cubit/policy_cubit.dart';
import '../../features/auth/bloc/policy_cubit/create_policy_cubit.dart';

import '../../features/buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../features/car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../features/clients/bloc/all_clients/all_clients_cubit.dart';
import '../../features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../../features/institutions/bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../features/map/bloc/set_point_cubit/map_control_cubit.dart';
import '../../features/messages/bloc/all_messages/all_messages_cubit.dart';
import '../../features/points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../features/roles/bloc/all_roles/all_roles_cubit.dart';
import '../../features/super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../features/trip/bloc/all_trips_cubit/all_trips_cubit.dart';
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
          renderHtml: true,
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
                BlocProvider(create: (_) => sl<PolicyCubit>()..getPolicy(_)),
                BlocProvider(create: (_) => sl<AllBusesCubit>()..getBuses(_)),
                BlocProvider(create: (_) => sl<PointsCubit>()..getAllPoints(_)),
                BlocProvider(create: (_) => sl<AllTripsCubit>()..getAllTrips(_)),
                BlocProvider(create: (_) => sl<AllRolesCubit>()..getAllRoles(_)),
                BlocProvider(create: (_) => sl<AllAdminsCubit>()..getAllAdmins(_)),
                BlocProvider(create: (_) => sl<AllDriversCubit>()..getAllDrivers(_)),
                BlocProvider(create: (_) => sl<AllClientsCubit>()..getAllClients(_)),
                BlocProvider(create: (_) => sl<AllSuperUsersCubit>()..getSuperUsers(_)),
                BlocProvider(create: (_) => sl<AllTransfersCubit>()..getAllTransfers(_)),
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
