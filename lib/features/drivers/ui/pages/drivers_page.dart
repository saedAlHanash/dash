import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:map_package/map/bloc/ather_cubit/ather_cubit.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/change_user_state_btn.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_drivers/all_drivers_cubit.dart';
import '../widget/drivers_filter_widget.dart';
import '../widget/trans_drivers_filter_widget.dart';

final clientTableHeader = [
  if (!isTrans) "حالة المحرك",
  "id",
  "اسم السائق",
  "رقم الهاتف",
  if (!isTrans) "حالة السائق",
  "IMEI",
  if (!isTrans) "آخر ظهور",
  if (isQareebAdmin) ...[
    "الولاء",
    "OTP",
  ],
  "العمليات",
];

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AtherCubit>()),
      ],
      child: BlocListener<AllDriversCubit, AllDriversInitial>(
        listenWhen: (p, c) => c.statuses.isDone,
        listener: (context, state) {
          context
              .read<AtherCubit>()
              .getDriverLocation(state.result.map((e) => e.qarebDeviceimei).toList());
        },
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isAllowed(AppPermissions.CREATION))
                FloatingActionButton(
                  heroTag: '1',
                  onPressed: () {
                    context.pushNamed(GoRouteName.createDriver);
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              10.0.verticalSpace,
              StatefulBuilder(
                builder: (context, mState) {
                  return FloatingActionButton(
                    heroTag: '2',
                    onPressed: () {
                      mState(() => loading = true);
                      context.read<AllDriversCubit>().getDriversAsync(context).then(
                        (value) {
                          if (value == null) return;
                          saveXls(
                            header: value.first,
                            data: value.second,
                            fileName: 'تقرير السائقين ${DateTime.now().formatDate}',
                          );
                          mState(() => loading = false);
                        },
                      );
                    },
                    child: loading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white)
                        : const Icon(Icons.file_download, color: Colors.white),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 200.0).h,
            child: Column(
              children: [
                BlocBuilder<AllDriversCubit, AllDriversInitial>(
                  builder: (context, state) {
                    if (isTrans) {
                      return TransDriversFilterWidget(
                        onApply: (request) {
                          context.read<AllDriversCubit>().getAllDrivers(
                                context,
                                command: context
                                    .read<AllDriversCubit>()
                                    .state
                                    .command
                                    .copyWith(
                                      driversFilterRequest: request,
                                      skipCount: 0,
                                      totalCount: 0,
                                    ),
                              );
                        },
                        command: state.command,
                      );
                    }
                    return DriversFilterWidget(
                      onApply: (request) {
                        context.read<AllDriversCubit>().getAllDrivers(
                              context,
                              command:
                                  context.read<AllDriversCubit>().state.command.copyWith(
                                        driversFilterRequest: request,
                                        skipCount: 0,
                                        totalCount: 0,
                                      ),
                            );
                      },
                      command: state.command,
                    );
                  },
                ),
                BlocBuilder<AllDriversCubit, AllDriversInitial>(
                  builder: (_, state) {
                    if (state.statuses.isLoading) {
                      return MyStyle.loadingWidget();
                    }
                    if (state.result.isEmpty) {
                      return const NotFoundWidget(text: 'لا يوجد سائقين');
                    }
                    final list = state.result;
                    return SaedTableWidget(
                      fullHeight: 1.8.sh,
                      command: state.command,
                      title: clientTableHeader,
                      data: list
                          .mapIndexed(
                            (index, e) => [
                              if (!isTrans) EnginWidget(engineStatus: e.engineStatus),
                              e.id.toString(),
                              e.fullName,
                              e.phoneNumber,
                              if (!isTrans) e.driverStatus.arabicName,
                              e.qarebDeviceimei,
                              if (!isTrans)
                                '${e.lastInternetConnection?.formatDate ?? '-'}'
                                    '\n${e.lastInternetConnection?.formatTime ?? '-'}',
                              if (isQareebAdmin) ...[
                                LoyalSwitchWidget(driver: e),
                                e.emailConfirmationCode,
                              ],
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ChangeUserStateBtn(user: e),
                                  if (isAllowed(AppPermissions.UPDATE))
                                    InkWell(
                                      onTap: () {
                                        context.pushNamed(GoRouteName.updateDriver,
                                            extra: e);
                                      },
                                      child: const CircleButton(
                                          color: Colors.amber, icon: Icons.edit),
                                    ),
                                  InkWell(
                                    onTap: () {
                                      context.pushNamed(GoRouteName.driverInfo,
                                          queryParams: {'id': e.id.toString()});
                                    },
                                    child: const CircleButton(
                                      color: Colors.grey,
                                      icon: Icons.info_outline_rounded,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          .toList(),
                      onChangePage: (command) {
                        context
                            .read<AllDriversCubit>()
                            .getAllDrivers(context, command: command);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EnginWidget extends StatelessWidget {
  const EnginWidget({super.key, required this.engineStatus});

  final bool engineStatus;

  @override
  Widget build(BuildContext context) {
    return ImageMultiType(
      height: 30.0.r,
      width: 30.0.r,
      url: Assets.iconsCircle,
      color: engineStatus ? Colors.green : Colors.red,
    );
  }
}
