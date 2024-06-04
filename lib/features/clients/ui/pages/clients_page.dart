import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/util/checker_helper.dart';
import 'package:qareeb_dash/core/widgets/filter/filter_item.dart';
import 'package:qareeb_dash/core/widgets/filter/filter_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/features/clients/bloc/clients_cubit/clients_cubit.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/change_user_state_btn.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';

final clientTableHeader = [
  "id",
  "اسم الزبون",
  "رقم الهاتف",
  "حالة الزبون",
  "تاريخ التسجيل",
  "OTP",
  "العمليات",
];

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  var loading = false;

  ClientsCubit get cubit => context.read<ClientsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(
        builder: (context, mState) {
          return FloatingActionButton(
            onPressed: () {
              mState(() => loading = true);
              context.read<ClientsCubit>().getBusAsync().then(
                (value) {
                  mState(() => loading = false);
                },
              );
            },
            child: loading
                ? const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white)
                : const Icon(Icons.file_download, color: Colors.white),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FilterWidget(
              filters: [
                [
                  FilterItem(
                    type: FilterType.text,
                    title: 'اسم الزبون',
                    key: 'name',
                    controller: TextEditingController(),
                  ),
                  FilterItem(
                    type: FilterType.text,
                    title: 'رقم الهاتف',
                    key: 'phone',
                    controller: TextEditingController(),
                  ),
                  FilterItem(
                    type: FilterType.spinner,
                    title: 'الجنس',
                    key: 'g',
                    items: Gender.values.spinnerItems(),
                  ),
                ]
              ],
              onFilter: (map) {
                cubit
                  ..setRequest(map)
                  ..getClients();
              },
            ),

            // BlocBuilder<ClientsCubit, ClientsInitial>(
            //   builder: (context, state) {
            //     return ClientsFilterWidget(
            //       onApply: (request) {
            //         context.read<ClientsCubit>().getClients(
            //               context,
            //               command: context.read<ClientsCubit>().state.command.copyWith(
            //                 clientsFilterRequest: request,
            //                     skipCount: 0,
            //                     totalCount: 0,
            //                   ),
            //             );
            //       },
            //       command: state.command,
            //     );
            //   },
            // ),
            BlocBuilder<ClientsCubit, ClientsInitial>(
              builder: (_, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (state.result.isEmpty) {
                  return const NotFoundWidget(text: 'لا يوجد زبائن');
                }

                return SaedTableWidget(
                  onChangePage: (command) {},
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
                          e.emailConfirmationCode,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (allowedManageClients)
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
