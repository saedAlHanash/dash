import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/system_params_cubit/system_params_cubit.dart';
import '../../bloc/update_system_params_cubit/update_system_params_cubit.dart';

class ParamsPage extends StatefulWidget {
  const ParamsPage({Key? key}) : super(key: key);

  @override
  State<ParamsPage> createState() => _ParamsPageState();
}

class _ParamsPageState extends State<ParamsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateParamsCubit, UpdateParamsInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        // window.history.back();
        context.read<SystemParamsCubit>().getSystemParams(context);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
          child: BlocBuilder<SystemParamsCubit, SystemParamsInitial>(
            builder: (context, state) {

              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              final request = state.result.first.copyWith();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.0.verticalSpace,
                  MyCardWidget(
                    cardColor: AppColorManager.f1,
                    margin: const EdgeInsets.symmetric(vertical: 30.0).h,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MyTextFormNoLabelWidget(
                                label: 'زيت',
                                initialValue: request.oil.toString(),
                                onChanged: (p0) => request.oil = num.tryParse(p0),
                              ),
                            ),
                            15.0.horizontalSpace,
                            Expanded(
                              child: MyTextFormNoLabelWidget(
                                label: 'المليون',
                                initialValue: request.gold.toString(),
                                onChanged: (p0) => request.gold = num.tryParse(p0),
                              ),
                            ),
                            15.0.horizontalSpace,
                            Expanded(
                              child: MyTextFormNoLabelWidget(
                                label: 'إطارات',
                                initialValue: request.tire.toString(),
                                onChanged: (p0) => request.tire = num.tryParse(p0),
                              ),
                            ),
                          ],
                        ),
                        10.0.verticalSpace,
                      ],
                    ),
                  ),
                  BlocBuilder<UpdateParamsCubit, UpdateParamsInitial>(
                    builder: (context, state) {
                      if (state.statuses.isLoading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        text: 'تعديل',
                        onTap: () {
                          context
                              .read<UpdateParamsCubit>()
                              .updateParams(context, request: request);
                        },
                      );
                    },
                  ),
                  20.0.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
