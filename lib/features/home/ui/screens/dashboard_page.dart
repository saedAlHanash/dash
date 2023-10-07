import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/util/my_style.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            16.0.verticalSpace,
            if (AppSharedPreference.getUser.roleName.toLowerCase() == 'admin')
              const LoyaltyWidget(),
            FutureBuilder(
              future: getBestDriver(),
              builder: (context, snapShot) {
                if (!snapShot.hasData) return MyStyle.loadingWidget();

                final bestDriver = snapShot.data! as BestDriver;
                if (bestDriver.driverId == 0) return 0.0.verticalSpace;
                return Column(
                  children: [
                    30.0.verticalSpace,
                    DrawableText(
                      text: 'أفضل سائق',
                      matchParent: true,
                      size: 28.0.sp,
                      textAlign: TextAlign.center,
                      padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                    ),
                    MyCardWidget(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                      child: Row(
                        children: [
                          Expanded(
                            child: DrawableText(
                              text: 'اسم السائق: ${bestDriver.driverName}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          Expanded(
                            child: DrawableText(
                              text: 'عدد الرحلات: ${bestDriver.tripsCount}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          Expanded(
                            child: DrawableText(
                              text:
                                  'عدد الرحلات التشاركية: ${bestDriver.sharedTripsCount}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          Expanded(
                            child: DrawableText(
                              text:
                                  'الكيلومترات: ${(bestDriver.totalMeters / 1000).round()}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.pushNamed(GoRouteName.driverInfo,
                                    queryParams: {'id': bestDriver.driverId.toString()});
                              },
                              icon: const Icon(Icons.info_outline_rounded))
                        ],
                      ),
                    ),
                    30.0.verticalSpace,
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<BestDriver> getBestDriver() async {
  final result = await APIService().getApi(url: GetUrl.bestDriver);

  if (result.statusCode == 200) {
    return BestDriverResponse.fromJson(result.json).result;
  }

  return BestDriver.fromJson({});
}

class BestDriverResponse {
  BestDriverResponse({
    required this.result,
  });

  final BestDriver result;

  factory BestDriverResponse.fromJson(Map<String, dynamic> json) {
    return BestDriverResponse(
      result: BestDriver.fromJson(json["result"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class BestDriver {
  BestDriver({
    required this.driverId,
    required this.driverName,
    required this.tripsCount,
    required this.sharedTripsCount,
    required this.totalMeters,
  });

  final num driverId;
  final String driverName;
  final num tripsCount;
  final num sharedTripsCount;
  final num totalMeters;

  factory BestDriver.fromJson(Map<String, dynamic> json) {
    return BestDriver(
      driverId: json["driverId"] ?? 0,
      driverName: json["driverName"] ?? "",
      tripsCount: json["tripsCount"] ?? 0,
      sharedTripsCount: json["sharedTripsCount"] ?? 0,
      totalMeters: json["totalMeters"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "driverName": driverName,
        "tripsCount": tripsCount,
        "sharedTripsCount": sharedTripsCount,
        "totalMeters": totalMeters,
      };
}
