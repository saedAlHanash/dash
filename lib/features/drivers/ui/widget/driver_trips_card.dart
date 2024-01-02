import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';

import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../router/go_route_pages.dart';

class DriverTripsCard extends StatelessWidget {
  const DriverTripsCard({super.key, required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCardWidget(
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
          child: Row(
            children: [
               Expanded(
                child: DrawableText(
                  text: 'الرحلات العادية',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold.name,
                  matchParent: true,
                ),
              ),
              Expanded(
                child: DrawableText(
                  text: 'المرفوضة : ${driver.rejectedTripsCount}',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold.name,
                ),
              ),
              Expanded(
                child: DrawableText(
                  text: 'الرحلات المرسلة  : ${driver.receivedTripsCount}',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold.name,
                ),
              ),
              MyButton(
                text: 'تفاصيل',
                width: 100.0.w,
                onTap: () {
                  context.pushNamed(
                    GoRouteName.tripsPae,
                    queryParams: {
                      'driverId': driver.id.toString(),
                      // 'driverName': driver.fullName,
                    },
                  );
                },
              ),
            ],
          ),
        ),
        MyCardWidget(
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
          child: Row(
            children: [
               Expanded(
                child: DrawableText(
                  text: 'الرحلات التشاركية',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold.name,
                  matchParent: true,
                ),
              ),
              const Spacer(),
              MyButton(
                text: 'تفاصيل',
                width: 100.0.w,
                onTap: () {
                  context.pushNamed(
                    GoRouteName.sharedTripsPae,
                    queryParams: {
                      'driverId': driver.id.toString(),
                      // 'driverName': driver.fullName,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
