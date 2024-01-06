import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_package/api_manager/api_service.dart';
import 'package:map_package/api_manager/api_service.dart';
import 'package:map_package/api_manager/api_service.dart';
import 'package:qareeb_dash/features/trip/bloc/trip_by_id/trip_by_id_cubit.dart';
import 'package:qareeb_models/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/api_manager/api_url.dart';
import 'core/app/app_widget.dart';
import 'core/database/db_helper.dart';
import 'core/firebase/insert_firebase_token_service.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/injection/injection_container.dart';
import 'core/util/shared_preferences.dart';
import 'firebase_options.dart';

final dbHelper = DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await dbHelper.init();

  await di.init();
  // await ScreenUtil.ensureScreenSize();
  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();
  // initializeService();

  qareebModelsBaseUrl = baseUrl;

  if (AppSharedPreference.isLogin) {
    sl<InsertFirebaseTokenService>().insertFirebaseToken();
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TripByIdCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  loggerObject.w('background ');
}
