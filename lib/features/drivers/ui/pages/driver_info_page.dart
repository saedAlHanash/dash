import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/images/round_image_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../../accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';
import '../../../wallet/ui/pages/debts_page.dart';
import '../../bloc/driver_by_id_cubit/driver_by_id_cubit.dart';

class DriverInfoPage extends StatefulWidget {
  const DriverInfoPage({super.key});

  @override
  State<DriverInfoPage> createState() => _DriverInfoPageState();
}

class _DriverInfoPageState extends State<DriverInfoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'معلومات السائق',
      ),
      body: BlocBuilder<DriverBuIdCubit, DriverBuIdInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final driver = state.result;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 42.h,
                margin: const EdgeInsets.symmetric(horizontal: 128.0, vertical: 50.0).r,
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppColorManager.mainColorDark,
                  unselectedLabelColor: AppColorManager.mainColor,
                  tabs: const [
                    Tab(text: 'معلومات السائق'),
                    Tab(text: 'الولاء'),
                    Tab(text: 'الرحلات'),
                    Tab(text: 'المحصلة المالية'),
                    Tab(text: 'عائدات الرحلات'),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0).w,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          _DriverImages(driver: driver),
                          30.0.verticalSpace,
                          _DriverTableInfo(driver: driver),
                        ],
                      ),
                      const LoyaltyWidget(),
                      _DriverTripsCard(driver: driver),
                      const _DriverFinancialWidget(),
                      const DebtsPage(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DriverImages extends StatelessWidget {
  const _DriverImages({required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemImage(image: driver.avatar, text: 'الصورة الشخصية'),
          ItemImage(image: driver.identity, text: 'صورة الهوية'),
          ItemImage(image: driver.contract, text: 'صورة العقد'),
          ItemImage(image: driver.drivingLicence, text: 'رخصة القيادة'),
          ItemImage(image: driver.carMechanic, text: 'ميكانيك السيارة'),
        ],
      ),
    );
  }
}

class _DriverTableInfo extends StatelessWidget {
  const _DriverTableInfo({required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: MyTableWidget(
            children: {
              'تصنيف ': driver.carCategories.name,
              'رقم  ': driver.carType.carNumber,
              'الشركة الصانعة': driver.carType.carBrand,
              'لون': driver.carType.carColor,
              'IMEI': driver.qarebDeviceimei,
            },
            title: 'معلومات السيارة',
          ),
        ),
        Expanded(
          child: MyTableWidget(
            children: {
              'اسم ': driver.fullName,
              'العنوان ': driver.address,
              'رقم هاتف  ': driver.phoneNumber,
              'تاريخ ميلاد': driver.birthdate?.formatDate ?? '-',
              'الجنس': driver.gender == 0 ? 'ذكر' : 'أنثى',
            },
            title: 'معلومات السائق',
          ),
        ),
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.image, required this.text, this.fileBytes});

  final String image;
  final Uint8List? fileBytes;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
      child: InkWell(
        onTap: () {
          NoteMessage.showImageDialog(context, image: image);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundImageWidget(
              url: image,
              fileBytes: fileBytes,
              height: 155.0.r,
              width: 155.0.r,
            ),
            8.0.verticalSpace,
            DrawableText(text: text),
          ],
        ),
      ),
    );
  }
}

class _DriverTripsCard extends StatelessWidget {
  const _DriverTripsCard({required this.driver});

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

class _DriverFinancialWidget extends StatelessWidget {
  const _DriverFinancialWidget();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReverseChargingCubit, ReverseChargingInitial>(
      listenWhen: (p, c) => c.statuses.isDone,
      listener: (context, state) {
        context.read<DriverFinancialCubit>().getDriverFinancial(context);
      },
      child: BlocBuilder<DriverFinancialCubit, DriverFinancialInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                MyCardWidget(
                  elevation: 0.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                  child: Row(
                    children: [
                      ImageMultiType(
                        url: Assets.iconsDriver,
                        width: 55.0.r,
                        height: 55.0.r,
                      ),
                      15.0.horizontalSpace,
                      const DrawableText(
                        text: 'رصيد السائق لدى الشركة',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                      const Spacer(),
                      DrawableText(
                        text: state.result.requiredAmountFromCompany.formatPrice,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
                MyCardWidget(
                  elevation: 0.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                  child: Row(
                    children: [
                      ImageMultiType(
                        url: Assets.iconsQareebPoint,
                        width: 55.0.r,
                        height: 55.0.r,
                      ),
                      15.0.horizontalSpace,
                      const DrawableText(
                        text: 'رصيد الشركة لدى السائق',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                      const Spacer(),
                      DrawableText(
                        text: state.result.requiredAmountFromDriver.formatPrice,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
                MyCardWidget(
                  elevation: 0.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                  child: Row(
                    children: [
                      ImageMultiType(
                        url: Assets.iconsCashSummary,
                        width: 55.0.r,
                        height: 55.0.r,
                      ),
                      15.0.horizontalSpace,
                      DrawableText(
                        text: state.getMessage,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                      const Spacer(),
                      DrawableText(
                        text: state.price.formatPrice,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
                MyCardWidget(
                  elevation: 0.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                  child: Row(
                    children: [
                      DrawableText(
                        text: 'آخر شحنة من السائق للشركة',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                        drawablePadding: 30.0.h,
                        drawableEnd: DrawableText(
                          text: state.result.lastTransferFromDriver.transferDate
                                  ?.formatDuration(getServerDate) ??
                              '',
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      DrawableText(
                        text: state.result.lastTransferFromDriver.amount.formatPrice,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
                MyCardWidget(
                  elevation: 0.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                  child: Row(
                    children: [
                      DrawableText(
                        text: 'آخر شحنة من الشركة للسائق',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                        drawablePadding: 30.0.h,
                        drawableEnd: DrawableText(
                          text: state.result.lastTransferFromDriver.transferDate
                                  ?.formatDuration(getServerDate) ??
                              '',
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      DrawableText(
                        text: state
                            .result.lastTransferFromCompanyToDriver.amount.formatPrice,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SaedTableWidget(
                  filters: const DrawableText(
                    text: 'شحنات السائق',
                  ),
                  title: const [
                    'المرسل',
                    'المستقبل',
                    'القيمة',
                    'الحالة',
                    'التاريخ',
                    'عمليات',
                  ],
                  data: state.result.charging.mapIndexed((i, e) {
                    return [
                      e.chargerName.isEmpty ? e.providerName : e.chargerName,
                      e.userName,
                      e.amount.formatPrice,
                      e.status.arabicName,
                      e.date?.formatDate,
                      BlocBuilder<ReverseChargingCubit, ReverseChargingInitial>(
                        builder: (context, state) {
                          if (state.statuses.isLoading) {
                            return MyStyle.loadingWidget();
                          }
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<ReverseChargingCubit>()
                                  .payTo(context, processId: e.processId);
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: AppColorManager.red,
                            ),
                          );
                        },
                        buildWhen: (p, c) => c.processId == e.processId,
                      ),
                    ];
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
