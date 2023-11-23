import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import 'package:image_multi_type/image_multi_type.dart';
import '../../bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../bloc/delete_institution_cubit/delete_institution_cubit.dart';

const institutionList = [
  'صورة',
  'اسم المؤسسة',
  'المحافظة',
  'نوع المؤسسة',
  'مفتاح أثر',
  'عمليات',
];

class InstitutionsPage extends StatelessWidget {
  const InstitutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createInstitution),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllInstitutionsCubit, AllInstitutionsInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
          return SingleChildScrollView(
            child: SaedTableWidget(
              command: state.command,
              title: institutionList,
              data: list
                  .mapIndexed(
                    (index, e) => [
                      Center(
                        child: RoundImageWidget(
                          url: e.imageUrl,
                          height: 70.0.r,
                          width: 70.0.r,
                        ),
                      ),
                      e.name,
                      Governorate.values[e.government].arabicName,
                      InstitutionType.values[e.type].arabicName,
                      e.atharKey,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: !isAllowed(AppPermissions.UPDATE)
                                ? null
                                : () {
                                    context.pushNamed(GoRouteName.createInstitution,
                                        extra: e);
                                  },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.amber,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocConsumer<DeleteInstitutionCubit,
                                DeleteInstitutionInitial>(
                              listener: (context, state) {
                                context
                                    .read<AllInstitutionsCubit>()
                                    .getInstitutions(context);
                              },
                              listenWhen: (p, c) => c.statuses.isDone,
                              buildWhen: (p, c) => c.id == e.id,
                              builder: (context, state) {
                                if (state.statuses.isLoading) {
                                  return MyStyle.loadingWidget();
                                }
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<DeleteInstitutionCubit>()
                                        .deleteInstitution(context, id: e.id);
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
                    .read<AllInstitutionsCubit>()
                    .getInstitutions(context, command: command);
              },
            ),
          );
        },
      ),
    );
  }
}
