import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/features/drivers/bloc/driver_bu_id_cubit/driver_bu_id_cubit.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/home/ui/pages/home_page.dart';

import '../core/injection/injection_container.dart' as di;
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/drivers/ui/pages/driver_info_page.dart';

final appGoRouter = GoRouter(
  routes: <GoRoute>[
    //region auth
    ///login
    GoRoute(
      name: GoRouteName.loginPage,
      path: _GoRoutePath.loginPage,
      builder: (BuildContext context, GoRouterState state) {
        final providers = [
          BlocProvider(create: (_) => di.sl<LoginCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const LoginPage(),
        );
      },
    ),

    ///homePage
    GoRoute(
      name: GoRouteName.homePage,
      path: _GoRoutePath.homePage,
      builder: (BuildContext context, GoRouterState state) {
        final providers = [
          BlocProvider(create: (_) => di.sl<LoginCubit>()),
        ];
        final path = state.queryParameters['key'];
        return MultiBlocProvider(
          providers: providers,
          child: HomePage(currentPage: path ?? '/'),
        );
      },
    ),

    //endregion

    //region Drivers

    ///driverInfo
    GoRoute(
      name: GoRouteName.driverInfo,
      path: _GoRoutePath.driverInfo,
      builder: (BuildContext context, GoRouterState state) {
        final providers = [
          BlocProvider(create: (_) => di.sl<DriverBuIdCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: DriverInfoPage(
              driver: (state.extra ?? DriverModel.fromJson({})) as DriverModel),
        );
      },
    ),

    //endregion
  ],
);

class GoRouteName {

  static const homePage = 'Home Page';
  static const loginPage = 'Login Page';
  static const driverInfo = 'driver info';

}

class _GoRoutePath {

  static const homePage = '/Home';
  static const driverInfo = '/DriverInfo';
  static const loginPage = '/';

}
