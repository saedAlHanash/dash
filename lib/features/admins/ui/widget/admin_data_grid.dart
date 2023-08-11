// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//  import 'package:qareeb_dash/core/widgets/spinner_widget.dart'; import 'package:qareeb_models/global.dart';
// import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// import '../../../../core/util/checker_helper.dart';
// import '../../../../core/widgets/change_user_state_btn.dart';
//
// class AdminDataSource extends DataGridSource {
//   List<DriverModel> admins;
//   Function(DriverModel)? editFunction;
//   Function(DriverModel)? viewFunction;
//
//   List<DataGridRow> dataGridRows = [];
//
//   AdminDataSource({required this.admins, this.editFunction, this.viewFunction}) {
//     dataGridRows = admins
//         .map<DataGridRow>(
//           (e) => DataGridRow(
//             cells: [
//               DataGridCell<SpinnerItem>(
//                 columnName: 'id',
//                 value: SpinnerItem(name: e.id.toString(), item: e),
//               ),
//               DataGridCell<SpinnerItem>(
//                 columnName: 'name',
//                 value: SpinnerItem(name: e.fullName, item: e),
//               ),
//               DataGridCell<SpinnerItem>(
//                 columnName: 'phone',
//                 value: SpinnerItem(name: e.phoneNumber, item: e),
//               ),
//               DataGridCell<SpinnerItem>(
//                 columnName: 'isActive',
//                 value: SpinnerItem(name: e.isActive ? 'مفعل' : 'غير مفعل', item: e),
//               ),
//               DataGridCell<SpinnerItem>(
//                 columnName: 'email',
//                 value: SpinnerItem(name: e.emailAddress, item: e),
//               ),
//               DataGridCell<SpinnerItem>(
//                 columnName: 'Actions',
//                 value: SpinnerItem(name: e.creationTime.toString(), item: e),
//               ),
//             ],
//           ),
//         )
//         .toList();
//   }
//
//   @override
//   List<DataGridRow> get rows => dataGridRows;
//
//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map((e) {
//       final admin = (e.value as SpinnerItem).item as DriverModel;
//
//       return Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.symmetric(horizontal: 5.0).r,
//           child: e.columnName == "Actions"
//               ? Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     if (!admin.emailAddress.contains('info@first-pioneers'))
//                       ChangeUserStateBtn(user: admin),
//                     if (!admin.emailAddress.contains('info@first-pioneers'))
//                       if (isAllowed(AppPermissions.UPDATE))
//                         InkWell(
//                           onTap: () {
//                             editFunction?.call(admin);
//                           },
//                           child:
//                               const CircleButton(color: Colors.amber, icon: Icons.edit),
//                         ),
//                     InkWell(
//                       onTap: () {
//                         viewFunction?.call(admin);
//                       },
//                       child: const CircleButton(
//                         color: Colors.grey,
//                         icon: Icons.info_outline_rounded,
//                       ),
//                     ),
//                   ],
//                 )
//               : SelectionArea(
//                   child: DrawableText(
//                     text: (e.value as SpinnerItem).name ?? '',
//                   ),
//                 ));
//     }).toList());
//   }
//
//   void updateDataGriDataSource() {
//     notifyListeners();
//   }
// }
//
