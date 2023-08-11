import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../bloc/create_cubit/create_cubit.dart';
import '../../bloc/delete_reason_cubit/delete_reason_cubit.dart';
import '../../bloc/get_reasons_cubit/get_reasons_cubit.dart';

class ReasonsPage extends StatelessWidget {
  const ReasonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () {
                var reason = '';
                NoteMessage.showCustomBottomSheet(
                  context,
                  child: BlocProvider.value(
                    value: context.read<CreateReasonCubit>(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        30.0.verticalSpace,
                        MyTextFormNoLabelWidget(
                          label: 'السبب',
                          onChanged: (p0) => reason = p0,
                        ),
                        BlocConsumer<CreateReasonCubit, CreateReasonInitial>(
                          listener: (context, state) => Navigator.pop(context, true),
                          listenWhen: (p, c) => c.statuses.done,
                          builder: (context, state) {
                            if (state.statuses.isLoading) {
                              return MyStyle.loadingWidget();
                            }
                            return MyButton(
                              onTap: () {
                                if (reason.isEmpty) return;
                                context
                                    .read<CreateReasonCubit>()
                                    .createReason(context, reason: reason);
                              },
                              text: 'إنشاء',
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  onCancel: (val) {
                    if (val) context.read<GetReasonsCubit>().getReasons(context);
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<GetReasonsCubit, GetReasonsInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد أسباب');
          return Column(
            children: [
              DrawableText(
                text: 'أسباب الإلغاء',
                matchParent: true,
                size: 28.0.sp,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final item = list[i];
                    return MyCardWidget(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                      child: Row(
                        children: [
                          Expanded(
                            child: DrawableText(
                              text: 'السبب : ${item.name}',
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          BlocConsumer<DeleteReasonCubit, DeleteReasonInitial>(
                            listener: (context, state) {
                              context.read<GetReasonsCubit>().getReasons(context);
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
                                      .read<DeleteReasonCubit>()
                                      .deleteReason(context, id: item.id);
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
