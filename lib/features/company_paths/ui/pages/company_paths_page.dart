import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../router/go_route_pages.dart';
import '../../../companies/ui/widget/companies_filter_widget.dart';
import '../../bloc/all_compane_paths_cubit/all_company_paths_cubit.dart';
import '../../bloc/delete_compane_path_cubit/delete_company_path_cubit.dart';

final _titleList = [
  'ID',
  'اسم المسار',
  'عدد النقاط',
  'طول المسار',
  // 'الوقت المقدر للمسار',
  'عمليات',
];

class CompanyPathsPage extends StatelessWidget {
  const CompanyPathsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(GoRouteName.createCompanyPath);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          BlocBuilder<AllCompanyPathsCubit, AllCompanyPathsInitial>(
            builder: (context, state) {
              return CompanyPathesFilterWidget(
                onApply: (request) {
                  context.read<AllCompanyPathsCubit>().getCompanyPaths(
                        context,
                        command:
                            context.read<AllCompanyPathsCubit>().state.command.copyWith(
                                  companiesFilterRequest: request,
                                  skipCount: 0,
                                  totalCount: 0,
                                ),
                      );
                },
                command: state.command,
              );
            },
          ),
          10.0.verticalSpace,
          BlocBuilder<AllCompanyPathsCubit, AllCompanyPathsInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              final list = state.result;
              if (list.isEmpty)
                return const NotFoundWidget(text: 'يرجى إضافة نماذج للرحلات');
              return SingleChildScrollView(
                child: SaedTableWidget(
                  command: state.command,
                  title: _titleList,
                  data: list
                      .mapIndexed(
                        (i, e) => [
                          e.id.toString(),
                          e.description,
                          (e.path.edges.length + 1).toString(),
                          '${(e.distance / 1000).round()} km',
                          // '${(e.duration / 60).round()} min',
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    GoRouteName.companyPathInfo,
                                    queryParams: {'id': e.id.toString()},
                                  );
                                },
                                child: const Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    GoRouteName.createCompanyPath,
                                    queryParams: {'id': e.id.toString()},
                                  );
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.amber,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocConsumer<DeleteCompanyPathCubit,
                                    DeleteCompanyPathInitial>(
                                  listener: (context, state) {
                                    context
                                        .read<AllCompanyPathsCubit>()
                                        .getCompanyPaths(context);
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
                                            .read<DeleteCompanyPathCubit>()
                                            .deleteCompanyPath(context, id: e.id);
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
                    context
                        .read<AllCompanyPathsCubit>()
                        .getCompanyPaths(context, command: command);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
