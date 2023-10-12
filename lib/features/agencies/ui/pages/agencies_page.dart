import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/features/agencies/data/response/agency_response.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../bloc/agencies_cubit/agencies_cubit.dart';
import '../../bloc/create_agency_cubit/create_agency_cubit.dart';
import '../../bloc/delete_agency_cubit/delete_agency_cubit.dart';

class AgenciesPage extends StatelessWidget {
  const AgenciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () {
                var reason = '';
                NoteMessage.showMyDialog(
                  context,
                  child: BlocProvider.value(
                    value: context.read<CreateAgencyCubit>(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        30.0.verticalSpace,
                        MyTextFormNoLabelWidget(
                          label: 'اسم الوكيل',
                          onChanged: (p0) => reason = p0,
                        ),
                        BlocConsumer<CreateAgencyCubit, CreateAgencyInitial>(
                          listenWhen: (p, c) => c.statuses.done,
                          listener: (context, state) => Navigator.pop(context, true),
                          builder: (context, state) {
                            if (state.statuses.isLoading) {
                              return MyStyle.loadingWidget();
                            }
                            return MyButton(
                              onTap: () {
                                if (reason.isEmpty) return;
                                context.read<CreateAgencyCubit>().createAgency(
                                      context,
                                      request: Agency.fromJson({'name': reason}),
                                    );
                              },
                              text: 'إنشاء',
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  onCancel: (val) {
                    if (val) context.read<AgenciesCubit>().getAgencies(context);
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AgenciesCubit, AgenciesInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد وكلاء');
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final item = list[i];
              return MyCardWidget(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: DrawableText(
                        text: 'اسم الوكيل : ${item.name}',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    BlocConsumer<DeleteAgencyCubit, DeleteAgencyInitial>(
                      listener: (context, state) {
                        context.read<AgenciesCubit>().getAgencies(context);
                      },
                      listenWhen: (p, c) => c.statuses.done,
                      buildWhen: (p, c) => c.id == item.id,
                      builder: (context, state) {
                        if (state.statuses.isLoading) {
                          return MyStyle.loadingWidget();
                        }
                        return IconButton(
                          onPressed: () {
                            context
                                .read<DeleteAgencyCubit>()
                                .deleteAgency(context, id: item.id);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
