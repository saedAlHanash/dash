import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import 'package:image_multi_type/round_image_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../../accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';
import '../../../wallet/ui/pages/debts_page.dart';
import '../../bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import '../widget/driver_financial_widget.dart';

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
              const Expanded(
                child: DrawableText(
                  text: 'الرحلات العادية',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold,
                  matchParent: true,
                ),
              ),
              Expanded(
                child: DrawableText(
                  text: 'المرفوضة : ${driver.receivedTripsCount}',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold,
                ),
              ),
              Expanded(
                child: DrawableText(
                  text: 'الرحلات المرسلة  : ${driver.receivedTripsCount}',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold,
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
              const Expanded(
                child: DrawableText(
                  text: 'الرحلات التشاركية',
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold,
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