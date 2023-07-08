import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/util/my_style.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../data/response/clients_response.dart';

class ClientDataSource extends DataGridSource {
  List<DriverModel> clients;
  Function(DriverModel)? editFunction;
  Function(DriverModel)? viewFunction;
  Function(DriverModel)? activeFunction;

  List<DataGridRow> dataGridRows = [];

  ClientDataSource(
      {required this.clients, this.editFunction, this.activeFunction, this.viewFunction}) {
    dataGridRows = clients
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
      final admin = (e.value as SpinnerItem).item as DriverModel;

      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5.0).r,
          child: e.columnName == "Actions"
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<ChangeUserStateCubit, ChangeUserStateInitial>(
                      buildWhen: (p, c) => c.id == admin.id,
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        if (state.statuses.done) admin.isActive = !admin.isActive;

                        return InkWell(
                          onTap: () {
                            activeFunction?.call(admin);
                          },
                          child: CircleButton(
                            color: admin.isActive ? Colors.red : Colors.green,
                            icon: admin.isActive
                                ? Icons.cancel_outlined
                                : Icons.check_circle_outline,
                          ),
                        );
                      },
                    ),

                    InkWell(
                      onTap: () {
                        viewFunction?.call(admin);
                      },
                      child: const CircleButton(
                        color: Colors.grey,
                        icon: Icons.info_outline_rounded,
                      ),
                    ),
                  ],
                )
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
