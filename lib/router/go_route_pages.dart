import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/features/drivers/bloc/create_driver_cubit/create_driver_cubit.dart';
import 'package:qareeb_dash/features/drivers/bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/ui/pages/create_driver_page.dart';
import 'package:qareeb_dash/features/home/ui/pages/home_page.dart';

import '../core/injection/injection_container.dart' as di;
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/drivers/ui/pages/driver_info_page.dart';
import '../features/redeems/bloc/create_redeem_cubit/create_redeem_cubit.dart';
import '../features/redeems/bloc/redeems_cubit/redeems_cubit.dart';
import '../features/wallet/bloc/debt_cubit/debts_cubit.dart';
import '../features/wallet/bloc/my_wallet_cubit/my_wallet_cubit.dart';
import '../features/wallet/ui/pages/debts_page.dart';

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
        final path = state.queryParams['key'];
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

        final id = int.tryParse(state.queryParams['id'] ?? '0')??0;

        // final driver = DriverModel.fromJson(jsonDecode(json));
        final providers = [
          BlocProvider(
              create: (_) => di.sl<DriverBuIdCubit>()
                ..getDriverBuId(context, id: id)),
          BlocProvider(create: (_) => di.sl<CreateRedeemCubit>()),
          BlocProvider(create: (_) => di.sl<WalletCubit>()..getWallet(id: id)),
          BlocProvider(
            create: (_) => di.sl<RedeemsCubit>()..getRedeems(_, driverId: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const DriverInfoPage(),
        );
      },
    ),

    ///createDriver
    GoRoute(
      name: GoRouteName.createDriver,
      path: _GoRoutePath.createDriver,
      builder: (BuildContext context, GoRouterState state) {
        // final driver  = (state.extra ?? DriverModel.fromJson({})) as DriverModel;

        final providers = [
          BlocProvider(create: (_) => di.sl<CreateDriverCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CreateDriverPage(),
        );
      },
    ),

    ///updateDriver
    GoRoute(
      name: GoRouteName.updateDriver,
      path: _GoRoutePath.updateDriver,
      builder: (BuildContext context, GoRouterState state) {
        final driver = (state.extra ?? DriverModel.fromJson({})) as DriverModel;

        final providers = [
          BlocProvider(create: (_) => di.sl<CreateDriverCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateDriverPage(driver: driver),
        );
      },
    ),

    ///debts
    GoRoute(
      name: GoRouteName.debts,
      path: _GoRoutePath.debts,
      builder: (BuildContext context, GoRouterState state) {
        // final driver  = (state.extra ?? DriverModel.fromJson({})) as DriverModel;
        final q = state.queryParams['id'] ?? '0';
        final providers = [
          BlocProvider(
            create: (_) =>
                di.sl<DebtsCubit>()..getDebts(context, id: int.tryParse(q) ?? 0),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const DebtsPage(),
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
  static const debts = 'debts';
  static const createDriver = 'createDriver';
  static const updateDriver = 'updateDriver';
}

class _GoRoutePath {
  static const homePage = '/Home';
  static const driverInfo = '/DriverInfo';
  static const loginPage = '/';
  static const debts = '/debts';
  static const createDriver = '/createDriver';
  static const updateDriver = '/updateDriver';
}
