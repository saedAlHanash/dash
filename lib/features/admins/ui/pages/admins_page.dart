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
import '../../bloc/all_admins/all_admins_cubit.dart';
import '../widget/admin_data_grid.dart';

final adminsEableHeader = [
  "id",
  "اسم المدير",
  "رقم الهاتف",
  "حالة المدير",
  "البريد",
  "تفاصيل",

];

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
      body: Column(
        children: [
          BlocBuilder<AllAdminsCubit, AllAdminsInitial>(
            builder: (_, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              if (state.result.isEmpty) {
                return const NotFoundWidget(text: 'لا يوجد مدراء');
              }

              final list = state.result;

              return SaedTableWidget(
                command: state.command,
                title: adminsEableHeader,
                fullSizeIndex: const [5],
                data: list
                    .mapIndexed(
                      (index, e) => [
                        e.id.toString(),
                        e.fullName,
                        e.phoneNumber,
                        e.isActive ? 'مفعل' : 'غير مفعل',
                        e.emailAddress,

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                context.pushNamed(GoRouteName.adminInfo, extra: e);
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
                  context.read<AllAdminsCubit>().getAllAdmins(context, command: command);
                },
              );

            },
          ),
        ],
      ),
    );
  }
}
