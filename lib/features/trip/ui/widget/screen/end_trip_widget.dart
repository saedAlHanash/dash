import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/features/trip/bloc/trip_by_id/trip_by_id_cubit.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/util/shared_preferences.dart';
import '../../../../../core/widgets/images/image_multi_type.dart';
import '../../../../../core/widgets/my_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../../router/app_router.dart';
import '../../../bloc/trip_status_cubit/trip_status_cubit.dart';

class EndTripWidget extends StatefulWidget {
  const EndTripWidget({Key? key}) : super(key: key);

  @override
  State<EndTripWidget> createState() => _EndTripWidgetState();
}

class _EndTripWidgetState extends State<EndTripWidget> {
  var trip = AppSharedPreference.getCashedTrip();

  var checkLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
              text: 'رافقتك السلامة',
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
                    children: [
                      if (trip.isPaid)
                        Expanded(
                          child: BlocBuilder<TripStatusCubit, TripStatusInitial>(
                            builder: (context, state) {
                              if (state.statuses.isLoading) {
                                return MyStyle.loadingWidget();
                              }
                              return Center(
                                child: MyButton(
                                  elevation: 5.0,
                                  text: 'إنهاء الرحلة',
                                  onTap: () {
                                    context.read<TripStatusCubit>().changeTripStatus(
                                          context,
                                          tripId: trip.id,
                                          tripStatus: TripStatus.end,
                                        );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      if (!trip.isPaid)
                        Expanded(
                          child: StatefulBuilder(builder: (context, myState) {
                            if (checkLoading) {
                              return MyStyle.loadingWidget();
                            }
                            return MyButton(
                              elevation: 5.0,
                              text: 'تحقق من الدفع',
                              onTap: () async {
                                myState(() => checkLoading = true);
                                await TripByIdCubit.tripByIdApi(tripId: trip.id);
                                myState(() => checkLoading = false);

                                trip = AppSharedPreference.getCashedTrip();
                                setState(() {});
                              },
                            );
                          }),
                        ),
                      if (!trip.isPaid) 10.0.horizontalSpace,
                      if (!trip.isPaid)
                        Expanded(
                          child: Column(
                            children: [
                              MyButton(
                                elevation: 5.0,
                                text: 'شحن رصيد للزبون',
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    RouteNames.chargeWallet,
                                    arguments: trip.clientPhoneNumber,
                                  );

                                  if ((result ?? false) == true) {
                                    await TripByIdCubit.tripByIdApi(tripId: trip.id);
                                    setState(() {});
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  10.0.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
