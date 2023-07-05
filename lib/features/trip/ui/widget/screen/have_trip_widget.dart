import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/launcher_helper.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/enum_manager.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/util/shared_preferences.dart';
import '../../../../../core/widgets/images/image_multi_type.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../router/app_router.dart';
import '../../../bloc/trip_status_cubit/trip_status_cubit.dart';

class HaveTripWidget extends StatefulWidget {
  const HaveTripWidget({Key? key}) : super(key: key);

  @override
  State<HaveTripWidget> createState() => _HaveTripWidgetState();
}

class _HaveTripWidgetState extends State<HaveTripWidget> {
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
              text: trip.getCost,
              textAlign: TextAlign.center,
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
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyButton(
                            elevation: 5.0,
                            width: 150.0.w,
                            text: 'قبول',
                            onTap: () {
                              context.read<TripStatusCubit>().changeTripStatus(context,
                                  tripId: trip.id, tripStatus: TripStatus.accept);
                            },
                          ),
                          10.0.horizontalSpace,
                          MyButton(
                            elevation: 5.0,
                            width: 150.0.w,
                            text: 'رفض',
                            textColor: AppColorManager.mainColor,
                            color: AppColorManager.f1,
                            onTap: () {
                              if (state.statuses == CubitStatuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              context.read<TripStatusCubit>().changeTripStatus(context,
                                  tripId: trip.id, tripStatus: TripStatus.reject);
                            },
                          ),
                        ],
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
