import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';

import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';

import '../../bloc/all_bus_trips_cubit/all_bus_trips_cubit.dart';
import '../../bloc/delete_bus_trip_cubit/delete_bus_trip_cubit.dart';
import '../widget/trips_filter_widget.dart';

final _super_userList = [
  'ID',
  'نوع',
  'اسم',
  'وصف',
  'عدد باصات الرحلة',
  'تاريخ الرحلة',
  'وقت الرحلة',
  'عدد اشتراكات الطلاب',
  'حالة الرحلة الآن',
  if (isAllowed(AppPermissions.busTrips)) 'عمليات',
];

class BusTripsPage extends StatefulWidget {
  const BusTripsPage({super.key});

  @override
  State<BusTripsPage> createState() => _BusTripsPageState();
}

class _BusTripsPageState extends State<BusTripsPage> with SingleTickerProviderStateMixin {
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
      floatingActionButton: isAllowed(AppPermissions.busTrips)
          ? StatefulBuilder(builder: (context, mState) {
              return FloatingActionBubble(
                // Menu items
                items: [
                  Bubble(
                    title: "إنشاء رحلة نقاط تجمع",
                    iconColor: Colors.white,
                    bubbleColor: AppColorManager.mainColor,
                    icon: Icons.location_pin,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      context.pushNamed(
                        GoRouteName.createBusTrip,
                        queryParams: {
                          't_index': BusTripCategory.qareebPoints.index.toString()
                        },
                      );
                      _animationController.reverse();
                    },
                  ),
                  Bubble(
                    title: "إنشاء رحلة منازل طلاب",
                    iconColor: Colors.white,
                    bubbleColor: AppColorManager.mainColor,
                    icon: Icons.location_history,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      context.pushNamed(
                        GoRouteName.createBusTrip,
                        queryParams: {
                          't_index': BusTripCategory.customPoints.index.toString()
                        },
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
                      context.read<AllBusTripsCubit>().getBusAsync(context).then(
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
            })
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100.0).h,
        child: Column(
          children: [
            BlocBuilder<AllBusTripsCubit, AllBusTripsInitial>(
              builder: (context, state) {
                return TripsFilterWidget(
                  command: state.command,
                  onApply: (request) {
                    context.read<AllBusTripsCubit>().getBusTrips(
                          context,
                          command:
                              context.read<AllBusTripsCubit>().state.command.copyWith(
                                    tripsFilterRequest: request,
                                    skipCount: 0,
                                    totalCount: 0,
                                  ),
                        );
                  },
                );
              },
            ),
            BlocBuilder<AllBusTripsCubit, AllBusTripsInitial>(
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
                        e.category.index == 0 ? 'نقاط تجمع' : 'منازل طلاب',
                        e.name,
                        e.description,
                        e.buses.length.toString(),
                        '${e.startDate?.formatDate} \n\n ${e.endDate?.formatDate}',
                        '${e.startDate?.formatTime} \n\n ${e.endDate?.formatTime}',
                        e.numberOfParticipation.toString(),
                        e.isActive ? 'جارية' : 'مؤجلة',
                        if (isAllowed(AppPermissions.busTrips))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: !isAllowed(AppPermissions.busTrips)
                                    ? null
                                    : () {
                                        context.pushNamed(
                                          GoRouteName.createBusTrip,
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
                                child: BlocConsumer<DeleteBusTripCubit,
                                    DeleteBusTripInitial>(
                                  listener: (context, state) {
                                    context.read<AllBusTripsCubit>().getBusTrips(context);
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
                                            .read<DeleteBusTripCubit>()
                                            .deleteBusTrip(context, id: e.id);
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
                        .read<AllBusTripsCubit>()
                        .getBusTrips(context, command: command);
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
