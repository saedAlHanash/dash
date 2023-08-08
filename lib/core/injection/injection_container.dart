import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/policy_cubit/policy_cubit.dart';

import '../../features/qr/bloc/send_report_cubit/send_report_cubit.dart';
import '../../features/super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../app/bloc/loading_cubit.dart';
import '../network/network_info.dart';
import '../service/members_service.dart';
import '../service/report_request_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Auth

  /// Bloc
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => PolicyCubit(network: sl()));

  //endregion


  //region rating_cubit
  /// Bloc

  //endregion

  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => UsersService());
  sl.registerLazySingleton(() => RequestsService());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());
  sl.registerFactory(() => LoadingCubit());
  sl.registerFactory(() => AllSuperUsersCubit());
  //endregion
  sl.registerFactory(() => SendReportCubit());


//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

}
