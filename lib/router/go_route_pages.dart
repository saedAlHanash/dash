import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/features/admins/bloc/create_admin_cubit/create_admin_cubit.dart';
import 'package:qareeb_dash/features/admins/ui/pages/create_admin_page.dart';
import 'package:qareeb_dash/features/buses/data/response/buses_response.dart';
import 'package:qareeb_dash/features/car_catigory/data/response/car_categories_response.dart';
import 'package:qareeb_dash/features/drivers/bloc/create_driver_cubit/create_driver_cubit.dart';
import 'package:qareeb_dash/features/drivers/bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/ui/pages/create_driver_page.dart';
import 'package:qareeb_dash/features/home/ui/pages/home_page.dart';
import 'package:qareeb_dash/features/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:qareeb_dash/features/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:qareeb_dash/features/members/bloc/create_subscreption_cubit/create_subscreption_cubit.dart';
import 'package:qareeb_dash/features/points/bloc/creta_edge_cubit/create_edge_cubit.dart';
import 'package:qareeb_dash/features/points/bloc/point_by_id_cubit/point_by_id_cubit.dart';
import 'package:qareeb_dash/features/super_user/ui/pages/create_super_user_page.dart';
import 'package:qareeb_dash/features/temp_trips/data/response/temp_trips_response.dart';

import '../core/injection/injection_container.dart' as di;
import '../features/accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../features/admins/ui/pages/admin_info_page.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/bus_trips/bloc/bus_trip_by_id_cubit/bus_trip_by_id_cubit.dart';
import '../features/bus_trips/bloc/create_bus_trip_cubit/create_bus_trip_cubit.dart';
import '../features/bus_trips/ui/pages/create_bus_trip_page.dart';
import '../features/buses/bloc/create_bus_cubit/create_bus_cubit.dart';
import '../features/buses/ui/pages/create_bus_page.dart';
import '../features/car_catigory/bloc/create_car_category_cubit/create_car_category_cubit.dart';
import '../features/car_catigory/ui/pages/create_car_category_page.dart';
import '../features/clients/bloc/clients_by_id_cubit/clients_by_id_cubit.dart';
import '../features/clients/ui/pages/client_info_page.dart';
import '../features/drivers/ui/pages/driver_info_page.dart';
import '../features/home/bloc/nav_home_cubit/nav_home_cubit.dart';
import '../features/institutions/bloc/create_institution_cubit/create_institution_cubit.dart';
import '../features/institutions/data/response/institutions_response.dart';
import '../features/institutions/ui/pages/create_institution_page.dart';
import '../features/map/bloc/search_location/search_location_cubit.dart';
import '../features/map/bloc/set_point_cubit/map_control_cubit.dart';
import '../features/members/bloc/create_member_cubit/create_member_cubit.dart';
import '../features/members/bloc/member_by_id_cubit/member_by_id_cubit.dart';
import '../features/members/ui/pages/create_member_page.dart';
import '../features/members/ui/pages/create_subscreption_page.dart';
import '../features/points/bloc/creta_point_cubit/create_point_cubit.dart';
import '../features/points/bloc/delete_edge_cubit/delete_edge_cubit.dart';
import '../features/points/bloc/delete_point_cubit/delete_point_cubit.dart';
import '../features/points/bloc/get_all_points_cubit/get_edged_point_cubit.dart';
import '../features/points/bloc/get_edged_point_cubit/get_all_points_cubit.dart';
import '../features/points/bloc/get_points_edge_cubit/get_points_edge_cubit.dart';
import '../features/points/ui/pages/point_info_page.dart';
import '../features/roles/bloc/all_permissions_cubit/all_permissions_cubit.dart';
import '../features/roles/bloc/create_role_cubit/create_role_cubit.dart';
import '../features/roles/data/response/roles_response.dart';
import '../features/roles/ui/pages/create_role_page.dart';
import '../features/subscriptions/bloc/add_from_template_cubit/add_from_template_cubit.dart';
import '../features/subscriptions/bloc/all_member_without_subscription_cubit/all_member_without_subscription_cubit.dart';
import '../features/subscriptions/bloc/all_subscriber_cubit/all_subscriber_cubit.dart';
import '../features/subscriptions/bloc/create_subscriptions_cubit/create_subscriptions_cubit.dart';
import '../features/subscriptions/bloc/subscriptions_by_id_cubit/subscriptions_by_id_cubit.dart';
import '../features/subscriptions/ui/pages/create_subscription_page.dart';
import '../features/subscriptions/ui/pages/subscription_info_page.dart';
import '../features/super_user/bloc/create_super_user_cubit/create_super_user_cubit.dart';
import '../features/super_user/data/response/super_users_response.dart';
import '../features/temp_trips/bloc/add_point_cubit/add_point_cubit.dart';
import '../features/temp_trips/bloc/create_temp_trip_cubit/create_temp_trip_cubit.dart';
import '../features/temp_trips/bloc/temp_trip_by_id_cubit/temp_trip_by_id_cubit.dart';
import '../features/temp_trips/ui/pages/create_temp_trip_page.dart';
import '../features/temp_trips/ui/pages/temp_trip_info_page.dart';

final appGoRouter = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    //Replace this method depends on how you are managing your user's
    //Sign in status, then return the appropriate route you want to redirect to,
    //make sure your login/authentication bloc is provided at the top level
    //of your app
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
        final q = state.queryParams['key'];
        context.read<NavHomeCubit>().changePage('/${q ?? ''}');
        return MultiBlocProvider(
          providers: providers,
          child: const HomePage(),
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
          BlocProvider(
              create: (_) => di.sl<DriverBuIdCubit>()..getDriverBuId(context, id: id)),
          BlocProvider(
              create: (_) =>
                  di.sl<AccountAmountCubit>()..getAccountAmount(_, driverId: id)),
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

        final providers = [
          BlocProvider(
              create: (_) => di.sl<PointByIdCubit>()..getPointById(context, id: id)),
          BlocProvider(
              create: (_) => di.sl<EdgesPointCubit>()..getAllEdgesPoint(context, id: id)),
          BlocProvider(create: (_) => di.sl<DeleteEdgeCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<CreatePointCubit>()),
          BlocProvider(create: (_) => di.sl<CreateEdgeCubit>()),
          BlocProvider(create: (_) => di.sl<DeletePointCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const PointInfoPage(),
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

    //region buses

    ///createBus
    GoRoute(
      name: GoRouteName.createBus,
      path: _GoRoutePath.createBus,
      builder: (BuildContext context, GoRouterState state) {
        final role = state.extra == null ? null : (state.extra) as BusModel;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateBusCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateBusPage(bus: role),
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
          BlocProvider(create: (_) => di.sl<CreateTempTripCubit>()),
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

    ///createBusTrip
    GoRoute(
      name: GoRouteName.createBusTrip,
      path: _GoRoutePath.createBusTrip,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateBusTripCubit>()),
          BlocProvider(
            create: (_) => di.sl<BusTripBuIdCubit>()..getBusTripBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CreateBusTripPage(),
        );
      },
    ),
    //endregion

    //region members

    ///createMember
    GoRoute(
      name: GoRouteName.createMember,
      path: _GoRoutePath.createMember,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<MapControlCubit>()),
          BlocProvider(create: (_) => di.sl<MapControllerCubit>()),
          BlocProvider(create: (_) => di.sl<AtherCubit>()),
          BlocProvider(create: (_) => di.sl<CreateMemberCubit>()),
          BlocProvider(create: (_) => di.sl<SearchLocationCubit>()),
          BlocProvider(create: (_) => di.sl<PointsCubit>()..getAllPoints(_)),
          BlocProvider(
            create: (_) => di.sl<MemberBuIdCubit>()..getMemberBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CreateMemberPage(),
        );
      },
    ),
    //endregion

    //region Subscription

    ///createSubscription
    GoRoute(
      name: GoRouteName.createSubscription,
      path: _GoRoutePath.createSubscription,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateSubscriptionCubit>()),
          BlocProvider(
            create: (_) =>
                di.sl<SubscriptionBuIdCubit>()..getSubscriptionBuId(context, id: id),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const CreateSubscriptionPage(),
        );
      },
    ),
    //endregion

    ///subscriptionInfo
    GoRoute(
      name: GoRouteName.subscriptionInfo,
      path: _GoRoutePath.subscriptionInfo,
      builder: (BuildContext context, GoRouterState state) {
        final id = int.tryParse(state.queryParams['id'] ?? '') ?? 0;
        final providers = [
          BlocProvider(create: (_) => di.sl<AddFromTemplateCubit>()),
          BlocProvider(
            create: (_) => di.sl<AllSubscriberCubit>()..getSubscriber(_, tId: id),
          ),
          BlocProvider(
            create: (_) => di.sl<AllMemberWithoutSubscriptionCubit>()
              ..getMemberWithoutSubscription(_),
          ),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: SubscriptionInfoPage(id: id),
        );
      },
    ),
    //endregion

    //region superUser
    ///createSuperUsers
    GoRoute(
      name: GoRouteName.createSuperUsers,
      path: _GoRoutePath.createSuperUsers,
      builder: (BuildContext context, GoRouterState state) {
        final user = state.extra == null ? null : (state.extra) as SuperUserModel;
        final providers = [
          BlocProvider(create: (_) => di.sl<CreateSuperUsersCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: CreateSuperUserPage(superUser: user),
        );
      },
    ),
    //endregion

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
  static const createSubscription = 'createSubscription';
  static const subscription = 'subscription';
  static const createInstitution = 'createInstitution';

  static const createBus = 'createBus';

  static const createSuperUsers = 'createSuperUsers';
  static const createTempTrip = 'createTempTrip';

  static const createMember = 'createMember';

  static const createBusTrip = 'createBusTrip';
  static const tempTripInfo = 'tempTripInfo';
  static const subscriptionInfo = 'subscriptionInfo';
}

class _GoRoutePath {
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
  static const createSubscription = '/createSubscription';
  static const subscription = '/subscription';
  static const createInstitution = '/createInstitution';
  static const createBus = '/createBus';
  static const createSuperUsers = '/createSuperUsers';
  static const createTempTrip = '/createTempTrip';
  static const createMember = '/createMember';
  static const createBusTrip = '/createBusTrip';
  static const tempTripInfo = '/tempTripInfo';
  static const subscriptionInfo = '/subscriptionInfo';
}
