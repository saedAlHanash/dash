import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/change_user_state_btn.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../clients/ui/widget/clients_filter_widget.dart';
import '../../bloc/all_drivers/all_drivers_cubit.dart';

final clientTableHeader = [
  "id",
  "اسم السائق",
  "رقم الهاتف",
  "حالة السائق",
  "IMEI",
  "تاريخ التسجيل",
  if (AppSharedPreference.getUser.roleName.toLowerCase() == 'admin') ...[
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
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAllowed(AppPermissions.CREATION))
            FloatingActionButton(
              onPressed: () {
                context.pushNamed(GoRouteName.createDriver);
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          10.0.verticalSpace,
          StatefulBuilder(
            builder: (context, mState) {
              return FloatingActionButton(
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
                    ? const CircularProgressIndicator.adaptive()
                    : const Icon(Icons.file_download, color: Colors.white),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AllDriversCubit, AllDriversInitial>(
              builder: (context, state) {
                return ClientsFilterWidget(
                  onApply: (request) {
                    context.read<AllDriversCubit>().getAllDrivers(
                          context,
                          command: context.read<AllDriversCubit>().state.command.copyWith(
                                memberFilterRequest: request,
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
                  command: state.command,
                  title: clientTableHeader,
                  fullSizeIndex: const [7],
                  data: list
                      .mapIndexed(
                        (index, e) => [
                          e.id.toString(),
                          e.fullName,
                          e.phoneNumber,
                          e.isActive ? 'مفعل' : 'غير مفعل',
                          e.qarebDeviceimei,
                          e.creationTime?.formatDate,
                          if (AppSharedPreference.getUser.roleName.toLowerCase() ==
                              'admin') ...[
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
                                    context.pushNamed(GoRouteName.updateDriver, extra: e);
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
    );
  }
}
