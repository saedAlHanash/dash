import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/trip/bloc/driver_status_cubit/driver_status_cubit.dart';
import 'package:qareeb_dash/router/app_router.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/app_string_manager.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/assets.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverStatusCubit, DriverStatusInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.mainScreen, (route) => false);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawableText.header(
              text: AppStringManager.waitingForOrder,
            ),
            LottieBuilder.asset(
              Assets.lottiesLoading,
              height: 30.0,
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
            BlocBuilder<DriverStatusCubit, DriverStatusInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                return MyButton(
                  elevation: 10.0,
                  width: 100.0.w,
                  text: AppStringManager.stop,
                  textColor: AppColorManager.mainColor,
                  color: AppColorManager.f1,
                  onTap: () {
                    context
                        .read<DriverStatusCubit>()
                        .makeDriverAvailable(context, available: false);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
