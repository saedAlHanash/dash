import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_checkbox_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../roles/bloc/all_roles/all_roles_cubit.dart';
import '../../bloc/all_admins/all_admins_cubit.dart';
import '../../bloc/create_admin_cubit/create_admin_cubit.dart';
import '../../data/request/create_admin_request.dart';

class CreateAdminPage extends StatefulWidget {
  const CreateAdminPage({super.key, this.admin});

  final DriverModel? admin;

  @override
  State<CreateAdminPage> createState() => _CreateAdminPageState();
}

class _CreateAdminPageState extends State<CreateAdminPage> {
  var request = CreateAdminRequest();

  @override
  void initState() {
    if (widget.admin != null) request = CreateAdminRequest.fromAdmin(widget.admin!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAdminCubit, CreateAdminInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        window.history.back();
        context.read<AllAdminsCubit>().getAllAdmins(context);
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
                      text: 'معلومات المدير',
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
                            label: 'اسم المدير',
                            initialValue: request.name,
                            onChanged: (p0) {
                              request.name = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'كنية المدير',
                            initialValue: request.surname,
                            onChanged: (p0) {
                              request.surname = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: StatefulBuilder(builder: (context, myState) {
                            return InkWell(
                              onTap: () async {
                                final pick = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now().addFromNow(year: -15),
                                );
                                myState(() => request.birthdate = pick);
                              },
                              child: Container(
                                width: 1.0.sw,
                                height: 60.0.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0.r),
                                  border: Border.all(color: AppColorManager.gray),
                                ),
                                child: Center(
                                  child: DrawableText(
                                    text: request.birthdate == null
                                        ? 'تاريخ الميلاد'
                                        : request.birthdate?.formatDate ?? '',
                                    color: AppColorManager.gray,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    10.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'رقم الهاتف',
                            onChanged: (p0) {
                              request.phoneNumber = p0;
                              request.userName = p0;
                            },
                            maxLength: 10,
                            initialValue: request.phoneNumber,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'العنوان',
                            initialValue: request.address,
                            onChanged: (p0) {
                              request.address = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                      ],
                    ),
                    const Divider(),
                    DrawableText(
                      text: 'معلومات الحساب',
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
                            label: 'البريد الإلكتروني',
                            initialValue: request.emailAddress,
                            onChanged: (p0) => request.emailAddress = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'كلمة السر',
                            initialValue: request.password,
                            onChanged: (p0) {
                              request.password = p0;
                            },
                          ),
                        ),
                      ],
                    ),
                    DrawableText(
                      text: 'الصلاحيات',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold,
                    ),
                    BlocBuilder<AllRolesCubit, AllRolesInitial>(
                      builder: (context, state) {
                        if (state.statuses.isLoading) {
                          return MyStyle.loadingWidget();
                        }

                        final list = state.result
                            .map((e) => SpinnerItem(
                                id: e.id,
                                name: e.name,
                                item: e,
                                isSelected: request.roleNames.contains(e.name)))
                            .toList();
                        return MyCheckboxWidget(
                          items: list,
                          onSelectGetListItems: (list) {
                            request.roleNames
                              ..clear()
                              ..addAll(list.map((e) => e.name!).toList());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateAdminCubit, CreateAdminInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.admin != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateAdminCubit>()
                            .createAdmin(context, request: request);
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
