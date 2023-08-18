import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/change_user_state_btn.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_drivers/all_drivers_cubit.dart';


final clientTableHeader = [
  "id",
  "اسم الباص",
  "رقم الهاتف",
  "حالة السائق",
  "IMEI",
  "تاريخ التسجيل",
  "الولاء",
  "العمليات",
];

class DriverPage extends StatelessWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.admins)
          ? FloatingActionButton(
              onPressed: () {
                context.pushNamed(GoRouteName.createDriver);
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllDriversCubit, AllDriversInitial>(
        builder: (_, state) {
          if (state.statuses.loading) {
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
                    LoyalSwitchWidget(driver: e),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ChangeUserStateBtn(user: e),
                        if (isAllowed(AppPermissions.roles))
                          InkWell(
                            onTap: () {
                              context.pushNamed(GoRouteName.updateDriver, extra: e);
                            },
                            child:
                                const CircleButton(color: Colors.amber, icon: Icons.edit),
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
              context.read<AllDriversCubit>().getAllDrivers(context, command: command);
            },
          );
        },
      ),
    );
  }
}