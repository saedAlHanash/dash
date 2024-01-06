import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/bloc/search_location/search_location_cubit.dart';
import 'package:map_package/map/bloc/set_point_cubit/map_control_cubit.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/features/accounts/data/request/driver_financial_filter_request.dart';
import 'package:qareeb_dash/features/admins/bloc/create_admin_cubit/create_admin_cubit.dart';
import 'package:qareeb_dash/features/admins/ui/pages/create_admin_page.dart';
import 'package:qareeb_dash/features/agencies/bloc/agency_report_cubit/agency_report_cubit.dart';
import 'package:qareeb_dash/features/coupons/data/response/coupons_response.dart';
import 'package:qareeb_dash/features/drivers/bloc/create_driver_cubit/create_driver_cubit.dart';
import 'package:qareeb_dash/features/drivers/bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/ui/pages/create_driver_page.dart';
import 'package:qareeb_dash/features/home/ui/pages/home_page.dart';
import 'package:qareeb_dash/features/points/bloc/creta_edge_cubit/create_edge_cubit.dart';
import 'package:qareeb_dash/features/points/bloc/point_by_id_cubit/point_by_id_cubit.dart';
import 'package:qareeb_dash/features/trip/ui/pages/trips_page.dart';
import 'package:qareeb_models/agencies/data/response/agencies_financial_response.dart';
import 'package:qareeb_models/car_catigory/data/response/car_categories_response.dart';
import 'package:qareeb_models/companies/data/response/companies_response.dart';
import 'package:qareeb_models/plans/data/response/plans_response.dart';

import '../core/injection/injection_container.dart' as di;
import '../core/util/shared_preferences.dart';
import '../features/accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../features/accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';
import '../features/admins/ui/pages/admin_info_page.dart';
import '../features/agencies/ui/pages/agency_report_page.dart';
import '../features/areas/bloc/areas_cubit/areas_cubit.dart';
import '../features/areas/bloc/create_area_cubit/create_area_cubit.dart';
import '../features/areas/bloc/delete_area_cubit/delete_area_cubit.dart';
import '../features/areas/ui/pages/areas_page.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/car_catigory/bloc/create_car_category_cubit/create_car_category_cubit.dart';
import '../features/car_catigory/ui/pages/create_car_category_page.dart';
import '../features/clients/bloc/clients_by_id_cubit/clients_by_id_cubit.dart';
import '../features/clients/ui/pages/client_info_page.dart';
import '../features/companies/bloc/create_company_cubit/create_company_cubit.dart';
import '../features/companies/ui/pages/create_company_page.dart';
import '../features/company_paths/bloc/company_path_by_id_cubit/company_path_by_id_cubit.dart';
import '../features/company_paths/bloc/create_compane_path_cubit/create_company_path_cubit.dart';
import '../features/company_paths/bloc/estimate_cubit/estimate_company_cubit.dart';
import '../features/company_paths/ui/pages/company_path_info_page.dart';
import '../features/company_paths/ui/pages/create_company_path_page.dart';
import '../features/coupons/bloc/create_coupon_cubit/create_coupon_cubit.dart';
import '../features/coupons/ui/pages/create_coupon_page.dart';
import '../features/drivers/bloc/driver_status_history_cubit/driver_status_history_cubit.dart';
import '../features/drivers/ui/pages/driver_info_page.dart';
import '../features/drivers/ui/pages/trans_driver_info_page.dart';
import '../features/home/ui/pages/agency_home_page.dart';
import '../features/home/ui/pages/trans_home_page.dart';
import '../features/institutions/bloc/create_institution_cubit/create_institution_cubit.dart';
import '../features/institutions/data/response/institutions_response.dart';
import '../features/institutions/ui/pages/create_institution_page.dart';
import '../features/plan_trips/bloc/create_plan_trip_cubit/create_plan_trip_cubit.dart';
import '../features/plan_trips/bloc/plan_trip_by_id_cubit/plan_trip_by_id_cubit.dart';
import '../features/plan_trips/ui/pages/create_plan_trip_page.dart';
import '../features/plans/bloc/create_plan_cubit/create_plan_cubit.dart';
import '../features/plans/data/response/plans_response.dart';
import '../features/plans/ui/pages/create_plan_page.dart';
import '../features/points/bloc/creta_point_cubit/create_point_cubit.dart';
import '../features/points/bloc/delete_edge_cubit/delete_edge_cubit.dart';
import '../features/points/bloc/delete_point_cubit/delete_point_cubit.dart';
import '../features/points/bloc/get_all_points_cubit/get_edged_point_cubit.dart';
import '../features/points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../features/points/bloc/get_points_edge_cubit/get_points_edge_cubit.dart';
import '../features/points/ui/pages/point_info_page.dart';
import '../features/points/ui/pages/points_page.dart';
import '../features/redeems/bloc/create_redeem_cubit/create_redeem_cubit.dart';
import '../features/redeems/bloc/redeems_cubit/redeems_cubit.dart';
import '../features/redeems/bloc/redeems_history_cubit/redeems_history_cubit.dart';
import '../features/redeems/ui/pages/redeems_page.dart';
import '../features/roles/bloc/all_permissions_cubit/all_permissions_cubit.dart';
import '../features/roles/bloc/create_role_cubit/create_role_cubit.dart';
import '../features/roles/data/response/roles_response.dart';
import '../features/roles/ui/pages/create_role_page.dart';
import '../features/shared_trip/bloc/add_point_cubit/add_point_cubit.dart';
import '../features/shared_trip/bloc/get_shared_trips_cubit/get_shared_trips_cubit.dart';
import '../features/shared_trip/bloc/shared_trip_by_id_cubit/shared_trip_by_id_cubit.dart';
import '../features/shared_trip/bloc/update_shared_cubit/update_shared_cubit.dart';
import '../features/shared_trip/ui/pages/shared_trip_info_page.dart';
import '../features/shared_trip/ui/pages/shared_trips_page.dart';
import '../features/temp_trips/bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import '../features/temp_trips/bloc/estimate_cubit/estimate_cubit.dart';
import '../features/temp_trips/bloc/temp_trip_by_id_cubit/temp_trip_by_id_cubit.dart';
import '../features/temp_trips/ui/pages/create_temp_trip_page.dart';
import '../features/temp_trips/ui/pages/temp_trip_info_page.dart';
import '../features/trip/bloc/candidate_drivers_cubit/candidate_drivers_cubit.dart';
import '../features/trip/bloc/trip_by_id/trip_by_id_cubit.dart';
import '../features/trip/bloc/trip_debit_cubit/trip_debit_cubit.dart';
import '../features/trip/bloc/trip_status_cubit/trip_status_cubit.dart';
import '../features/trip/bloc/trips_cubit/trips_cubit.dart';
import '../features/trip/data/request/filter_trip_request.dart';
import '../features/trip/ui/pages/trans_trip_info_page.dart';
import '../features/trip/ui/pages/trip_info_page.dart';
import '../features/wallet/bloc/debt_cubit/debts_cubit.dart';
import '../features/wallet/bloc/my_wallet_cubit/my_wallet_cubit.dart';
import '../features/wallet/ui/pages/debts_page.dart';
import '../services/osrm/bloc/location_name_cubit/location_name_cubit.dart';

final appGoRouter = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    //Replace this method depends on how you are managing your user's
    //Sign in status, then return the appropriate route you want to redirect to,
    //make sure your login/authentication bloc is provided at the top level
    //of your app
    loggerObject.w('message');
    if (!AppSharedPreference.isLogin) {
      return _GoRoutePath.loginPage;
    } else {
      //else, remain at login page
      return null;
    }
  },

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
//if (isQareebAdmin && !isAgency)
        return MultiBlocProvider(
          providers: providers,
          child: isTrans
              ? const TransHomePage()
              : isAgency
                  ? const AgencyHomePage()
                  : const HomePage(),
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
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;

        // final driver = DriverModel.fromJson(jsonDecode(json));
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateRedeemCubit>()),
          BlocProvider(create: (_) => di.sl<ReverseChargingCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<WalletCubit>()..getWallet(id: id)),
          BlocProvider(create: (_) => di.sl<DebtsCubit>()..getDebts(_, id: id)),
          BlocProvider(create: (_) => di.sl<RedeemsCubit>()..getRedeems(_, driverId: id)),
          BlocProvider(
              create: (_) => di.sl<DriverStatusHistoryCubit>()
                ..getDriverStatusHistory(_, driverId: id)),
          BlocProvider(
              create: (_) => di.sl<DriverBuIdCubit>()..getDriverBuId(context, id: id)),
          BlocProvider(
              create: (_) =>
                  di.sl<RedeemsHistoryCubit>()..getRedeemsHistory(_, driverId: id)),
          BlocProvider(
            create: (_) => di.sl<DriverFinancialCubit>()
              ..getDriverFinancial(_,
                  request: DriverFinancialFilterRequest(driverId: id)),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: isTrans ? const TransDriverInfoPage() : const DriverInfoPage(),
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

    //region agency

    ///agencyReport
    GoRoute(
      name: GoRouteName.agencyReport,
      path: _GoRoutePath.agencyReport,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;

        // final driver = DriverModel.fromJson(jsonDecode(json));
        final providers = [
          BlocProvider(
              create: (_) => di.sl<AgencyReportCubit>()..getAgencyReport(_, id: id)),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const AgencyReportPage(),
        );
      },
    ),

    //endregion

    //region admins
    ///createAdmin
    GoRoute(
      name: GoRouteName.createAdmin,
      path: _GoRoutePath.createAdmin,
      builder: (BuildContext context, GoRouterState state) {
        final admin = state.extra == null ? null : (state.extra) as DriverModel;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateAdminCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateAdminPage(admin: admin),
        );
      },
    ),

    ///adminInfo
    GoRoute(
      name: GoRouteName.adminInfo,
      path: _GoRoutePath.adminInfo,
      builder: (BuildContext context, GoRouterState state) {
        final admin =
            state.extra == null ? DriverModel.fromJson({}) : (state.extra) as DriverModel;
        return AdminInfoPage(admin: admin);
      },
    ),
    //endregion

    //region clients
    ///clientInfo
    GoRoute(
      name: GoRouteName.clientInfo,
      path: _GoRoutePath.clientInfo,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;

        // final driver = DriverModel.fromJson(jsonDecode(json));
        final providers = [
          BlocProvider(
              create: (_) => di.sl<ClientByIdCubit>()..getClientBuId(context, id: id)),
          BlocProvider(create: (_) => di.sl<WalletCubit>()..getWallet(id: id)),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const ClientInfoPage(),
        );
      },
    ),

    //endregion

    //region carCategory
    ///CreateCarCategory
    GoRoute(
      name: GoRouteName.createCarCategory,
      path: _GoRoutePath.createCarCategory,
      builder: (BuildContext context, GoRouterState state) {
        final carCat = state.extra == null ? null : (state.extra) as CarCategory;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateCarCategoryCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateCarCategoryPage(carCat: carCat),
        );
      },
    ),

    //endregion

    //region points
    ///pointInfo
    GoRoute(
      name: GoRouteName.pointInfo,
      path: _GoRoutePath.pointInfo,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;

        final arg = state.extra;
        final providers = [
          BlocProvider(
              create: (_) => di.sl<PointByIdCubit>()..getPointById(context, id: id)),
          BlocProvider(
              create: (_) => di.sl<EdgesPointCubit>()..getAllEdgesPoint(context, id: id)),
          BlocProvider(create: (_) => di.sl<DeleteEdgeCubit>()),
          BlocProvider(create: (_) => di.sl<LocationNameCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<CreatePointCubit>()),
          BlocProvider(create: (_) => di.sl<CreateEdgeCubit>()),
          BlocProvider(create: (_) => di.sl<DeletePointCubit>()),
          BlocProvider(create: (_) => di.sl<SearchLocationCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: PointInfoPage(mapMediator: arg == null ? null : arg as MapMediator),
        );
      },
    ),
    //endregion

    //region trips

    ///tripInfo
    GoRoute(
      name: GoRouteName.tripInfo,
      path: _GoRoutePath.tripInfo,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;

        final providers = [
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<ChangeTripStatusCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<TripByIdCubit>()..tripById(_, tripId: id)),
          BlocProvider(create: (_) => di.sl<TripDebitCubit>()..tripDebit(_, tripId: id)),
          BlocProvider(
              create: (_) =>
                  di.sl<CandidateDriversCubit>()..getCandidateDrivers(_, tripId: id)),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: (isTrans) ? const TransTripInfoPage() : const TripInfoPage(),
        );
      },
    ),

    ///tripsPae
    GoRoute(
      name: GoRouteName.tripsPae,
      path: _GoRoutePath.tripsPae,
      builder: (BuildContext context, GoRouterState state) {
        final clientId = int.tryParse(state.queryParams['clientId'] ?? '');
        final driverId = int.tryParse(state.queryParams['driverId'] ?? '');
        final driverName = state.queryParams['driverName'] ?? '';
        final clientName = state.queryParams['clientName'] ?? '';

        final providers = [
          BlocProvider(
            create: (_) => di.sl<TripsCubit>()
              ..getTrips(
                context,
                command: Command.initial().copyWith(
                  filterTripRequest: FilterTripRequest(
                    clientId: clientId,
                    driverId: driverId,
                    driverName: driverName,
                    clientName: clientName,
                  ),
                ),
              ),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const TripsPage(withAppBar: true),
        );
      },
    ),

    //endregion

    //region sharedTripInfo
    ///sharedTripInfo
    GoRoute(
      name: GoRouteName.sharedTripInfo,
      path: _GoRoutePath.sharedTripInfo,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;
        final requestId = int.tryParse(state.queryParams['requestId'] ?? '0') ?? 0;

        final providers = [
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<UpdateSharedCubit>()),
          BlocProvider(
            create: (_) => di.sl<SharedTripByIdCubit>()
              ..getSharedTripById(_, id: id, requestId: requestId),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const SharedTripInfoPage(),
        );
      },
    ),

    ///sharedTripsPae
    GoRoute(
      name: GoRouteName.sharedTripsPae,
      path: _GoRoutePath.sharedTripsPae,
      builder: (BuildContext context, GoRouterState state) {
        final clientId = int.tryParse(state.queryParams['clientId'] ?? '');
        final driverId = int.tryParse(state.queryParams['driverId'] ?? '');
        final driverName = state.queryParams['driverName'] ?? '';
        final clientName = state.queryParams['clientName'] ?? '';

        final providers = [
          BlocProvider(
            create: (_) => di.sl<GetSharedTripsCubit>()
              ..getSharesTrip(
                context,
                command: Command.initial().copyWith(
                  filterTripRequest: FilterTripRequest(
                    clientId: clientId,
                    driverId: driverId,
                    driverName: driverName,
                    clientName: clientName,
                  ),
                ),
              ),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const SharedTripsPage(withAppBar: true),
        );
      },
    ),
    //endregion

    //region institutions

    ///createInstitution
    GoRoute(
      name: GoRouteName.createInstitution,
      path: _GoRoutePath.createInstitution,
      builder: (BuildContext context, GoRouterState state) {
        final institution =
            state.extra == null ? null : (state.extra) as InstitutionModel;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateInstitutionCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateInstitutionPage(institution: institution),
        );
      },
    ),
    //endregion

    //region companies

    ///createCompany
    GoRoute(
      name: GoRouteName.createCompany,
      path: _GoRoutePath.createCompany,
      builder: (BuildContext context, GoRouterState state) {
        final company = state.extra == null ? null : (state.extra) as CompanyModel;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateCompanyCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateCompanyPage(company: company),
        );
      },
    ),

    ///createCompanyPath
    GoRoute(
      name: GoRouteName.createCompanyPath,
      path: _GoRoutePath.createCompanyPath,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<MapControlCubit>()),
          BlocProvider(create: (_) => di.sl<AddPointCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<PointsEdgeCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<CreateCompanyPathCubit>()),
          BlocProvider(create: (_) => di.sl<EstimateCompanyCubit>()),
          if (id != 0)
            BlocProvider(create: (_) => di.sl<PointsCubit>())
          else
            BlocProvider(create: (_) => di.sl<PointsCubit>()..getAllPoints(_)),
          BlocProvider(
            create: (_) =>
                di.sl<CompanyPathBuIdCubit>()..getCompanyPathBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CreateCompanyPathPage(),
        );
      },
    ),

    ///companyPathInfo
    GoRoute(
      name: GoRouteName.companyPathInfo,
      path: _GoRoutePath.companyPathInfo,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<MapControlCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<EstimateCompanyCubit>()),
          BlocProvider(
            create: (_) =>
                di.sl<CompanyPathBuIdCubit>()..getCompanyPathBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CompanyPathInfoPage(),
        );
      },
    ),

    //endregion

    //region plans

    ///createPlan
    GoRoute(
      name: GoRouteName.createPlan,
      path: _GoRoutePath.createPlan,
      builder: (BuildContext context, GoRouterState state) {
        final plan = state.extra == null ? null : (state.extra) as PlanModel;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreatePlanCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreatePlanPage(plan: plan),
        );
      },
    ),
    //endregion

    //region temp trips

    ///createTempTrip
    GoRoute(
      name: GoRouteName.createTempTrip,
      path: _GoRoutePath.createTempTrip,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<MapControlCubit>()),
          BlocProvider(create: (_) => di.sl<AddPointCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<PointsEdgeCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<CreateTempTripCubit>()),
          BlocProvider(create: (_) => di.sl<EstimateCubit>()),
          if (id != 0)
            BlocProvider(create: (_) => di.sl<PointsCubit>())
          else
            BlocProvider(create: (_) => di.sl<PointsCubit>()..getAllPoints(_)),
          BlocProvider(
            create: (_) => di.sl<TempTripBuIdCubit>()..getTempTripBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CreateTempTripPage(),
        );
      },
    ),

    ///tempTripInfo
    GoRoute(
      name: GoRouteName.tempTripInfo,
      path: _GoRoutePath.tempTripInfo,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<MapControlCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<EstimateCubit>()),
          BlocProvider(
            create: (_) => di.sl<TempTripBuIdCubit>()..getTempTripBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const TempTripInfoPage(),
        );
      },
    ),

    //endregion

    //region bus trips

    ///createPlanTrip
    GoRoute(
      name: GoRouteName.createPlanTrip,
      path: _GoRoutePath.createPlanTrip,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final tIndex = int.tryParse(state.queryParams['t_index'] ?? '') ?? 0;

        final providers = [
          BlocProvider(create: (_) => di.sl<CreatePlanTripCubit>()),
          BlocProvider(
            create: (_) => di.sl<PlanTripBuIdCubit>()..getPlanTripBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CreatePlanTripPage(),
        );
      },
    ),
    //endregion

    ///createCoupon
    GoRoute(
      name: GoRouteName.createCoupon,
      path: _GoRoutePath.createCoupon,
      builder: (BuildContext context, GoRouterState state) {
        final coupon = state.extra == null ? null : (state.extra) as Coupon;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateCouponCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateCouponPage(coupon: coupon),
        );
      },
    ),

    ///createRole
    GoRoute(
      name: GoRouteName.createRole,
      path: _GoRoutePath.createRole,
      builder: (BuildContext context, GoRouterState state) {
        final role = state.extra == null ? null : (state.extra) as Role;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateRoleCubit>()),
          BlocProvider(create: (_) => di.sl<AllPermissionsCubit>()..getAllPermissions(_)),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateRolePage(role: role),
        );
      },
    ),

    ///createRole
    GoRoute(
      name: GoRouteName.area,
      path: _GoRoutePath.area,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;

        final providers = [
          BlocProvider(create: (_) => di.sl<AreasCubit>()..getArea(_, id: id)),
          BlocProvider(create: (_) => di.sl<CreateAreaCubit>()),
          BlocProvider(create: (_) => di.sl<DeleteAreaCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: AreasPage(governorateId: id),
        );
      },
    ),

    ///createRole
    GoRoute(
      name: GoRouteName.redeems,
      path: _GoRoutePath.redeems,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '0') ?? 0;

        final providers = [
          BlocProvider(
            create: (_) =>
                di.sl<RedeemsHistoryCubit>()..getRedeemsHistory(_, driverId: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const RedeemsPage(),
        );
      },
    ),
  ],
);

class GoRouteName {
  static const homePage = 'Home Page';
  static const loginPage = 'Login Page';
  static const driverInfo = 'driver info';
  static const debts = 'debts';
  static const createDriver = 'createDriver';
  static const updateDriver = 'updateDriver';
  static const createCarCategory = 'CreateCarCategory';
  static const createAdmin = 'createAdmin';
  static const adminInfo = 'adminInfo';
  static const clientInfo = 'clientInfo';
  static const pointInfo = 'pointInfo';
  static const tripInfo = 'tripInfo';
  static const sharedTripInfo = 'sharedTripInfo';
  static const createCoupon = 'createCoupon';
  static const createRole = 'createRole';
  static const tripsPae = 'tripsPae';
  static const sharedTripsPae = 'sharedTripsPae';
  static const createInstitution = 'createInstitution';
  static const createTempTrip = 'createTempTrip';
  static const tempTripInfo = 'tempTripInfo';
  static const area = 'area';
  static const redeems = 'redeems';

  static const createCompany = 'createCompany';
  static const createPlan = 'createPlan';
  static const agencyReport = 'agencyReport';
  static const createCompanyPath = 'createCompanyPath';
  static const companyPathInfo = 'companyPathInfo';
  static const createPlanTrip = 'createPlanTrip';
}

class _GoRoutePath {
  static const createCompany = '/createCompany';
  static const homePage = '/Home';
  static const driverInfo = '/DriverInfo';
  static const loginPage = '/';
  static const debts = '/debts';
  static const createDriver = '/createDriver';
  static const updateDriver = '/updateDriver';
  static const createCarCategory = '/CreateCarCategory';
  static const createAdmin = '/createAdmin';
  static const adminInfo = '/adminInfo';
  static const clientInfo = '/clientInfo';
  static const pointInfo = '/pointInfo';
  static const tripInfo = '/tripInfo';
  static const sharedTripInfo = '/sharedTripInfo';
  static const createCoupon = '/createCoupon';
  static const createRole = '/createRole';
  static const tripsPae = '/tripsPae';
  static const sharedTripsPae = '/sharedTripsPae';
  static const createInstitution = '/createInstitution';
  static const createTempTrip = '/createTempTrip';
  static const tempTripInfo = '/tempTripInfo';
  static const area = '/area';
  static const redeems = '/redeems';
  static const createPlan = '/createPlan';
  static const agencyReport = '/agencyReport';
  static const createCompanyPath = '/createCompanyPath';
  static const companyPathInfo = '/companyPathInfo';
  static const createPlanTrip = '/createPlanTrip';
}
