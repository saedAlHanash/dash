
import 'package:flutter/material.dart';
import 'package:qareeb_super_user/temp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app/app_widget.dart';
import 'core/database/db_helper.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';

final dbHelper = DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dbHelper.init();

  await di.init();
  // await ScreenUtil.ensureScreenSize();
  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  runApp(const MyApp());
}
