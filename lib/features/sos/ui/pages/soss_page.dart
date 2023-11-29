import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/all_sos_cubit/all_sos_cubit.dart';

final _titleList = [
  'ID',
  'اسم المستخدم',
  'رقم الهاتف',
  'تاريخ الإرسال',
];

class SosPage extends StatelessWidget {
  const SosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<AllSosCubit, AllSosInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            final list = state.result;
            if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد رسائل');
            return SaedTableWidget(
              command: state.command,
              title: _titleList,
              data: list
                  .mapIndexed(
                    (i, e) => [
                      e.id.toString(),
                      e.getName,
                      e.getPhone,
                      e.date?.formatDateTime,
                    ],
                  )
                  .toList(),
              onChangePage: (command) {
                context.read<AllSosCubit>().getSos(context, command: command);
              },
            );
          },
        ),
      ),
    );
  }
}
