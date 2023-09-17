import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/shared_trip_info_list_widget.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../bloc/shared_trip_by_id_cubit/shared_trip_by_id_cubit.dart';
import '../../bloc/update_shared_cubit/update_shared_cubit.dart';

class SharedTripInfoPage extends StatefulWidget {
  const SharedTripInfoPage({Key? key}) : super(key: key);

  @override
  State<SharedTripInfoPage> createState() => _SharedTripInfoPageState();
}

class _SharedTripInfoPageState extends State<SharedTripInfoPage> {
  late final MapControllerCubit mapController;

  @override
  void initState() {
    mapController = context.read<MapControllerCubit>();
    super.initState();
  }

  @override
  void dispose() {
    MapWidget.initImeis([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SharedTripByIdCubit, SharedTripByIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            mapController.addPath(path: state.result.path);
            if (state.result.tripStatus == SharedTripStatus.started) {
              MapWidget.initImeis([state.result.driver.imei]);
            }
          },
        ),
        BlocListener<UpdateSharedCubit, UpdateSharedInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<SharedTripByIdCubit>().getSharedTripById(
                  context,
                  id: state.result.id,
                  requestId: 0,
                );
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).r,
                child: BlocBuilder<SharedTripByIdCubit, SharedTripByIdInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawableText(
                          text: 'تفاصيل الطلب',
                          matchParent: true,
                          selectable: false,
                          fontFamily: FontManager.cairoBold,
                          textAlign: TextAlign.center,
                          color: Colors.black,
                          drawableEnd: (state.result.tripStatus ==
                                      SharedTripStatus.closed ||
                                  state.result.tripStatus == SharedTripStatus.canceled)
                              ? null
                              : BlocBuilder<UpdateSharedCubit, UpdateSharedInitial>(
                                  builder: (context, cState) {
                                    if (cState.statuses.loading) {
                                      return MyStyle.loadingWidget();
                                    }
                                    return MyButton(
                                      width: 100.0.w,
                                      text: 'إلغاء الرحلة',
                                      color: Colors.black,
                                      textColor: Colors.white,
                                      onTap: () {
                                        context
                                            .read<UpdateSharedCubit>()
                                            .updateSharedTrip(
                                              context,
                                              trip: state.result,
                                              tState: SharedTripStatus.canceled,
                                            );
                                      },
                                    );
                                  },
                                ),
                        ),
                        TripInfoListWidget(trip: state.result),
                      ],
                    );
                  },
                ),
              ),
            ),
            20.0.horizontalSpace,
            const Expanded(
              child: MapWidget(),
            ),
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
