import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../features/accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../features/admins/bloc/all_admins/all_admins_cubit.dart';
import '../../features/admins/bloc/create_admin_cubit/create_admin_cubit.dart';
import '../../features/auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../features/auth/bloc/create_policy_cubit/policy_cubit.dart';
import '../../features/auth/bloc/forgot_password_cubit/forgot_password_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/policy_cubit/create_policy_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/bus_trips/bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../features/bus_trips/bloc/bus_trip_by_id_cubit/bus_trip_by_id_cubit.dart';
import '../../features/bus_trips/bloc/create_bus_trip_cubit/create_bus_trip_cubit.dart';
import '../../features/bus_trips/bloc/delete_bus_trip_cubit/delete_bus_trip_cubit.dart';
import '../../features/bus_trips/bloc/failed_attendances_cubit/failed_attendances_cubit.dart';
import '../../features/bus_trips/bloc/trip_history_cubit/trip_history_cubit.dart';
import '../../features/buses/bloc/all_buses_cubit/all_buses_cubit.dart';

import '../../features/buses/bloc/bus_by_imei_cubti/bus_by_imei_cubit.dart';
import '../../features/buses/bloc/create_bus_cubit/create_bus_cubit.dart';

import '../../features/buses/bloc/delete_buss_cubit/delete_buss_cubit.dart';
import '../../features/car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../features/car_catigory/bloc/create_car_category_cubit/create_car_category_cubit.dart';
import '../../features/car_catigory/bloc/delete_car_cat_cubit/delete_car_cat_cubit.dart';
import '../../features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../features/drivers/bloc/create_driver_cubit/create_driver_cubit.dart';
import '../../features/drivers/bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import '../../features/drivers/bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../features/home/bloc/home1_cubit/home1_cubit.dart';
import '../../features/home/bloc/home_cubit/home_cubit.dart';
import '../../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../../features/institutions/bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../features/institutions/bloc/create_institution_cubit/create_institution_cubit.dart';
import '../../features/institutions/bloc/delete_institution_cubit/delete_institution_cubit.dart';
import '../../features/map/bloc/ather_cubit/ather_cubit.dart';
import '../../features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../features/map/bloc/my_location_cubit/my_location_cubit.dart';
import '../../features/map/bloc/search_location/search_location_cubit.dart';
import '../../features/map/bloc/set_point_cubit/map_control_cubit.dart';
import '../../features/members/bloc/all_member_cubit/all_member_cubit.dart';
import '../../features/members/bloc/create_member_cubit/create_member_cubit.dart';
import '../../features/members/bloc/create_subscreption_cubit/create_subscreption_cubit.dart';
import '../../features/members/bloc/member_by_id_cubit/member_by_id_cubit.dart';
import '../../features/messages/bloc/all_messages/all_messages_cubit.dart';
import '../../features/points/bloc/creta_edge_cubit/create_edge_cubit.dart';
import '../../features/points/bloc/creta_point_cubit/create_point_cubit.dart';
import '../../features/points/bloc/delete_edge_cubit/delete_edge_cubit.dart';
import '../../features/points/bloc/delete_point_cubit/delete_point_cubit.dart';
import '../../features/points/bloc/get_all_points_cubit/get_edged_point_cubit.dart';
import '../../features/points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../../features/points/bloc/get_points_edge_cubit/get_points_edge_cubit.dart';
import '../../features/points/bloc/point_by_id_cubit/point_by_id_cubit.dart';
import '../../features/profile/bloc/profile_info_cubit/profile_info_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../features/roles/bloc/all_permissions_cubit/all_permissions_cubit.dart';
import '../../features/roles/bloc/all_roles/all_roles_cubit.dart';
import '../../features/roles/bloc/create_role_cubit/create_role_cubit.dart';
import '../../features/roles/bloc/delete_role_cubit/delete_role_cubit.dart';

import '../../features/subscriptions/bloc/add_from_template_cubit/add_from_template_cubit.dart';
import '../../features/subscriptions/bloc/all_member_without_subscription_cubit/all_member_without_subscription_cubit.dart';
import '../../features/subscriptions/bloc/all_subscriber_cubit/all_subscriber_cubit.dart';
import '../../features/subscriptions/bloc/all_subscriptions_cubit/all_subscriptions_cubit.dart';
import '../../features/subscriptions/bloc/create_subscriptions_cubit/create_subscriptions_cubit.dart';
import '../../features/subscriptions/bloc/delete_subscription_cubit/delete_subscription_cubit.dart';
import '../../features/subscriptions/bloc/subscriptions_by_id_cubit/subscriptions_by_id_cubit.dart';
import '../../features/super_user/bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../features/super_user/bloc/create_super_user_cubit/create_super_user_cubit.dart';
import '../../features/super_user/bloc/delete_super_user_cubit/delete_super_user_cubit.dart';
import '../../features/temp_trips/bloc/add_point_cubit/add_point_cubit.dart';
import '../../features/temp_trips/bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../features/temp_trips/bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import '../../features/temp_trips/bloc/delete_temp_trip_cubit/delete_temp_trip_cubit.dart';
import '../../features/temp_trips/bloc/temp_trip_by_id_cubit/temp_trip_by_id_cubit.dart';
import '../../features/ticket/bloc/all_ticket_cubit/all_ticket_cubit.dart';
import '../../features/ticket/bloc/replay_ticket_cubit/replay_ticket_cubit.dart';

import '../../services/osrm/bloc/get_route_point_cubit/get_route_point_cubit.dart';
import '../../services/osrm/bloc/location_name_cubit/location_name_cubit.dart';
import '../../services/trip_path/bloc/path_by_id_cubit/path_by_id_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region Auth

  /// Bloc
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => ChangeUserStateCubit());
  sl.registerFactory(() => SignupCubit(network: sl()));
  sl.registerFactory(() => PolicyCubit(network: sl()));
  sl.registerFactory(() => CreatePolicyCubit(network: sl()));
  sl.registerFactory(() => ForgotPasswordCubit(network: sl()));
  sl.registerFactory(() => ResendCodeCubit(network: sl()));
  sl.registerFactory(() => ResetPasswordCubit(network: sl()));

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
  sl.registerFactory(() => SearchLocationCubit());
  sl.registerFactory(() => LocationNameCubit(network: sl()));
  //endregion

  //region favorite places

  ///bloc
  //endregion

  //region points
  sl.registerFactory(() => PointsCubit());
  sl.registerFactory(() => PointByIdCubit());
  sl.registerFactory(() => PointsEdgeCubit());
  sl.registerFactory(() => CreatePointCubit());
  sl.registerFactory(() => CreateEdgeCubit());
  sl.registerFactory(() => EdgesPointCubit());
  sl.registerFactory(() => DeleteEdgeCubit());
  sl.registerFactory(() => DeletePointCubit());
  //endregion

  //region shared trip

  sl.registerFactory(() => PathByIdCubit());

  //endregion

  //region trip

  //endregion

  //region drivers
  sl.registerFactory(() => AllDriversCubit());
  sl.registerFactory(() => DriverBuIdCubit());
  sl.registerFactory(() => CreateDriverCubit());

  //endregion

  //region car category

  sl.registerFactory(() => AllCarCategoriesCubit());
  //endregion

  //region loyalty
  sl.registerFactory(() => LoyaltyCubit());

  //endregion

  //region reasons

  sl.registerFactory(() => CreateCarCategoryCubit());
  sl.registerFactory(() => DeleteCarCatCubit());

  //endregion

  //region admins
  sl.registerFactory(() => AllAdminsCubit());
  sl.registerFactory(() => CreateAdminCubit());
  sl.registerFactory(() => AllRolesCubit());
  sl.registerFactory(() => CreateRoleCubit());
  sl.registerFactory(() => AllPermissionsCubit());
  sl.registerFactory(() => DeleteRoleCubit());

  //endregion

  //region messages
  sl.registerFactory(() => AllMessagesCubit());

  //endregion

  //region institution
  sl.registerFactory(() => AllInstitutionsCubit());
  sl.registerFactory(() => CreateInstitutionCubit());
  sl.registerFactory(() => DeleteInstitutionCubit());

  //endregion

  //region buses
  sl.registerFactory(() => AllBusesCubit());
  sl.registerFactory(() => CreateBusCubit());
  sl.registerFactory(() => DeleteBusCubit());
  //endregion

  //region superUser
  sl.registerFactory(() => AllSuperUsersCubit());
  sl.registerFactory(() => CreateSuperUsersCubit());
  sl.registerFactory(() => DeleteSuperUserCubit());
  //endregion

  //region tempTrip
  sl.registerFactory(() => CreateTempTripCubit());
  sl.registerFactory(() => AllTempTripsCubit());
  sl.registerFactory(() => DeleteTempTripCubit());
  sl.registerFactory(() => TempTripBuIdCubit());
  //endregion

  //region busTrip
  sl.registerFactory(() => CreateBusTripCubit());
  sl.registerFactory(() => AllBusTripsCubit());
  sl.registerFactory(() => DeleteBusTripCubit());
  sl.registerFactory(() => BusTripBuIdCubit());
  //endregion

  //region member

  sl.registerFactory(() => CreateMemberCubit());
  sl.registerFactory(() => AllMembersCubit());
  sl.registerFactory(() => MemberBuIdCubit());
  //endregion

  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => Home1Cubit());
  // sl.registerFactory(() => AllTransfersCubit());

  sl.registerFactory(() => AccountAmountCubit());

  sl.registerFactory(() => AddPointCubit());
  sl.registerFactory(() => CreateSubscriptionCubit());
  sl.registerFactory(() => SubscriptionBuIdCubit());
  sl.registerFactory(() => DeleteSubscriptionCubit());
  sl.registerFactory(() => AllSubscriptionsCubit());
  sl.registerFactory(() => AllTripHistoryCubit());
  sl.registerFactory(() => FailedAttendancesCubit());
  sl.registerFactory(() => AllTicketsCubit());
  sl.registerFactory(() => ReplayTicketCubit());
  sl.registerFactory(() => BusByImeiCubit());
  sl.registerFactory(() => AllSubscriberCubit());
  sl.registerFactory(() => AddFromTemplateCubit());
  sl.registerFactory(() => AllMemberWithoutSubscriptionCubit());

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Geolocator);
}
