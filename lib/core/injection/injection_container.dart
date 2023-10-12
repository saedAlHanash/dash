import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/bloc/my_location_cubit/my_location_cubit.dart';
import 'package:map_package/map/bloc/search_location/search_location_cubit.dart';
import 'package:map_package/map/bloc/set_point_cubit/map_control_cubit.dart';
import 'package:qareeb_dash/features/pay_to_drivers/bloc/pay_to_cubit/pay_to_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../features/accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../features/accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../features/accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';
import '../../features/admins/bloc/all_admins/all_admins_cubit.dart';
import '../../features/admins/bloc/create_admin_cubit/create_admin_cubit.dart';
import '../../features/agencies/bloc/agencies_cubit/agencies_cubit.dart';
import '../../features/agencies/bloc/create_agency_cubit/create_agency_cubit.dart';
import '../../features/agencies/bloc/delete_agency_cubit/delete_agency_cubit.dart';
import '../../features/areas/bloc/areas_cubit/areas_cubit.dart';
import '../../features/areas/bloc/create_area_cubit/create_area_cubit.dart';
import '../../features/areas/bloc/delete_area_cubit/delete_area_cubit.dart';
import '../../features/auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../features/auth/bloc/create_policy_cubit/policy_cubit.dart';
import '../../features/auth/bloc/forgot_password_cubit/forgot_password_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/policy_cubit/create_policy_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../features/car_catigory/bloc/create_car_category_cubit/create_car_category_cubit.dart';
import '../../features/car_catigory/bloc/delete_car_cat_cubit/delete_car_cat_cubit.dart';
import '../../features/clients/bloc/all_clients/all_clients_cubit.dart';
import '../../features/clients/bloc/clients_by_id_cubit/clients_by_id_cubit.dart';
import '../../features/contact/bloc/send_note_cubit/send_note_cubit.dart';
import '../../features/coupons/bloc/all_coupons_vubit/all_coupons_cubit.dart';
import '../../features/coupons/bloc/change_coupon_state_cubit/change_coupon_state_cubit.dart';
import '../../features/coupons/bloc/create_coupon_cubit/create_coupon_cubit.dart';
import '../../features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import '../../features/drivers/bloc/create_driver_cubit/create_driver_cubit.dart';
import '../../features/drivers/bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import '../../features/drivers/bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../features/governorates/bloc/create_governorate_cubit/create_governorate_cubit.dart';
import '../../features/governorates/bloc/delete_governorate_cubit/delete_governorate_cubit.dart';
import '../../features/governorates/bloc/governorates_cubit/governorates_cubit.dart';
import '../../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../../features/institutions/bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../features/institutions/bloc/create_institution_cubit/create_institution_cubit.dart';
import '../../features/institutions/bloc/delete_institution_cubit/delete_institution_cubit.dart';
import '../../features/messages/bloc/all_messages/all_messages_cubit.dart';
import '../../features/notifications/bloc/notification_cubit/notification_cubit.dart';
import '../../features/pay_to_drivers/bloc/financial_report_cubit/financial_report_cubit.dart';
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
import '../../features/reasons/bloc/create_cubit/create_cubit.dart';
import '../../features/reasons/bloc/delete_reason_cubit/delete_reason_cubit.dart';
import '../../features/reasons/bloc/get_reasons_cubit/get_reasons_cubit.dart';
import '../../features/redeems/bloc/create_redeem_cubit/create_redeem_cubit.dart';
import '../../features/redeems/bloc/redeems_cubit/redeems_cubit.dart';
import '../../features/redeems/bloc/redeems_history_cubit/redeems_history_cubit.dart';
import '../../features/roles/bloc/all_permissions_cubit/all_permissions_cubit.dart';
import '../../features/roles/bloc/all_roles/all_roles_cubit.dart';
import '../../features/roles/bloc/create_role_cubit/create_role_cubit.dart';
import '../../features/roles/bloc/delete_role_cubit/delete_role_cubit.dart';
import '../../features/shared_trip/bloc/add_point_cubit/add_point_cubit.dart';
import '../../features/shared_trip/bloc/create_shared_trip_cubit/create_shared_trip_cubit.dart';
import '../../features/shared_trip/bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../../features/shared_trip/bloc/shared_trip_by_id_cubit/shared_trip_by_id_cubit.dart';
import '../../features/shared_trip/bloc/update_shared_cubit/update_shared_cubit.dart';
import '../../features/system_params/bloc/system_params_cubit/system_params_cubit.dart';
import '../../features/system_params/bloc/update_system_params_cubit/update_system_params_cubit.dart';
import '../../features/system_settings/bloc/system_settings_cubit/system_settings_cubit.dart';
import '../../features/system_settings/bloc/update_system_params_cubit/update_system_settings_cubit.dart';
import '../../features/temp_trips/bloc/all_temp_trips_cubit/all_temp_trips_cubit.dart';
import '../../features/temp_trips/bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import '../../features/temp_trips/bloc/delete_temp_trip_cubit/delete_temp_trip_cubit.dart';
import '../../features/temp_trips/bloc/estimate_cubit/estimate_cubit.dart';
import '../../features/temp_trips/bloc/temp_trip_by_id_cubit/temp_trip_by_id_cubit.dart';
import '../../features/ticket/bloc/all_ticket_cubit/all_ticket_cubit.dart';
import '../../features/ticket/bloc/replay_ticket_cubit/replay_ticket_cubit.dart';
import '../../features/trip/bloc/active_trips/active_trips_cubit.dart';
import '../../features/trip/bloc/trip_by_id/trip_by_id_cubit.dart';
import '../../features/trip/bloc/trip_status_cubit/trip_status_cubit.dart';
import '../../features/trip/bloc/trips_cubit/trips_cubit.dart';
import '../../features/wallet/bloc/change_provider_state_cubit/change_provider_state_cubit.dart';
import '../../features/wallet/bloc/charge_client_cubit/charge_client_cubit.dart';
import '../../features/wallet/bloc/debt_cubit/debts_cubit.dart';
import '../../features/wallet/bloc/my_wallet_cubit/my_wallet_cubit.dart';
import '../../features/wallet/bloc/providers_cubit/providers_cubit.dart';
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

  //region contact to us
  sl.registerFactory(() => SendNoteCubit(network: sl()));

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

  sl.registerFactory(() => AddPointCubit());
  sl.registerFactory(() => CreateSharedTripCubit());
  sl.registerFactory(() => GetSharedTripsCubit());
  sl.registerFactory(() => SharedTripByIdCubit());
  sl.registerFactory(() => UpdateSharedCubit());
  sl.registerFactory(() => PathByIdCubit());
  sl.registerFactory(() => TripsCubit());
  sl.registerFactory(() => ActiveTripsCubit());
  //endregion

  //region trip
  sl.registerFactory(() => ChangeTripStatusCubit());
  sl.registerFactory(() => TripByIdCubit());

  //endregion

  //region charge
  sl.registerFactory(() => ChargeClientCubit());
  sl.registerFactory(() => WalletCubit());
  sl.registerFactory(() => DebtsCubit());

  //endregion

  //region drivers
  sl.registerFactory(() => AllDriversCubit());
  sl.registerFactory(() => DriverBuIdCubit());
  sl.registerFactory(() => CreateDriverCubit());

  //endregion

  //region redeems
  sl.registerFactory(() => RedeemsCubit());
  sl.registerFactory(() => CreateRedeemCubit());
  sl.registerFactory(() => RedeemsHistoryCubit());

  //endregion

  //region car category

  sl.registerFactory(() => AllCarCategoriesCubit());
  //endregion

  //region loyalty
  sl.registerFactory(() => LoyaltyCubit());

  //endregion

  //region reasons
  sl.registerFactory(() => GetReasonsCubit());
  sl.registerFactory(() => DeleteReasonCubit());
  sl.registerFactory(() => CreateReasonCubit());

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

  //region tempTrip
  sl.registerFactory(() => CreateTempTripCubit());
  sl.registerFactory(() => AllTempTripsCubit());
  sl.registerFactory(() => DeleteTempTripCubit());
  sl.registerFactory(() => TempTripBuIdCubit());
  sl.registerFactory(() => EstimateCubit());
  //endregion

  //region Coupons
  sl.registerFactory(() => AllCouponsCubit());
  sl.registerFactory(() => ChangeCouponStateCubit());
  sl.registerFactory(() => CreateCouponCubit());
  //endregion

  sl.registerFactory(() => AllClientsCubit());
  sl.registerFactory(() => ClientByIdCubit());
  sl.registerFactory(() => AllTransfersCubit());
  sl.registerFactory(() => ProvidersCubit());
  sl.registerFactory(() => ChangeProviderStateCubit());
  sl.registerFactory(() => PayToCubit());
  sl.registerFactory(() => AccountAmountCubit());
  sl.registerFactory(() => SystemParamsCubit());
  sl.registerFactory(() => UpdateParamsCubit());
  sl.registerFactory(() => UpdateSettingCubit());
  sl.registerFactory(() => SystemSettingsCubit());
  sl.registerFactory(() => CreateNotificationCubit());
  sl.registerFactory(() => FinancialReportCubit());
  sl.registerFactory(() => DriverFinancialCubit());
  sl.registerFactory(() => ReverseChargingCubit());

  //region Governorate

  sl.registerFactory(() => GovernoratesCubit());
  sl.registerFactory(() => CreateGovernorateCubit());
  sl.registerFactory(() => DeleteGovernorateCubit());
  //endregion

  //region Area

  sl.registerFactory(() => AreasCubit());
  sl.registerFactory(() => CreateAreaCubit());
  sl.registerFactory(() => DeleteAreaCubit());
  //endregion

  //region agency

  sl.registerFactory(() => CreateAgencyCubit());
  sl.registerFactory(() => AgenciesCubit());
  sl.registerFactory(() => DeleteAgencyCubit());

  //endregion

//! External
  sl.registerFactory(() => AllTicketsCubit());
  sl.registerFactory(() => ReplayTicketCubit());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Geolocator);
}
