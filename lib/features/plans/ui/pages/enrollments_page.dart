import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/delete_plan_cubit/delete_plan_cubit.dart';
import '../../bloc/enrollments_cubit/enrollments_cubit.dart';
import '../../bloc/plans_cubit/plans_cubit.dart';

const headers = [
  'ID',
  'الشركة',
  'الخطة',
  'المشترك',
  'بداية\n نهاية',
  'حالة',
];

class EnrollmentsPage extends StatelessWidget {
  const EnrollmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => NoteMessage.showMyDialog(
          context,
          child: Column(
            children: [

            ],
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<EnrollmentCubit, EnrollmentInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty)
            return const NotFoundWidget(text: 'لا يوجد مشتركين');
          return SingleChildScrollView(
            child: SaedTableWidget(
              command: state.command,
              title: headers,
              data: list
                  .mapIndexed(
                    (i, e) => [
                      e.id.toString(),
                      e.company.name,
                      e.plan.name,
                      e.user.name,
                      '${e.startDate?.formatDate}'
                          '\n${e.expiryDate?.formatDate}',
                      e.isExpired ? 'منتهي' : 'فعال',
                    ],
                  )
                  .toList(),
              onChangePage: (command) {
                context
                    .read<AllPlansCubit>()
                    .getPlans(context, command: command);
              },
            ),
          );
        },
      ),
    );
  }
}
