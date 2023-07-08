import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../router/go_route_pages.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../bloc/all_drivers/all_drivers_cubit.dart';
import '../widget/driver_data_grid.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  int _rowsPerPage = 5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
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
          var dataSource = DriveDataSource(
              drivers: state.result,
              editFunction: (DriverModel driver) {
                context.pushNamed(GoRouteName.updateDriver, extra: driver);
              },
              viewFunction: (DriverModel driver) {
                context.pushNamed(GoRouteName.driverInfo, queryParams: {'id':driver.id.toString()});
              },
              activeFunction: (DriverModel driver) async {
                context
                    .read<ChangeUserStateCubit>()
                    .changeUserState(context, id: driver.id, userState: !driver.isActive);
              });

          return Column(
            children: [
              SfDataGrid(
                allowSorting: false,
                allowFiltering: false,
                rowsPerPage: _rowsPerPage,
                source: dataSource,
                columns: getColumns(),
                columnWidthMode: ColumnWidthMode.auto,
              ),
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withOpacity(0.12),
                    border: Border(
                        top: BorderSide(
                            width: .5,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.12)))),
                child: Align(
                    child: SfDataPagerTheme(
                  data: SfDataPagerThemeData(),
                  child: SfDataPager(
                    delegate: dataSource,
                    availableRowsPerPage: const <int>[1, 2, 5, 10, 20],
                    pageCount: 1,
                    onRowsPerPageChanged: (int? rowsPerPage) {
                      setState(() {
                        _rowsPerPage = rowsPerPage!;
                        dataSource.updateDataGriDataSource();
                      });
                    },
                  ),
                )),
              )
            ],
          );
        },
      ),
    );
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      gridColumn(text: "id"),
      gridColumn(text: "اسم السائق"),
      gridColumn(text: "رقم الهاتف"),
      gridColumn(text: "حالة السائق"),
      gridColumn(text: "IMEI"),
      gridColumn(text: "الولاء"),
      gridColumn(text: "العمليات"),
    ];
  }
}

GridColumn gridColumn({required String text}) {
  return GridColumn(
    columnName: 'driver',
    width: double.nan,
    columnWidthMode: ColumnWidthMode.fill,
    label: Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0).r,
      child: SelectionArea(
        child: DrawableText(
          text: text,
          matchParent: true,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
