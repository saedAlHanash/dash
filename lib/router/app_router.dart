import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/features/profile/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'package:qareeb_dash/features/shared_trip/ui/pages/active_shared_trip_page.dart';
import 'package:qareeb_dash/features/shared_trip/ui/pages/my_shared_trips_page.dart';
import 'package:qareeb_dash/features/trip/bloc/driver_status_cubit/driver_status_cubit.dart';
import 'package:qareeb_dash/features/trip/ui/pages/trip_info_page.dart';
import 'package:qareeb_dash/features/wallet/ui/pages/debts_page.dart';


import '../features/auth/bloc/forgot_password_cubit/forgot_password_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/policy_cubit/policy_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';

import '../features/auth/ui/pages/login_page.dart';

import '../features/contact/bloc/send_note_cubit/send_note_cubit.dart';
import '../features/contact/ui/pages/contact_to_us_page.dart';
import '../features/home/ui/pages/main_page.dart';
import '../features/map/bloc/ather_cubit/ather_cubit.dart';
import '../features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../features/map/bloc/my_location_cubit/my_location_cubit.dart';
import '../features/map/bloc/set_point_cubit/map_control_cubit.dart';
import '../features/points/bloc/get_all_points_cubit/get_edged_point_cubit.dart';
import '../features/points/bloc/get_points_edge_cubit/get_points_edge_cubit.dart';
import '../features/previous_trips/bloc/previous_trip/previous_trips_cubit.dart';
import '../features/previous_trips/ui/pages/previous_trips_page.dart';
import '../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../features/profile/ui/pages/profile_page.dart';
import '../features/profile/ui/pages/update_profile_page.dart';
import '../features/rating/presentation/bloc/rating_cubit/rating_cubit.dart';
import '../features/rating/presentation/pages/rating_page.dart';
import '../features/shared_trip/bloc/add_point_cubit/add_point_cubit.dart';
import '../features/shared_trip/bloc/create_shared_trip_cubit/create_shared_trip_cubit.dart';
import '../features/shared_trip/bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../features/shared_trip/bloc/shared_trip_by_id_cubit/shared_trip_by_id_cubit.dart';
import '../features/shared_trip/bloc/update_shared_cubit/update_shared_cubit.dart';
import '../features/shared_trip/ui/pages/create_shred_trip_page.dart';
import '../features/splash_page/splash_page.dart';
import '../features/trip/bloc/trip_status_cubit/trip_status_cubit.dart';
import '../features/trip/data/response/trip_response.dart';
import '../features/trip/ui/pages/trip_page.dart';
import '../features/wallet/bloc/charge_client_cubit/charge_client_cubit.dart';
import '../features/wallet/bloc/debt_cubit/debts_cubit.dart';
import '../features/wallet/bloc/my_wallet_cubit/my_wallet_cubit.dart';
import '../features/wallet/ui/pages/charge_client_page.dart';
import '../features/wallet/ui/pages/my_wallet_page.dart';
import '../services/trip_path/bloc/path_by_id_cubit/path_by_id_cubit.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name;

    // screenName = _initToScreen(AppSharedPreference.toScreen(), screenName);

    switch (screenName) {

    }

    return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}

class RouteNames {
  static const splashScreen = '/';
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
  static const tripInfoPage = '/18';

  static const createSharedTrip = '/23';
  static const sharedTrips = '/24';
  static const activeSharedTrip = '/25';
  static const tripPage = '/26';
  static const chargeWallet = '/27';
  static const myWalletPage = '/28';
  static const debts = '/29';
}
