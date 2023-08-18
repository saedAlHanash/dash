import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';

import '../../bloc/all_roles/all_roles_cubit.dart';
import '../../bloc/delete_role_cubit/delete_role_cubit.dart';

final rolesEableHeader = [
  "ID",
  "اسم",
  "وصف",
  "تاريخ الإنشاء",
  "الصلاحيات",
  if(isAllowed(AppPermissions.roles))
  "العمليات",
];

class RolesPage extends StatefulWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.roles)
          ? FloatingActionButton(
              onPressed: () {
                context.pushNamed(GoRouteName.createRole);
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: Column(
        children: [
          BlocBuilder<AllRolesCubit, AllRolesInitial>(
            builder: (_, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              if (state.result.isEmpty) {
                return const NotFoundWidget(text: 'يرجى إضافة أدوار');
              }
              final list = state.result;
              return SaedTableWidget(
                command: state.command,
                title: rolesEableHeader,
                data: list
                    .mapIndexed(
                      (index, e) => [
                        e.id.toString(),
                        e.name,
                        e.description,
                        e.creationTime?.formatDate,
                        Wrap(
                          children: e.grantedPermissions.mapIndexed((i, permission) {
                            return DrawableText(
                              text: permission,
                              textAlign: TextAlign.start,
                            );
                          }).toList(),
                        ),
                        if(isAllowed(AppPermissions.roles))
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocConsumer<DeleteRoleCubit, DeleteRoleInitial>(
                                listener: (context, state) {
                                  context.read<AllRolesCubit>().getAllRoles(context);
                                },
                                listenWhen: (p, c) => c.statuses.done,
                                buildWhen: (p, c) => c.id == e.id,
                                builder: (context, state) {
                                  if (state.statuses.loading) {
                                    return MyStyle.loadingWidget();
                                  }
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<DeleteRoleCubit>()
                                          .deleteRole(context, id: e.id);
                                    },
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (isAllowed(AppPermissions.roles))
                              InkWell(
                                onTap: () {
                                  context.pushNamed(GoRouteName.createRole, extra: e);
                                },
                                child:
                                    const CircleButton(color: Colors.amber, icon: Icons.edit),
                              ),
                          ],
                        )
                      ],
                    )
                    .toList(),
                onChangePage: (command) {
                  context.read<AllRolesCubit>().getAllRoles(context, command: command);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}