import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../buses/bloc/all_buses_cubit/all_buses_cubit.dart';
import '../../bloc/all_super_users_cubit/all_super_users_cubit.dart';
import '../../bloc/create_super_user_cubit/create_super_user_cubit.dart';
import '../../data/request/create_super_user_request.dart';
import '../../data/response/super_users_response.dart';

class CreateSuperUserPage extends StatefulWidget {
  const CreateSuperUserPage({super.key, this.superUser});

  final SuperUserModel? superUser;

  @override
  State<CreateSuperUserPage> createState() => _CreateSuperUserPageState();
}

class _CreateSuperUserPageState extends State<CreateSuperUserPage> {
  var request = CreateSuperUserRequest();

  @override
  void initState() {
    if (widget.superUser != null) {
      request = CreateSuperUserRequest().fromSuperUsers(widget.superUser!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateSuperUsersCubit, CreateSuperUsersInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllSuperUsersCubit>().getSuperUsers(context);
        window.history.back();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.0.verticalSpace,
              MyCardWidget(
                cardColor: AppColorManager.f1,
                margin: const EdgeInsets.symmetric(vertical: 30.0).h,
                child: Column(
                  children: [
                    DrawableText(
                      text: 'المشرف',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'اسم المشرف',
                            initialValue: request.fullName,
                            onChanged: (p0) => request.fullName = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'هاتف المشرف',
                            initialValue: request.phone,
                            onChanged: (p0) => request.phone = p0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'حساب المشرف(اسم مستخدم)',
                            initialValue: request.userName,
                            onChanged: (p0) => request.userName = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'كلمة المرور',
                            obscureText: true,
                            initialValue: request.id == null ? request.password : '',
                            onChanged: (p0) => request.password = p0,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    ItemInfoInLine(
                      title: 'الباص',
                      widget: BlocBuilder<AllBusesCubit, AllBusesInitial>(
                        builder: (context, state) {
                          if (state.statuses.loading) {
                            return MyStyle.loadingWidget();
                          }
                          return SpinnerOutlineTitle(
                            items: state.getSpinnerSuperUser(selected: request.busId),
                            label: 'الباص',
                            onChanged: (spinnerItem) => request.busId = spinnerItem.id,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateSuperUsersCubit, CreateSuperUsersInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.superUser != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateSuperUsersCubit>()
                            .createSuperUsers(context, request: request);
                      }
                    },
                  );
                },
              ),
              20.0.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
