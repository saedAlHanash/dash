import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/strings/app_string_manager.dart';
import 'package:qareeb_dash/core/widgets/top_title_widget.dart';
import 'package:qareeb_dash/features/previous_trips/ui/widget/item_previous_trips.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/api_manager/command.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/load_more_widget.dart';
import '../../bloc/previous_trip/previous_trips_cubit.dart';

class PreviousTripsPage extends StatelessWidget {
  const PreviousTripsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Column(
        children: [
          const TopTitleWidget(
            text: 'رحلاتي',
            icon: Assets.iconsHistory,
          ),
          10.0.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<PreviousTripsCubit, PreviousTripsInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) return MyStyle.loadingWidget();

                  final list = state.result;

                  if (list.isEmpty) {
                    return Column(
                      children: [
                        LottieBuilder.asset(Assets.lottiesError),
                        const DrawableText(
                          text: AppStringManager.noResult,
                           
                          color: AppColorManager.black,
                        )
                      ],
                    );
                  }

                  return LoadMoreWidget(
                    length: list.length,
                    onNewCommand: (command) {},
                    totalCount: list.length,
                    command: Command.initial(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (_, i) => ItemPreviousTrip(trip: list[i]),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
