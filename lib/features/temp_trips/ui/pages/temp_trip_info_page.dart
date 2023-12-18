import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_package/map/bloc/map_controller_cubit/map_controller_cubit.dart';
import 'package:map_package/map/ui/widget/map_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/features/temp_trips/data/request/estimate_request.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../shared_trip/ui/widget/path_points_widget.dart';
import '../../bloc/estimate_cubit/estimate_cubit.dart';
import '../../bloc/temp_trip_by_id_cubit/temp_trip_by_id_cubit.dart';

class TempTripInfoPage extends StatefulWidget {
  const TempTripInfoPage({super.key});

  @override
  State<TempTripInfoPage> createState() => _CreateTempTripPageState();
}

class _CreateTempTripPageState extends State<TempTripInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TempTripBuIdCubit, TempTripBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<MapControllerCubit>().addPath(path: state.result);
            context.read<EstimateCubit>().getEstimate(
                  context,
                  request: EstimateRequest(
                      pathEdgesIds: state.result.edges.map((e) => e.id).toList()),
                );
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'نماذج الرحلات',
        ),
        body: BlocBuilder<TempTripBuIdCubit, TempTripBuIdInitial>(
            builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return SizedBox(
            width: 1.0.sw,
            child: Column(
              children: [
                ItemInfoInLine(title: 'اسم النموذج', info: state.result.arName),
                ItemInfoInLine(
                  title: 'النقاط',
                  widget: PathPointsWidgetWrap(
                    list: state.result.getTripPoints,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            BlocBuilder<EstimateCubit, EstimateInitial>(
                              builder: (context, mState) {
                                if (mState.statuses.loading) {
                                  return MyStyle.loadingWidget();
                                }
                                return SaedTableWidget(
                                  title: const [
                                    'اسم التصنيف',
                                    'السعر الأدنى',
                                    'السعر الوسطي',
                                    'السعر الأعلى',
                                    'المسافة',
                                  ],
                                  data: mState.result
                                      .map(
                                        (e) => [
                                          e.carCategoryName,
                                          (e.carCategorySeats * e.prices[0]).formatPrice,
                                          (e.carCategorySeats * e.prices[1]).formatPrice,
                                          (e.carCategorySeats * e.prices[2]).formatPrice,
                                          '${(state.result.distance / 1000).round()} km'
                                        ],
                                      )
                                      .toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: MapWidget( ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
