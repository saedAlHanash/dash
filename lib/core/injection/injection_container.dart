import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/bloc/forgot_password_cubit/forgot_password_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/policy_cubit/policy_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/contact/bloc/send_note_cubit/send_note_cubit.dart';
import '../../features/drivers/bloc/all_drivers/all_drivers_cubit.dart';

import '../../features/drivers/bloc/driver_bu_id_cubit/driver_bu_id_cubit.dart';
import '../../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../../features/map/bloc/ather_cubit/ather_cubit.dart';
import '../../features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../features/map/bloc/my_location_cubit/my_location_cubit.dart';
import '../../features/map/bloc/set_point_cubit/map_control_cubit.dart';
import '../../features/points/bloc/get_all_points_cubit/get_all_points_cubit.dart';
import '../../features/points/bloc/get_points_edge_cubit/get_points_edge_cubit.dart';
import '../../features/previous_trips/bloc/previous_trip/previous_trips_cubit.dart';
import '../../features/profile/bloc/profile_info_cubit/profile_info_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../features/rating/data/data_source/rating_remote.dart';
import '../../features/rating/data/repo/rating_repo_imp.dart';
import '../../features/rating/domain/repo/rating_repo.dart';
import '../../features/rating/domain/use_cases/rating_use_case.dart';
import '../../features/rating/presentation/bloc/rating_cubit/rating_cubit.dart';
import '../../features/shared_trip/bloc/add_point_cubit/add_point_cubit.dart';
import '../../features/shared_trip/bloc/create_shared_trip_cubit/create_shared_trip_cubit.dart';
import '../../features/shared_trip/bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../../features/shared_trip/bloc/shared_trip_by_id_cubit/shared_trip_by_id_cubit.dart';
import '../../features/shared_trip/bloc/update_shared_cubit/update_shared_cubit.dart';
import '../../features/trip/bloc/driver_status_cubit/driver_status_cubit.dart';
import '../../features/trip/bloc/nav_trip_cubit/nav_trip_cubit.dart';
import '../../features/trip/bloc/trip_by_id/trip_by_id_cubit.dart';
import '../../features/trip/bloc/trip_status_cubit/trip_status_cubit.dart';
import '../../features/wallet/bloc/charge_client_cubit/charge_client_cubit.dart';
import '../../features/wallet/bloc/debt_cubit/debts_cubit.dart';
import '../../features/wallet/bloc/my_wallet_cubit/my_wallet_cubit.dart';
import '../../services/osrm/bloc/get_route_point_cubit/get_route_point_cubit.dart';
import '../../services/osrm/bloc/location_name_cubit/location_name_cubit.dart';
import '../../services/trip_path/bloc/path_by_id_cubit/path_by_id_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Auth

  /// Bloc
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => SignupCubit(network: sl()));
  sl.registerFactory(() => PolicyCubit(network: sl()));
  sl.registerFactory(() => ForgotPasswordCubit(network: sl()));
  sl.registerFactory(() => ResendCodeCubit(network: sl()));
  sl.registerFactory(() => ResetPasswordCubit(network: sl()));

  //endregion

  //region rating_cubit
  /// Bloc
  sl.registerFactory(() => RatingCubit(useCase: sl()));

  /// UseCases
  sl.registerLazySingleton(() => RatingUseCase(repository: sl()));

  /// Repository
  sl.registerLazySingleton<RatingRepo>(() => RatingRepoImp(remote: sl(), network: sl()));

  /// Data sources
  sl.registerLazySingleton<RatingRemoteRepo>(() => const RatingRemoteRepoImp());

  //endregion

  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  sl.registerFactory(() => GetRoutePointCubit());

  sl.registerFactory(() => AtherCubit());
  sl.registerFactory(() => NavHomeCubit());
  //endregion

  //region profile
  /// Bloc
  sl.registerFactory(() => ProfileInfoCubit());
  sl.registerFactory(() => UpdateProfileCubit());

  //endregion

  //region map

  ///bloc
  sl.registerFactory(() => MyLocationCubit());
  sl.registerFactory(() => MapControlCubit());
  sl.registerFactory(() => MapControllerCubit());
  sl.registerFactory(() => LocationNameCubit(network: sl()));
  //endregion

  //region favorite places

  ///bloc
  //endregion

  //region contact to us
  sl.registerFactory(() => SendNoteCubit(network: sl()));

  //endregion

  //region points
  sl.registerFactory(() => PointsCubit());
  sl.registerFactory(() => PointsEdgeCubit());
  //endregion

  //region shared trip

  sl.registerFactory(() => AddPointCubit());
  sl.registerFactory(() => CreateSharedTripCubit());
  sl.registerFactory(() => GetSharedTripsCubit());
  sl.registerFactory(() => SharedTripByIdCubit());
  sl.registerFactory(() => UpdateSharedCubit());
  sl.registerFactory(() => PathByIdCubit());
  //endregion

  //region trip
  sl.registerFactory(() => DriverStatusCubit());
  sl.registerFactory(() => TripStatusCubit());
  sl.registerFactory(() => TripByIdCubit());
  sl.registerFactory(() => NavTripCubit());
  sl.registerFactory(() => PreviousTripsCubit());

  //endregion

  //region charge
  sl.registerFactory(() => ChargeClientCubit());
  sl.registerFactory(() => MyWalletCubit());
  sl.registerFactory(() => DebtsCubit());

  //endregion

  //region drivers
  sl.registerFactory(() => AllDriversCubit());
  sl.registerFactory(() => DriverBuIdCubit());

  //endregion
//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Geolocator);
}
