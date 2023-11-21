import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? number;
  final controllerText = TextEditingController();
  var loading = false;

  @override
  void initState() {
    number = int.tryParse(AppSharedPreference.getTotalCount.toString());
    controllerText.text = AppSharedPreference.getTotalCount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormNoLabelWidget(
                          label: 'العدد الأعظمي للنتائج في الصفحة',
                          controller: controllerText,
                          onChanged: (p0) {
                            number = int.tryParse(p0);
                            if (number == null) {
                              controllerText.text = '40';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  10.0.verticalSpace,
                ],
              ),
            ),
            if (loading)
              MyStyle.loadingWidget()
            else
              MyButton(
                text: 'تعديل',
                onTap: () {
                  AppSharedPreference.cashTotalCount(number);
                  setState(() => loading = true);
                  Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      setState(() => loading = false);
                      NoteMessage.showSuccessSnackBar(
                          message: 'تم التعديل', context: context);
                    },
                  );
                },
              ),
            20.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
