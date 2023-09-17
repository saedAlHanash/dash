import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../bloc/create_governorate_cubit/create_governorate_cubit.dart';
import '../../bloc/delete_governorate_cubit/delete_governorate_cubit.dart';
import '../../bloc/governorates_cubit/governorates_cubit.dart';
import '../../data/response/government_response.dart';

class GovernmentsPage extends StatefulWidget {
  const GovernmentsPage({super.key});

  @override
  State<GovernmentsPage> createState() => _GovernmentsPageState();
}

class _GovernmentsPageState extends State<GovernmentsPage> {
  void showCreateDialog({GovernmentModel? request}) {
    request ??= GovernmentModel.fromJson({});
    NoteMessage.showMyDialog(
      context,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<CreateGovernmentCubit>(),
          ),
          BlocProvider.value(
            value: context.read<GovernmentsCubit>(),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(40.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.0.verticalSpace,
              MyTextFormNoLabelWidget(
                label: 'اسم المحافظة',
                initialValue: request.name,
                onChanged: (p0) => request!.name = p0,
              ),
              BlocConsumer<CreateGovernmentCubit, CreateGovernmentInitial>(
                listener: (context, state) {
                  context.read<GovernmentsCubit>().getGovernment(context);
                  Navigator.pop(context, true);
                },
                listenWhen: (p, c) => c.statuses.done,
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    onTap: () {
                      if (request!.name.isEmpty) return;
                      context
                          .read<CreateGovernmentCubit>()
                          .createGovernment(context, request: request);
                    },
                    text: request?.id != 0 ? 'تعديل' : 'إنشاء',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => showCreateDialog(),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<GovernmentsCubit, GovernmentsInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد محافظات');
          return Column(
            children: [
              DrawableText(
                text: 'المحافظات',
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
                              text: item.name,
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          BlocConsumer<DeleteGovernmentCubit, DeleteGovernmentInitial>(
                            listener: (context, state) {
                              context.read<GovernmentsCubit>().getGovernment(context);
                            },
                            listenWhen: (p, c) => c.statuses.done,
                            buildWhen: (p, c) => c.id == item.id,
                            builder: (context, state) {
                              if (state.statuses.isLoading) {
                                return MyStyle.loadingWidget();
                              }
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<DeleteGovernmentCubit>()
                                          .deleteGovernment(context, id: item.id);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showCreateDialog(request: item);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.pushNamed(GoRouteName.area, queryParams: {
                                        'id': item.id.toString(),
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppColorManager.mainColor,
                                    ),
                                  ),
                                ],
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
