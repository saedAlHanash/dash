import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/table_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/trip_by_id/trip_by_id_cubit.dart';
import '../../bloc/trip_status_cubit/trip_status_cubit.dart';
import '../widget/trip_info_list_widget.dart';
import 'package:drawable_text/drawable_text.dart';

class TransTripInfoPage extends StatefulWidget {
  const TransTripInfoPage({Key? key}) : super(key: key);

  @override
  State<TransTripInfoPage> createState() => _TransTripInfoPageState();
}

class _TransTripInfoPageState extends State<TransTripInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: BlocBuilder<TripByIdCubit, TripByIdInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return TransTripInfoListWidget(trip: state.result);
        },
      ),
    );
  }
}

class TransTripInfoListWidget extends StatefulWidget {
  const TransTripInfoListWidget({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  State<TransTripInfoListWidget> createState() => _TransTripInfoListWidgetState();
}

class _TransTripInfoListWidgetState extends State<TransTripInfoListWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 42.h,
          width: 1.0.sw,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0).r,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColorManager.mainColorDark,
            labelStyle: TextStyle(fontSize: 18.0.sp, color: Colors.black),
            unselectedLabelColor: AppColorManager.black,
            tabs: const [
              Tab(text: 'معلومات'),
              Tab(text: 'التاريخ والوقت'),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0).w,
            child: TabBarView(
              controller: _tabController,
              children: [
                _TripInfo(trip: widget.trip),
                TripDateInfo(trip: widget.trip),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TripInfo extends StatelessWidget {
  const _TripInfo({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemInfoInLine(title: 'الانطلاق', info: trip.sourceName),
          ItemInfoInLine(title: 'الوجهة', info: trip.destinationName),
          ItemInfoInLine(
              title: 'المسافة المقدرة', info: trip.estimatedDistance.toString()),
          ItemInfoInLine(title: 'المسافة الفعلية', info: trip.actualDistance.toString()),
          ItemInfoInLine(
              title: 'المسافة المقدرة التعويضية',
              info: trip.preAcceptDistance.toString()),
          ItemInfoInLine(title: 'ملاحظة التقييم', info: trip.reviewNote),
          ItemInfoInLine(title: 'ملاحظة الرحلة', info: trip.note),
          ItemInfoInLine(title: 'نوع الرحلة', info: trip.tripType.arabicName),
          ItemInfoInLine(title: 'حالة الرحلة', info: trip.tripStatus.arabicName),
          ItemInfoInLine(title: 'سبب الإلغاء', info: trip.cancelReasone),
          ItemInfoInLine(title: 'كلفة الرحلة', info: trip.estimatedCost.formatPrice),
          ItemInfoInLine(
            title: 'تقيم الرحلة',
            widget: RatingBarIndicator(
              itemCount: 5,
              rating: trip.tripRate,
              itemSize: 50.0.r,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 50.0.r,
              ),
            ),
          ),
          MyTableWidget(
            children: {
              'ID': InkWell(
                onTap: () {
                  context.pushNamed(GoRouteName.driverInfo,
                      queryParams: {'id': trip.driverId.toString()});
                },
                child: DrawableText(
                  selectable: false,
                  size: 16.0.sp,
                  matchParent: true,
                  textAlign: TextAlign.center,
                  underLine: true,
                  text: trip.driverId.toString(),
                  color: Colors.blue,
                ),
              ),
              'IMEI': trip.driver.imei,
              'اسم ': trip.driver.fullName,
              'رقم هاتف  ': trip.driver.phoneNumber,
            },
            title: 'معلومات السائق',
          ),
        ],
      ),
    );
  }
}
