import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/change_user_state_btn.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_admins/all_admins_cubit.dart';

final adminsEableHeader = [
  "id",
  "اسم المدير",
  "رقم الهاتف",
  "حالة المدير",
  "البريد",
  "العمليات",
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
      body: BlocBuilder<AllAdminsCubit, AllAdminsInitial>(
        builder: (_, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return const NotFoundWidget(text: 'لا يوجد مدراء');
          }
          final list = state.result;
          return SaedTableWidget(
            onChangePage: (command) {
              context
                  .read<AllAdminsCubit>()
                  .getAllAdmins(context, command: command);
            },
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
                    e.creationTime?.formatDate,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (!e.emailAddress.contains('info@first-pioneers'))
                          ChangeUserStateBtn(user: e),
                        if (!e.emailAddress.contains('info@first-pioneers'))
                          if (isAllowed(AppPermissions.UPDATE))
                            InkWell(
                              onTap: () {
                                context.pushNamed(GoRouteName.createAdmin, extra: e);
                              },
                              child: const CircleButton(
                                  color: Colors.amber, icon: Icons.edit),
                            ),
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
          );

        },
      ),
    );
  }
}
