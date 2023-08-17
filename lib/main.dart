import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qareeb_dash/features/trip/bloc/trip_by_id/trip_by_id_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:universal_html/html.dart';
import 'core/app/app_widget.dart';
import 'core/database/db_helper.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';
// import 'features/trip/bloc/nav_trip_cubit/nav_trip_cubit.dart';

final dbHelper = DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await dbHelper.init();

  await di.init();
  // await ScreenUtil.ensureScreenSize();
  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  var e = document.getElementById('loading');
  e?.style.display = 'none';
  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();
  // initializeService();

  runApp(
    const MyApp(),
  );
}
