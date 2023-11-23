import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/companies_cubit/companies_cubit.dart';

const companyList = [
  'ID',
  'صورة',
  'اسم الشركة',
  'نوع الاشتراكات',
  'عمليات',
];

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createCompany),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllCompaniesCubit, AllCompaniesInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد شركات');
          return SingleChildScrollView(
            child: SaedTableWidget(
              command: state.command,
              title: companyList,
              data: list
                  .mapIndexed(
                    (index, e) => [
                      e.id.toString(),
                      Center(
                        child: RoundImageWidget(
                          url: e.imageUrl,
                          height: 70.0.r,
                          width: 70.0.r,
                        ),
                      ),
                      e.name,
                      e.type.arabicName,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: !isAllowed(AppPermissions.UPDATE)
                                ? null
                                : () {
                                    context.pushNamed(
                                      GoRouteName.createCompany,
                                      extra: e,
                                    );
                                  },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: BlocConsumer<DeleteInstitutionCubit,
                          //       DeleteInstitutionInitial>(
                          //     listener: (context, state) {
                          //       context
                          //           .read<AllInstitutionsCubit>()
                          //           .getInstitutions(context);
                          //     },
                          //     listenWhen: (p, c) => c.statuses.done,
                          //     buildWhen: (p, c) => c.id == e.id,
                          //     builder: (context, state) {
                          //       if (state.statuses.isLoading) {
                          //         return MyStyle.loadingWidget();
                          //       }
                          //       return InkWell(
                          //         onTap: () {
                          //           context
                          //               .read<DeleteInstitutionCubit>()
                          //               .deleteInstitution(context, id: e.id);
                          //         },
                          //         child: const Icon(
                          //           Icons.delete_forever,
                          //           color: Colors.red,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  )
                  .toList(),
              onChangePage: (command) {
                context.read<AllCompaniesCubit>().getCompanies(context, command: command);
              },
            ),
          );
        },
      ),
    );
  }
}
