import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/change_user_state_btn.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../auth/bloc/change_user_state_cubit/change_user_state_cubit.dart';
import '../../../drivers/data/response/drivers_response.dart';
import '../../bloc/all_clients/all_clients_cubit.dart';


final clientTableHeader = [
  "id",
  "اسم الزبون",
  "رقم الهاتف",
  "حالة الزبون",
  "تاريخ التسجيل",
  "العمليات",
];

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllClientsCubit, AllClientsInitial>(
        builder: (_, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (state.result.isEmpty) {
            return const NotFoundWidget(text: 'لا يوجد زبائن');
          }


          return SaedTableWidget(
            command: state.command,
            title: clientTableHeader,
            data: list
                .mapIndexed(
                  (index, e) => [
                    e.id.toString(),
                    e.fullName,
                    e.phoneNumber,
                    e.isActive ? 'مفعل' : 'غير مفعل',
                    e.creationTime?.formatDate,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ChangeUserStateBtn(user: e),
                        InkWell(
                          onTap: () {
                            context.pushNamed(GoRouteName.clientInfo,
                                queryParams: {'id': e.id.toString()});
                          },
                          child: const CircleButton(
                            color: Colors.grey,
                            icon: Icons.info_outline_rounded,
                          ),
                        ),
                      ],
                    )
                  ],
                )
                .toList(),
            onChangePage: (command) {
              context.read<AllClientsCubit>().getAllClients(context, command: command);
            },
          );

        },
      ),
    );
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      gridColumn(text: "id"),
      gridColumn(text: "اسم الزبون"),
      gridColumn(text: "رقم الهاتف"),
      gridColumn(text: "حالة الزبون"),
      gridColumn(text: "العمليات"),
    ];
  }
}

GridColumn gridColumn({required String text}) {
  return GridColumn(
    columnName: 'user',
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
