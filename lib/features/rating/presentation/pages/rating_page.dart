import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/images/image_multi_type.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/table_widget.dart';
import '../../../../core/widgets/top_title_widget.dart';
import '../../../../generated/assets.dart';
import '../../../trip/data/response/trip_response.dart';
import '../../domain/entities/request/rating_request.dart';
import '../bloc/rating_cubit/rating_cubit.dart';

class RatingDriverPage extends StatelessWidget {
  const RatingDriverPage({Key? key, required this.trip}) : super(key: key);

  final TripResult trip;

  @override
  Widget build(BuildContext context) {
    final request = RatingRequest.fromJson({});

    void onAddRateClick() {
      request.orderId = trip.id;
      request.ratedUserId = trip.driverId;
      context.read<RatingCubit>().ratingDriver(context, request: request);
    }

    //region listeners

    void onBackClick() => Navigator.pop(context, false);
    void onRatingChange(double rating) => request.rating = rating;
    void onTextChange(String text) => request.notes = text;

    //endregion

    final Map<String, String> map = {
      AppStringManager.name: trip.clientName,
    };

    final margin = EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h);

    return BlocListener<RatingCubit, RatingInitial>(
      listenWhen: (previous, current) => current.statuses.done,
      listener: (context, state) => Navigator.pop(context, true),
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TopTitleWidget(text: 'تقييم العميل', icon: Assets.iconsHistory),
              MyCardWidget(
                elevation: 10.0,
                margin: margin,
                child: Column(
                  children: [
                    // CircleImageWidget(
                    //   size: 40.0.spMin,
                    //   url: trip.t,
                    // ),
                    10.0.verticalSpace,
                    MyTableWidget(
                      children: map,
                      title: 'معلومات العميل',
                    ),
                    10.0.verticalSpace,
                    RatingBarWidget(onRatingUpdate: onRatingChange),
                    10.0.verticalSpace,
                    SizedBox(
                      height: 150.0.h,
                      child: MyCardWidget(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        cardColor: AppColorManager.whit,
                        child: MyEditTextWidget(
                          hint: AppStringManager.yourNotes,
                          onChanged: onTextChange,
                        ),
                      ),
                    ),
                    20.0.verticalSpace,
                    BlocBuilder<RatingCubit, RatingInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButton(
                          text: AppStringManager.addRate,
                          onTap: onAddRateClick,
                        );
                      },
                    ),
                    10.0.verticalSpace,
                    MyButton(
                      text: AppStringManager.back,
                      color: AppColorManager.black,
                      onTap: onBackClick,
                    ),
                    10.0.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({Key? key, required this.onRatingUpdate}) : super(key: key);
  final Function(double) onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    //region listener

    //endregion
    final startSize = 27.0.spMin;

    final emptyStar = ImageMultiType(
      url: Assets.iconsEmptyStar,
      height: startSize,
      width: startSize,
    );
    final fullStar = ImageMultiType(
      url: Assets.iconsFullStar,
      height: startSize,
      width: startSize,
    );

    return RatingBar(
      ratingWidget: RatingWidget(full: fullStar, half: fullStar, empty: emptyStar),
      onRatingUpdate: onRatingUpdate,
      glow: false,
      initialRating: 1.0,
      allowHalfRating: false,
      itemPadding: EdgeInsets.symmetric(horizontal: 5.0.w),
      minRating: 1.0,
    );
  }
}
