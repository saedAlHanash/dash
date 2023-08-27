import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../bloc/system_settings_cubit/system_settings_cubit.dart';
import '../../bloc/update_system_params_cubit/update_system_settings_cubit.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateSettingCubit, UpdateSettingInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        // window.history.back();
        context.read<SystemSettingsCubit>().getSystemSettings(context);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
          child: BlocBuilder<SystemSettingsCubit, SystemSettingsInitial>(
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
                                label: 'رقم الإصدار الأدنى زبون',
                                initialValue: request.mainClientAppVersion.toString(),
                                onChanged: (p0) => request.mainClientAppVersion =
                                    num.tryParse(p0).toString(),
                              ),
                            ),
                            15.0.horizontalSpace,
                            Expanded(
                              child: MyTextFormNoLabelWidget(
                                label: 'رقم الإصدار الأدنى سائق',
                                initialValue: request.mainSriverAppVersion.toString(),
                                onChanged: (p0) => request.mainSriverAppVersion =
                                    num.tryParse(p0).toString(),
                              ),
                            ),
                          ],
                        ),
                        10.0.verticalSpace,
                      ],
                    ),
                  ),
                  BlocBuilder<UpdateSettingCubit, UpdateSettingInitial>(
                    builder: (context, state) {
                      if (state.statuses.isLoading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        text: 'تعديل',
                        onTap: () {
                          context
                              .read<UpdateSettingCubit>()
                              .updateSetting(context, request: request);
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
