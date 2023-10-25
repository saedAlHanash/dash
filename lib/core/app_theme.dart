import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';

final primaryColor = /*AppSharedPreference.isTestMode
    ? AppColorManager.mainColorLight
    : */AppColorManager.mainColor;
const secondaryColor = AppColorManager.mainColorDark;

final appTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    textTheme: _fixBlurryTextIssue(const TextTheme()),
    scaffoldBackgroundColor: Colors.white,
    switchTheme: SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(primaryColor),
        overlayColor: const MaterialStatePropertyAll(secondaryColor)),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(primary: primaryColor, secondary: secondaryColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));

/// Fix sometimes blurry text when using HTML renderer on web by forcing usage of <p> elements.
///
/// TODO: Remove when upstream is fixed :) [flutter/flutter#81215](https://github.com/flutter/flutter/issues/81215)
TextTheme _fixBlurryTextIssue(TextTheme theme) {
  const style = TextStyle(fontFeatures: [FontFeature.proportionalFigures()]);
  return theme.merge( const TextTheme(
    displayLarge: style,
    displayMedium: style,
    displaySmall: style,
    headlineLarge: style,
    headlineMedium: style,
    headlineSmall: style,
    titleLarge: style,
    titleMedium: style,
    titleSmall: style,
    bodyLarge: style,
    bodyMedium: style,
    bodySmall: style,
    labelLarge: style,
    labelMedium: style,
    labelSmall: style,
  ));
}
