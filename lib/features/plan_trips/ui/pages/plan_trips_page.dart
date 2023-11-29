import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';

import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';

import '../../bloc/all_plan_trips_cubit/all_plan_trips_cubit.dart';
import '../../bloc/delete_plan_trip_cubit/delete_plan_trip_cubit.dart';
import '../widget/trips_filter_widget.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

final _super_userList = [
  'ID',
  'معرف المسار',
  'اسم الشركة',
  'اسم المسار',
  'عدد سائقي الرحلة',
  'تاريخ الرحلة',
  'وقت الرحلة',
  'عمليات',
];

class PlanTripsPage extends StatefulWidget {
  const PlanTripsPage({super.key});

  @override
  State<PlanTripsPage> createState() => _PlanTripsPageState();
}

class _PlanTripsPageState extends State<PlanTripsPage>
    with SingleTickerProviderStateMixin {
  var loading = false;
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(builder: (context, mState) {
        return FloatingActionBubble(
          // Menu items
          items: [
            Bubble(
              title: "إنشاء رحلة",
              iconColor: Colors.white,
              bubbleColor: AppColorManager.mainColor,
              icon: Icons.location_pin,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                context.pushNamed(
                  GoRouteName.createPlanTrip,
                );
                _animationController.reverse();
              },
            ),
            // Floating action menu item
            Bubble(
              title: loading ? 'جاري التحميل...' : "تحميل ملف إكسل",
              iconColor: Colors.white,
              bubbleColor: AppColorManager.mainColor,
              icon: Icons.file_copy_rounded,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                mState(() => loading = true);
                context.read<AllPlanTripsCubit>().getPlanAsync(context).then(
                  (value) {
                    mState(() => loading = false);
                    _animationController.reverse();
                    if (value == null) return;
                    saveXls(
                      header: value.first,
                      data: value.second,
                      fileName: 'تقرير الرحلات ${DateTime.now().formatDate}',
                    );
                  },
                );
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: AppColorManager.whit,

          // Flaoting Action button Icon
          iconData: Icons.settings,
          backGroundColor: AppColorManager.mainColor,
        );
      }),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100.0).h,
        child: Column(
          children: [
            BlocBuilder<AllPlanTripsCubit, AllPlanTripsInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;

                if (list.isEmpty) return const NotFoundWidget(text: 'يرجى إضافة رحلات');
                return SaedTableWidget(
                  command: state.command,
                  title: _super_userList,
                  data: list.mapIndexed(
                    (i, e) {
                      return [
                        e.id.toString(),
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              GoRouteName.companyPathInfo,
                              queryParams: {'id': '${e.companyPathId}'},
                            );
                          },
                          child: DrawableText(
                            selectable: false,
                            size: 16.0.sp,
                            matchParent: true,
                            textAlign: TextAlign.center,
                            underLine: true,
                            text: '${e.companyPathId}',
                            color: Colors.blue,
                          ),
                        ),
                        e.company.name,
                        e.name,
                        e.drivers.length.toString(),
                        '${e.startDate?.formatDate} \n\n ${e.endDate?.formatDate}',
                        '${e.startDate?.formatTime} \n\n ${e.endDate?.formatTime}',
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                context.pushNamed(
                                  GoRouteName.createPlanTrip,
                                  queryParams: {'id': e.id.toString()},
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.amber,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocConsumer<DeletePlanTripCubit,
                                  DeletePlanTripInitial>(
                                listener: (context, state) {
                                  context.read<AllPlanTripsCubit>().getPlanTrips(context);
                                },
                                listenWhen: (p, c) => c.statuses.done,
                                buildWhen: (p, c) => c.id == e.id,
                                builder: (context, state) {
                                  if (state.statuses.loading) {
                                    return MyStyle.loadingWidget();
                                  }
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<DeletePlanTripCubit>()
                                          .deletePlanTrip(context, id: e.id);
                                    },
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ];
                    },
                  ).toList(),
                  onChangePage: (command) {
                    context
                        .read<AllPlanTripsCubit>()
                        .getPlanTrips(context, command: command);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
