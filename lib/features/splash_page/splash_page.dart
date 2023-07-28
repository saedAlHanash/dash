import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qareeb_super_user/core/strings/app_color_manager.dart';
import 'package:qareeb_super_user/core/util/shared_preferences.dart';
import 'package:qareeb_super_user/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_super_user/generated/assets.dart';
import 'package:qareeb_super_user/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () async {
      if (!AppSharedPreference.isAcceptPolicy) {
        Navigator.pushReplacementNamed(context, RouteNames.policyScreen);
        return;
      }

      if (AppSharedPreference.isLogin) {

        Navigator.pushReplacementNamed(context, RouteNames.mainScreen);
        return;
      }

      Navigator.pushReplacementNamed(context, RouteNames.authPage);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            0.0.verticalSpace,
            ImageMultiType(
              url: Assets.iconsLogoWithText,
              width: 200.spMin,
              height: 200.spMin,
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
}
