import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../router/go_route_pages.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../bloc/all_admins/all_admins_cubit.dart';
import '../../data/response/admins_response.dart';
import '../widget/admin_data_grid.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
                context.pushNamed(GoRouteName.createAdmin);
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllAdminsCubit, AllAdminsInitial>(
        builder: (_, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return const NotFoundWidget(text: 'لا يوجد مدراء');
          }
          var dataSource = AdminDataSource(
              admins: state.result,
              editFunction: (AdminModel admin) {
                context.pushNamed(GoRouteName.createAdmin, extra: admin);
              },
              viewFunction: (AdminModel admin) {
                context.pushNamed(GoRouteName.adminInfo, extra: admin);
              },
              activeFunction: (AdminModel admin) async {
                context
                    .read<ChangeUserStateCubit>()
                    .changeUserState(context, id: admin.id, userState: !admin.isActive);
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
      gridColumn(text: "اسم المدير"),
      gridColumn(text: "رقم الهاتف"),
      gridColumn(text: "حالة المدير"),
      gridColumn(text: "البريد"),
      gridColumn(text: "العمليات"),
    ];
  }
}

GridColumn gridColumn({required String text}) {
  return GridColumn(
    columnName: 'admin',
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
