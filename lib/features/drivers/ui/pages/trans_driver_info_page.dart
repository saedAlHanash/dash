import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/redeems/ui/widget/loyalty_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../wallet/ui/pages/debts_page.dart';
import '../../bloc/driver_by_id_cubit/driver_by_id_cubit.dart';
import '../widget/driver_financial_widget.dart';
import '../widget/driver_status_history.dart';
import '../widget/driver_trips_card.dart';

class TransDriverInfoPage extends StatefulWidget {
  const TransDriverInfoPage({super.key});

  @override
  State<TransDriverInfoPage> createState() => _DriverInfoPageState();
}

class _DriverInfoPageState extends State<TransDriverInfoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: !isAgency ? 6 : 5, vsync: this);
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
            children: [
              _DriverImages(driver: driver),
              30.0.verticalSpace,
              _DriverTableInfo(driver: driver),
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
          ItemImage(image: driver.examination, text: 'فحص السيارة'),
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
              'حالة الفحص': driver.isExamined ? 'تم' : 'غير مفحوصة',
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
  const ItemImage({required this.image, required this.text});

  final String image;

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
