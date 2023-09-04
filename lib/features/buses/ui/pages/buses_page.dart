import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/file_util.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';

import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';

import '../../bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../bloc/delete_buss_cubit/delete_buss_cubit.dart';
import '../widget/buses_filter_widget.dart';

final _super_userList = [
  'ID',
  'اسم الباص',
  'رقم هاتف السائق',
  'IME',
  if (isAllowed(AppPermissions.buses)) 'عمليات',
];

class BusesPage extends StatefulWidget {
  const BusesPage({super.key});

  @override
  State<BusesPage> createState() => _BusesPageState();
}

class _BusesPageState extends State<BusesPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.buses)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () => context.pushNamed(GoRouteName.createBus),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                10.0.verticalSpace,
                StatefulBuilder(
                  builder: (context, mState) {
                    return FloatingActionButton(
                      onPressed: () {
                        mState(() => loading = true);
                        context.read<AllBusesCubit>().getBusesAsync(context).then(
                          (value) {
                            if (value == null) return;
                            saveXls(header: value.first, data: value.second);
                            mState(() => loading = false);
                          },
                        );
                      },
                      child: loading
                          ? const CircularProgressIndicator.adaptive()
                          : const Icon(Icons.file_download, color: Colors.white),
                    );
                  },
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AllBusesCubit, AllBusesInitial>(
              builder: (context, state) {
                return BusesFilterWidget(
                  command: state.command,
                  onApply: (request) {
                    context.read<AllBusesCubit>().getBuses(
                          context,
                          command: context.read<AllBusesCubit>().state.command.copyWith(
                                busesFilterRequest: request,
                                skipCount: 0,
                                totalCount: 0,
                              ),
                        );
                  },
                );
              },
            ),
            BlocBuilder<AllBusesCubit, AllBusesInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
                return SaedTableWidget(
                  command: state.command,
                  title: _super_userList,
                  data: list
                      .mapIndexed(
                        (index, e) => [
                          e.id.toString(),
                          e.driverName,
                          e.driverPhone,
                          e.ime,
                          if (isAllowed(AppPermissions.buses))
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.pushNamed(GoRouteName.createBus, extra: e);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.amber,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocConsumer<DeleteBusCubit, DeleteBusInitial>(
                                    listener: (context, state) {
                                      context.read<AllBusesCubit>().getBuses(context);
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
                                              .read<DeleteBusCubit>()
                                              .deleteBus(context, id: e.id);
                                        },
                                        child: const Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                        ],
                      )
                      .toList(),
                  onChangePage: (command) {
                    context.read<AllBusesCubit>().getBuses(context, command: command);
                  },
                );
              },
            ),
            50.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
