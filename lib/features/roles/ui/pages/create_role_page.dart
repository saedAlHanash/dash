import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_checkbox_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../bloc/all_permissions_cubit/all_permissions_cubit.dart';
import '../../bloc/all_roles/all_roles_cubit.dart';
import '../../bloc/create_role_cubit/create_role_cubit.dart';
import '../../data/request/create_role_request.dart';
import '../../data/response/roles_response.dart';
import 'dart:html';

class CreateRolePage extends StatefulWidget {
  const CreateRolePage({super.key, this.role});

  final Role? role;

  @override
  State<CreateRolePage> createState() => _CreateRolePageState();
}

class _CreateRolePageState extends State<CreateRolePage> {
  var request = CreateRoleRequest();

  @override
  void initState() {
    if (widget.role != null) request = CreateRoleRequest.fromRole(widget.role!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateRoleCubit, CreateRoleInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        window.history.back();
        context.read<AllRolesCubit>().getAllRoles(context);
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'إنشاء مدير ',
        ),
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
                      text: 'معلومات الدور',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'اسم الدور',
                            initialValue: request.name,
                            onChanged: (p0) {
                              request.name = p0;
                              request.displayName = p0;
                              request.normalizedName = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'وصف الدور',
                            initialValue: request.description,
                            onChanged: (p0) => request.description = p0,
                          ),
                        ),
                      ],
                    ),
                    10.0.verticalSpace,
                  ],
                ),
              ),
              DrawableText(
                text: 'الصلاحيات',
                size: 25.0.sp,
                padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                matchParent: true,
                textAlign: TextAlign.center,
                fontFamily: FontManager.cairoBold.name,
              ),
              BlocBuilder<AllPermissionsCubit, AllPermissionsInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }

                  final list = state.result
                      .map((e) => SpinnerItem(
                          id: e.id,
                          name: tranzlatePermition(e.name),
                          item: e,
                          isSelected: request.grantedPermissions.contains(e.name)))
                      .toList();
                  return Center(
                    child: MyCheckboxWidget(
                      items: list,
                      onSelectGetListItems: (list) {
                        request.grantedPermissions
                          ..clear()
                          ..addAll(list.map((e) => e.item.name as String).toList());
                      },
                    ),
                  );
                },
              ),
              30.0.verticalSpace,
              BlocBuilder<CreateRoleCubit, CreateRoleInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.role != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateRoleCubit>()
                            .createRole(context, request: request);
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
