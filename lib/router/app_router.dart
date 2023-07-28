

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_super_user/core/util/shared_preferences.dart';

import '../core/injection/injection_container.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/policy_cubit/policy_cubit.dart';
import '../features/auth/ui/pages/auth_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/policy_page.dart';
import '../features/qr/ui/pages/qr_page.dart';
import '../features/splash_page/splash_page.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name;


    if(AppSharedPreference.getUser.id==0){
      final providers = [
        BlocProvider(create: (_) => sl<LoginCubit>()),
      ];
      return MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: providers,
          child: const LoginPage(),
        );
      });

    }

    switch (screenName) {

      //region splash

      case RouteNames.scanPage:
        return MaterialPageRoute(
          builder: (context) => const QrPage(),
        );

      //endregion

      //region auth
      //
      // case RouteNames.authPage:
      //   return MaterialPageRoute(builder: (context) => const AuthPage());
      //


      case RouteNames.loginScreen:
        final providers = [
          BlocProvider(create: (_) => sl<LoginCubit>()),
        ];
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: providers,
            child: const LoginPage(),
          );
        });

      // case RouteNames.policyScreen:
      //   final providers = [
      //     BlocProvider(create: (_) => sl<PolicyCubit>()..getPolicy(_)),
      //   ];
      //   return MaterialPageRoute(builder: (context) {
      //     return MultiBlocProvider(
      //       providers: providers,
      //       child: const PolicyPage(),
      //     );
      //   });

      //endregion

    }

    return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}

class RouteNames {
  static const scanPage = '/';
  static const loginScreen = '/2';
  static const confirmCodeScreen = '/3';
  static const signUpScreen = '/4';
  static const passwordScreen = '/5';
  static const mainScreen = '/6';
  static const settings = '/7';
  static const cartScreen = '/8';
  static const policyScreen = '/9';
  static const previousTripsPage = '/10';
  static const ratingPage = '/11';
  static const profilePage = '/12';
  static const updateProfilePage = '/13';
  static const addFavoritePlacePage = '/14';
  static const getFavoritePlacePage = '/15';
  static const contactToUsPage = '/16';
  static const authPage = '/17';
  static const bookingPage = '/18';
  static const webViewPage = '/55';

  // static const String selectLocationPage = '/19';
  static const tripPage = '/20';
  static const cancelTripPage = '/21';
  static const mtnPage = '/22';
  static const sharedTrip = '/23';
  static const choseTrip = '/24';
  static const selectLocation = '/25';
  static const confirmTrip = '/26';
  static const chargeWallet = '/27';

  static const driverInfo = '/28';
  static const sharedRequestPage = '/29';
  static const sharedTripsPage = '/30';
  static const tripInfoPage = '/31';
  static const sharedInfoPage = '/32';
  static const trackingSharedTrip = '/33';

  static const myWalletPage = '/34';

  static const institutionsPage='/35';

// static const payFromWallet = '/34';
}
