import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/main.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../bloc/loyalty_cubit/loyalty_cubit.dart';
import '../../data/response/drivers_response.dart';

class DriveDataSource extends DataGridSource {
  List<DriverModel> drivers;
  Function(DriverModel)? editFunction;
  Function(DriverModel)? viewFunction;
  Function(DriverModel)? activeFunction;

  List<DataGridRow> dataGridRows = [];

  DriveDataSource(
      {required this.drivers,
      this.editFunction,
      this.activeFunction,
      this.viewFunction}) {
    dataGridRows = drivers
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<SpinnerItem>(
                columnName: 'id',
                value: SpinnerItem(name: e.id.toString(), item: e),
              ),
              DataGridCell<SpinnerItem>(
                columnName: 'name',
                value: SpinnerItem(name: e.fullName, item: e),
              ),
              DataGridCell<SpinnerItem>(
                columnName: 'phone',
                value: SpinnerItem(name: e.phoneNumber, item: e),
              ),
              DataGridCell<SpinnerItem>(
                columnName: 'isActive',
                value: SpinnerItem(name: e.isActive ? 'مفعل' : 'غير مفعل', item: e),
              ),
              DataGridCell<SpinnerItem>(
                columnName: 'city',
                value: SpinnerItem(name: e.qarebDeviceimei ?? "Empty", item: e),
              ),
              DataGridCell<SpinnerItem>(
                columnName: 'loyalty',
                value: SpinnerItem(name: e.loyalty ? 'مشترك' : 'غير مشترك', item: e),
              ),
              DataGridCell<SpinnerItem>(
                columnName: 'Actions',
                value: SpinnerItem(name: e.creationTime.toString(), item: e),
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((e) {
      final driver = (e.value as SpinnerItem).item as DriverModel;

      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5.0).r,
          child: e.columnName == "Actions"
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<ChangeUserStateCubit, ChangeUserStateInitial>(
                      buildWhen: (p, c) => c.id == driver.id,
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        if (state.statuses.done) driver.isActive = !driver.isActive;

                        return InkWell(
                          onTap: () {
                            activeFunction?.call(driver);
                          },
                          child: CircleButton(
                            color: driver.isActive ? Colors.red : Colors.green,
                            icon: driver.isActive
                                ? Icons.cancel_outlined
                                : Icons.check_circle_outline,
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        editFunction?.call(driver);
                      },
                      child: const CircleButton(color: Colors.amber, icon: Icons.edit),
                    ),
                    InkWell(
                      onTap: () {
                        viewFunction?.call(driver);
                      },
                      child: const CircleButton(
                        color: Colors.grey,
                        icon: Icons.info_outline_rounded,
                      ),
                    ),
                  ],
                )
              : e.columnName == "loyalty"
                  ? LoyalSwitchWidget(driver: driver)
                  : SelectionArea(
                      child: DrawableText(
                        text: (e.value as SpinnerItem).name ?? '',
                      ),
                    ));
    }).toList());
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.color, required this.icon, this.size});

  final Color color;
  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(3.0).r,
      padding: const EdgeInsets.all(10.0).r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Icon(
          icon,
          size: size ?? 20.0.r,
          color: Colors.white,
        ),
      ),
    );
  }
}

class LoyalSwitchWidget extends StatelessWidget {
  const LoyalSwitchWidget({super.key, required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoyaltyCubit, LoyaltyInitial>(
      buildWhen: (p, c) => c.id == driver.id,
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }

        if (state.statuses.done) {
          driver.loyalty = !driver.loyalty;
        }

        return Switch(
          value: driver.loyalty,
          activeColor: AppColorManager.mainColor,
          inactiveTrackColor: Colors.grey,
          hoverColor: Colors.transparent,
          onChanged: (value) {
            context.read<LoyaltyCubit>().changeLoyalty(
                  context,
                  driverId: driver.id,
                  loyalState: !driver.loyalty,
                );
          },
        );
      },
    );
  }
}
