import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/enum_manager.dart';
import '../../../../../core/util/launcher_helper.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/util/shared_preferences.dart';
import '../../../../../core/widgets/images/image_multi_type.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../router/app_router.dart';
import '../../../bloc/trip_status_cubit/trip_status_cubit.dart';

class StartTripWidget extends StatefulWidget {
  const StartTripWidget({Key? key}) : super(key: key);

  @override
  State<StartTripWidget> createState() => _StartTripWidgetState();
}

class _StartTripWidgetState extends State<StartTripWidget> {
  final trip = AppSharedPreference.getCashedTrip();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        if (details.delta.dy > 0) {
          // Handle slide down event
        } else if (details.delta.dy < 0) {
          Navigator.pushNamed(context, RouteNames.tripInfoPage);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientContainer(
            elevation: 0,
            radios: 0.0,
            width: 1.0.sw,
            wrapHeight: true,
            child: DrawableText(
              text: 'رحلة آمنة${trip.getDuration} على الوصول',
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
                  5.0.verticalSpace,
                  ImageMultiType(
                    url: Assets.iconsUp,
                    height: 6.0.h,
                    width: 24.0.w,
                    color: AppColorManager.gray,
                  ),
                  10.0.verticalSpace,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150.0.w,
                        height: 35.0.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0).r,
                        child: DrawableText(
                          text: trip.getDistance,
                          textAlign: TextAlign.center,
                          fontFamily: FontManager.cairoBold,
                        ),
                      ),
                      10.0.horizontalSpace,
                      Container(
                        width: 150.0.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0).r,
                        child: DrawableText(
                          textAlign: TextAlign.center,
                          fontFamily: FontManager.cairoBold,
                          text: trip.getDuration,
                        ),
                      ),
                    ],
                  ),
                  10.0.verticalSpace,
                  BlocBuilder<TripStatusCubit, TripStatusInitial>(
                    builder: (context, state) {
                      if (state.statuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        elevation: 5.0,
                        text: 'بدأ الرحلة (عند ركوب الزبون)',
                        onTap: () {
                          context.read<TripStatusCubit>().changeTripStatus(context,
                              tripId: trip.id, tripStatus: TripStatus.start);
                        },
                      );
                    },
                  ),
                  10.0.verticalSpace,
                  MyButton(
                    text: 'اتصل بالزبون',
                    onTap: () => LauncherHelper.callPhone(trip.clientPhoneNumber),
                  ),
                  15.0.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
