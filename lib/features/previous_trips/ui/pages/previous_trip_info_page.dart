import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../trip/ui/widget/trip_info_list_widget.dart';


class PreviousTripInfoPage extends StatelessWidget {
  const PreviousTripInfoPage({Key? key, required this.trip}) : super(key: key);

  final TripResult trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawableText(
              text: 'تفاصيل الطلب',
              matchParent: true,
              selectable: false,
              fontFamily: FontManager.cairoBold,

              color: Colors.black,
            ),
            20.0.verticalSpace,
            TripInfoListWidget(trip: trip),
            30.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
