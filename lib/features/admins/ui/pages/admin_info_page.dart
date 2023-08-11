import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_checkbox_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
 import 'package:qareeb_dash/core/widgets/spinner_widget.dart'; import 'package:qareeb_models/global.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../drivers/data/response/drivers_response.dart';
import '../../data/request/create_admin_request.dart';
import '../../data/response/admins_response.dart';

class AdminInfoPage extends StatefulWidget {
  const AdminInfoPage({super.key, required this.admin});

  final DriverModel admin;

  @override
  State<AdminInfoPage> createState() => AdminInfoPageState();
}

class AdminInfoPageState extends State<AdminInfoPage> {
  var request = CreateAdminRequest();

  @override
  void initState() {
    request = CreateAdminRequest.fromAdmin(widget.admin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          enable: false,
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
                          enable: false,
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
                          enable: false,
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
                          enable: false,
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
                          enable: false,
                          label: 'البريد الإلكتروني',
                          initialValue: request.emailAddress,
                          onChanged: (p0) => request.emailAddress = p0,
                        ),
                      ),
                      15.0.horizontalSpace,
                      Expanded(
                        child: MyTextFormNoLabelWidget(
                          enable: false,
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
                  Builder(
                    builder: (context) {
                      final list =
                          request.roleNames.map((e) => SpinnerItem(name: e)).toList();
                      return MyCheckboxWidget(
                        items: list,
                      );
                    },
                  ),
                ],
              ),
            ),
            20.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
