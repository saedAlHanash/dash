import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../map/ui/widget/map_widget.dart';
import '../../bloc/trip_by_id/trip_by_id_cubit.dart';
import '../widget/trip_info_list_widget.dart';

class TripInfoPage extends StatefulWidget {
  const TripInfoPage({Key? key}) : super(key: key);

  @override
  State<TripInfoPage> createState() => _TripInfoPageState();
}

class _TripInfoPageState extends State<TripInfoPage> {
  late final MapControllerCubit mapController;

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripByIdCubit, TripByIdInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        mapController.addTrip(trip: state.result);
      },
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
                child: BlocBuilder<TripByIdCubit, TripByIdInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DrawableText(
                          text: 'تفاصيل الطلب',
                          matchParent: true,
                          fontFamily: FontManager.cairoBold,
                          textAlign: TextAlign.center,
                          color: Colors.black,
                          drawableEnd:
                              (!state.result.isCanceled && !state.result.isDelved)
                                  ? MyButton(
                                      width: 100.0.w,
                                      text: 'إنهاء الرحلة',
                                      color: Colors.black,
                                      textColor: Colors.white,
                                      onTap: () {},
                                    )
                                  : null,
                        ),
                        20.0.verticalSpace,
                        TripInfoListWidget(trip: state.result),
                      ],
                    );
                  },
                ),
              ),
            ),
            20.0.horizontalSpace,
            const Expanded(child: MapWidget()),
          ],
        ),
      ),
    );
  }
}

// DrawableText(
//   text: 'رحلة جارية',
//
//   color: Colors.black,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'الانطلاق: ',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.currentLocationName,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'الوجهة: ',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.destinationName,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// 40.0.verticalSpace,
// const DrawableText(
//   text: 'السائق',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.driverName,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'نوع السيارة',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.carType.carBrand,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'رقم السيارة',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.carType.carNumber,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.gray,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'رقم الهاتف',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.clientPhoneNumber,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.mainColor,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
// const DrawableText(
//   text: 'التكلفة',
//   color: Colors.black,
// ),
// DrawableText(
//   text: trip.getCost,
//
//   fontFamily: FontManager.cairoBold,
//   color: AppColorManager.mainColor,
//   padding: const EdgeInsets.only(right: 10.0, bottom: 20.0, top: 5.0).r,
// ),
