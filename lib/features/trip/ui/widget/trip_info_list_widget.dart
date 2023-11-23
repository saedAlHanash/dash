import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/table_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/candidate_drivers_cubit/candidate_drivers_cubit.dart';
import '../../bloc/trip_debit_cubit/trip_debit_cubit.dart';
import '../../bloc/trip_status_cubit/trip_status_cubit.dart';
import '../../data/request/update_trip_request.dart';

class TripInfoListWidget extends StatefulWidget {
  const TripInfoListWidget({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  State<TripInfoListWidget> createState() => _TripInfoListWidgetState();
}

class _TripInfoListWidgetState extends State<TripInfoListWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: !isAgency ? 6 : 4, vsync: this);
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
            tabs: [
              const Tab(text: 'معلومات'),
              if (!isAgency) const Tab(text: 'السائق والزبون'),
              const Tab(text: 'التاريخ والوقت'),
              const Tab(text: 'المحصلة المالية'),
              const Tab(text: 'السائقين المرتبطين'),
              if (!isAgency) const Tab(text: 'عمليات'),
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
                if (!isAgency) _DriverInfo(trip: widget.trip),
                _TripDateInfo(trip: widget.trip),
                _TripCost(trip: widget.trip),
                const _TripDrivers(),
                if (!isAgency) _TripActions(trip: widget.trip),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemInfoInLine(title: 'الانطلاق', info: trip.sourceName),
        ItemInfoInLine(title: 'الوجهة', info: trip.destinationName),
        ItemInfoInLine(title: 'المسافة المقدرة', info: trip.estimatedDistance.toString()),
        ItemInfoInLine(title: 'المسافة الفعلية', info: trip.actualDistance.toString()),
        ItemInfoInLine(
            title: 'المسافة المقدرة التعويضية', info: trip.preAcceptDistance.toString()),
        ItemInfoInLine(title: 'ملاحظة التقييم', info: trip.reviewNote),
        ItemInfoInLine(title: 'ملاحظة الرحلة', info: trip.note),
        ItemInfoInLine(title: 'نوع الرحلة', info: trip.tripType.arabicName),
        ItemInfoInLine(title: 'حالة الرحلة', info: trip.tripStatus.arabicName),
        ItemInfoInLine(title: 'سبب الإلغاء', info: trip.cancelReasone),
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
      ],
    );
  }
}

class _DriverInfo extends StatelessWidget {
  const _DriverInfo({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          30.0.verticalSpace,
          MyTableWidget(
            children: {
              'ID': InkWell(
                onTap: () {
                  context.pushNamed(GoRouteName.clientInfo,
                      queryParams: {'id': trip.clientId.toString()});
                },
                child: DrawableText(
                  selectable: false,
                  size: 16.0.sp,
                  matchParent: true,
                  textAlign: TextAlign.center,
                  underLine: true,
                  text: trip.clientId.toString(),
                  color: Colors.blue,
                ),
              ),
              'اسم ': trip.client.fullName,
              'رقم هاتف': trip.client.phoneNumber,
            },
            title: 'معلومات الزبون',
          ),
          MyTableWidget(
            children: {
              'تصنيف ': trip.carCategory.name,
              'ماركة': trip.driver.carType.carBrand,
              'موديل  ': trip.driver.carType.carModel,
              'لون': trip.driver.carType.carColor,
              'رقم اللوحة': trip.driver.carType.carNumber,
              'عدد المقاعد': trip.driver.carType.seatsNumber.toString(),
              'محافظة السيارة': trip.driver.carType.carGovernorate,
              'الشركة الصانعة': trip.driver.carType.manufacturingYear,
              'النوع': trip.driver.carType.type,
            },
            title: 'معلومات السيارة',
          ),
        ],
      ),
    );
  }
}

class _TripDateInfo extends StatelessWidget {
  const _TripDateInfo({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SaedTableWidget(
        title: const ['معلومات التاريخ والوقت الخاص بالرحلة'],
        data: [
          [
            'الحجز',
            trip.reqestDate?.formatDateTime,
          ],
          [
            'القبول',
            trip.acceptDate?.formatDateTime,
          ],
          [
            'البدأ',
            trip.startDate?.formatDateTime,
          ],
          [
            'النهاية',
            trip.endDate?.formatDateTime,
          ],
          [
            'وقت الانتظار',
            '${trip.acceptDate?.difference(trip.reqestDate!).inMinutes.round()} دقيقة',
          ],
          [
            'الوقت الفعلي لوصول السائق',
            '${trip.startDate?.difference(trip.acceptDate!).inMinutes.round()} دقيقة',
          ],
          [
            'الوقت المقدر للرحلة',
            '${(trip.estimatedDuration ~/ 60)} دقيقة',
          ],
          [
            'الوقت الفعلي للرحلة',
            '${trip.endDate?.difference(trip.startDate!).inMinutes.round()} دقيقة',
          ],
        ],
      ),
    );
  }
}

class _TripCost extends StatelessWidget {
  const _TripCost({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTableWidget(
          children: {
            'الكلفة المقدرة': trip.estimatedCost.formatPrice,
            'الكلفة الفعلية': trip.actualCost.formatPrice,
            'الكلفة التعويضية': trip.driverCompensation.formatPrice,
            'هل تم دفع الرحلة؟': trip.isPaid ? 'تم الدفع' : 'لم يتم الدفع',
          },
          title: 'المحصلة المالية للرحلة',
        ),
        MyTableWidget(
          children: {
            'للزيت': trip.estimatedCost
                .getPercentage(trip.carCategory.normalOilRatio)
                .formatPrice,
            'للإطارات': trip.estimatedCost
                .getPercentage(trip.carCategory.normalTiresRatio)
                .formatPrice,
            'للمليون': trip.estimatedCost
                .getPercentage(trip.carCategory.normalGoldRatio)
                .formatPrice,
            'للبنزين': trip.estimatedCost
                .getPercentage(trip.carCategory.normalGasRatio)
                .formatPrice,
          },
          title: 'المحصلة المالية للولاء',
        ),
        if (trip.isDelved)
          BlocBuilder<TripDebitCubit, TripDebitInitial>(
            builder: (context, state) {
              if (state.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }
              return MyTableWidget(
                children: {
                  'للسائق': state.result.driverShare.formatPrice,
                  'للزيت': state.result.oilShare.formatPrice,
                  'للإطارات': state.result.tiresShare.formatPrice,
                  'للمليون': state.result.goldShare.formatPrice,
                  'للبنزين': state.result.gasShare.formatPrice,
                },
                title: 'محصلة السائق من العائدات',
              );
            },
          )
        else
          const MyTableWidget(
            children: {'': ''},
            title: 'تظهر حصة السائق  بعد انتهاء الرحلة',
          )
      ],
    );
  }
}

class _TripActions extends StatelessWidget {
  const _TripActions({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!(trip.isCanceled || trip.isDelved))
          BlocBuilder<ChangeTripStatusCubit, ChangeTripStatusInitial>(
            builder: (context, cState) {
              if (cState.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }
              if (isQareebAdmin) {
                return 0.0.verticalSpace;
              }
              return MyButton(
                width: 150.0.w,
                text: 'إلغاء الرحلة',
                color: Colors.black,
                textColor: Colors.white,
                onTap: () {
                  context.read<ChangeTripStatusCubit>().changeTripStatus(
                        context,
                        request: UpdateTripRequest(
                          tripId: trip.id,
                          status: TripStatus.canceledByAdmin,
                          note: 'From Admin ${AppSharedPreference.getEmail}',
                        ),
                      );
                },
              );
            },
          )
        else
          const DrawableText(text: 'لا توجد عمليات')
      ],
    );
  }
}

class _TripDrivers extends StatelessWidget {
  const _TripDrivers();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CandidateDriversCubit, CandidateDriversInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return SaedTableWidget(
            title: const [
              'معرف السائق',
              'اسم السائق',
              'نوع السيارة',
              'تاريخ',
              'حالة القبول',
              'حالة الرفض',
            ],
            data: state.result
                .mapIndexed((i, e) => [
                      InkWell(
                        onTap: () {
                          context.pushNamed(
                            GoRouteName.driverInfo,
                            queryParams: {'id': '${e.driverId}'},
                          );
                        },
                        child: DrawableText(
                          selectable: false,
                          size: 16.0.sp,
                          matchParent: true,
                          textAlign: TextAlign.center,
                          underLine: true,
                          text: '${e.driverId}',
                          color: Colors.blue,
                        ),
                      ),
                      e.driver.fullName,
                      e.driver.carType.carModel,
                      e.requestDate?.formatDateTime ?? '-',
                      !e.isAccepted ? '-' : e.isAccepted.toString(),
                      !e.isRejected ? '-' : e.isRejected.toString(),
                    ])
                .toList(),
          );
        },
      ),
    );
  }
}
