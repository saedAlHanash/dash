import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../bloc/home_cubit/home_cubit/home_cubit.dart';

class StatisticsCard extends StatelessWidget {
  final dynamic icon;
  final String label;
  final dynamic value;
  final Color? color;

  const StatisticsCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        color: AppColorManager.cardColor,
        // border: Border.all(
        //   color: AppColorManager.mainColor,
        //   width: 1.0.w,
        // ),
      ),
      margin: const EdgeInsets.all(20.0).r,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ImageMultiType(
            url: icon,
            height: 60.0.r,
            color: color,
          ),
          8.0.verticalSpace,
          DrawableText(
            text: label,
            size: 20.0.sp,
          ),
          Divider(),
          DrawableText(
            text: (value is num)
                ? value.toString()
                : (value is String)
                    ? value
                    : '-',
            fontFamily: FontManager.cairoBold,
            size: 24.0.sp,
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final Map<String, dynamic> statistics;

  const DashboardScreen({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeInitial>(
      builder: (context, state) {
        if (state.statuses.isLoading) {
          return MyStyle.loadingWidget();
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyGridWidget(
            columnCount: 5,
            children: [
              if (!isAgency)
                StatisticsCard(
                  icon: Assets.iconsUsers,
                  label: 'عدد الزبائن',
                  value: state.result.statistics.clients,
                ),
              StatisticsCard(
                icon: Assets.iconsDriver,
                label: 'عدد السائقين',
                value: state.result.statistics.drivers,
              ),
              StatisticsCard(
                icon: Assets.iconsTrips,
                label: 'الرحلات العادية',
                value: state.result.statistics.trips,
              ),
              StatisticsCard(
                icon: Assets.iconsSharedTrip,
                label: 'الرحلات التشاركية',
                value: state.result.statistics.sharedTrips,
              ),
              StatisticsCard(
                icon: Assets.iconsLocator,
                label: 'السائقين المتاحين',
                value: state.result.statistics.activeDrivers,
              ),
              if (!isAgency)
                StatisticsCard(
                  icon: Icons.business,
                  label: 'المؤسسات',
                  value: state.result.statistics.institutions,
                ),
              if (!isAgency)
                StatisticsCard(
                  icon: Icons.store,
                  label: 'الوكلاء',
                  value: state.result.statistics.agencies,
                ),
              StatisticsCard(
                icon: Icons.attach_money,
                color: AppColorManager.mainColorDark,
                label: isAgency ? 'رصيدي الحالي' : 'اجمالي الدخل',
                value: (state.result.statistics.incoms).formatPrice,
              ),
              if (!isAgency)
                StatisticsCard(
                  icon: Icons.star,
                  color: Colors.amber,
                  label: 'إجمالي المكافئات',
                  value: (state.result.statistics.awards).formatPrice,
                ),
            ],
          ),
        );
      },
    );
  }
}

final statistics = {
  "clients": 26,
  "drivers": 8,
  "trips": 69,
  "sharedTrips": 8,
  "activeDrivers": 3,
  "institutions": 3,
  "agencies": 3,
  "incomes": 149450,
  "awards": 75000,
};

class MyGridWidget extends StatefulWidget {
  const MyGridWidget({super.key, required this.children, this.columnCount = 3});

  final List<Widget> children;
  final int columnCount;

  @override
  State<MyGridWidget> createState() => _MyGridWidgetState();
}

class _MyGridWidgetState extends State<MyGridWidget> {
  late List<List<Widget>> widgets = [];

  @override
  void initState() {
    widgets = groupingList<Widget>(
      widget.columnCount,
      widget.children,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widgets.map(
        (e) {
          late final Widget row;
          row = Row(
            children: e
                .map(
                  (e) => Expanded(
                    child: e,
                  ),
                )
                .toList(),
          );

          return row;
        },
      ).toList()
        ..add(const Divider()),
    );
  }
}
