import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/util/file_util.dart';

// import 'package:qareeb_dash/features/trip/bloc/trip_by_id/trip_by_id_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:universal_html/html.dart';
import 'core/app/app_widget.dart';
import 'core/database/db_helper.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:pdf/widgets.dart' as pw;

// import 'features/trip/bloc/nav_trip_cubit/nav_trip_cubit.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

import 'features/members/utile/member_card_utile.dart';

final dbHelper = DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await dbHelper.init();

  await di.init();
  // await ScreenUtil.ensureScreenSize();
  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  try {
    arabicFont = pw.Font.ttf(await rootBundle.load('assets/fonts/IBMPlexSansArabic-Medium.ttf'));
    logoSvg = pw.SvgImage(
        svg: await rootBundle.loadString('assets/icons/logo_with_text.svg'), height: 40.0);
  stamp = await assetImageToMemoryImage('assets/icons/stamp.png');
  } on Exception {}


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
