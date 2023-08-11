import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/trip/bloc/driver_status_cubit/driver_status_cubit.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/app_string_manager.dart';
import '../../../../../core/util/shared_preferences.dart';
import '../../../../../core/widgets/images/image_multi_type.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../router/app_router.dart';

class FinalTripWidget extends StatefulWidget {
  const FinalTripWidget({Key? key}) : super(key: key);

  @override
  State<FinalTripWidget> createState() => _FinalTripWidgetState();
}

class _FinalTripWidgetState extends State<FinalTripWidget> {
  final trip = AppSharedPreference.getCashedTrip();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientContainer(
          elevation: 0,
          radios: 0.0,
          width: 1.0.sw,
          wrapHeight: true,
          child: DrawableText(
            text: 'انتهت الرحلة كلفة الرحلة : ${trip.getCost}',
            drawableEnd: Icon(
              Icons.check,
              color: Colors.white,
              size: 13.0.spMin,
            ),
            drawableAlin: DrawableAlin.between,
            color: Colors.white,
            matchParent: true,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0).r,
          ),
        ),
        Container(
          color: AppColorManager.f1,
          padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
          child: SizedBox(
            width: 1.0.sw,
            child: Column(
              children: [
                20.0.verticalSpace,
                if (!trip.isClientRated)
                  MyButton(
                    child: DrawableText(
                      text: AppStringManager.ratingDriver,
                      color: AppColorManager.whit,
                      fontFamily: FontManager.cairoBold,
                      drawablePadding: 10.0.w,
                      drawableEnd: const ImageMultiType(url: Assets.iconsFullStar),
                    ),
                    onTap: () => onRating(context),
                  ),
                5.0.verticalSpace,
                MyButton(
                  text: AppStringManager.back,
                  color: AppColorManager.black,
                  textColor: AppColorManager.whit,
                  onTap: () {
                    AppSharedPreference.removeCashedTrip();
                    context
                        .read<DriverStatusCubit>()
                        .makeDriverAvailable(context, available: true);
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.tripPage, (route) => false);
                  },
                ),
                5.0.verticalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }

  onRating(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      RouteNames.ratingPage,
      arguments: AppSharedPreference.getCashedTrip(),
    );

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, RouteNames.mainScreen, (route) => false);
    }

    AppSharedPreference.removeCashedTrip();
  }
}
