import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/features/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_dash/router/app_router.dart';

import '../../core/widgets/images/image_multi_type.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    timer(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            0.0.verticalSpace,
            const ImageMultiType(
              url: Assets.iconsLogoWithText,
              width: 200,
              height: 200,
            ),
            LottieBuilder.asset(
              Assets.lottiesLoading,
              height: 100.0,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    // keyPath order: ['layer name', 'group name', 'shape name']
                    const ['Shape Layer 6', '**'],
                    value: AppColorManager.mainColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void timer(BuildContext context) {
    Timer(const Duration(milliseconds: 1500), () async {
      await AtherCubit.getDriverDistance(
          ime: '359632107579978',
          start: DateTime.now().addFromNow(day: -1),
          end: DateTime.now());

      if (AppSharedPreference.isLogin) {
        if (await AppSharedPreference.isDriverAvailable) {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, RouteNames.tripPage);
          }
          return;
        }
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.mainScreen);
        }
        return;
      }

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.authPage);
      }
    });
  }
}
