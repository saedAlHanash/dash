import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/main.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/util/checker_helper.dart';
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
        .map<DataGridRow>((e) => DataGridRow(cells: [
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
                columnName: 'Actions',
                value: SpinnerItem(name: e.creationTime.toString(), item: e),
              )
            ]))
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
                    InkWell(
                      onTap: () {
                        activeFunction?.call(driver);
                      },
                      child: const CircleButton(color: Colors.red, icon: Icons.cancel_outlined),
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
              : SelectionArea(
                  child: DrawableText(
                    text: (e.value as SpinnerItem).name??'',
                  ),
                ));
    }).toList());
  }

  void updateDataGriDataSource() {
    notifyListeners();
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.color, required this.icon});

  final Color color;
  final IconData icon;

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
          size: 20.0.r,
          color: Colors.white,
        ),
      ),
    );
  }
}
