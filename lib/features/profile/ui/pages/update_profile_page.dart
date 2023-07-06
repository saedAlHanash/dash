import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/my_style.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pick_image_helper.dart';
import '../../../../core/widgets/images/circle_image_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/top_title_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/profile_info_cubit/profile_info_cubit.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../data/request/update_profile_request.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = UpdateProfileRequest.initial();
    final dateC = TextEditingController();
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
          listenWhen: (p, c) => c.statuses == CubitStatuses.done,
          listener: (context, state) {
            context.read<ProfileInfoCubit>().getProfileInfo(context, newData: true);
            Navigator.pop(context, state.result);
          },
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
          builder: (context, state) {
            if (state.statuses.loading) return MyStyle.loadingWidget();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: .1.sw, vertical: 10.0.h),
              child: MyButton(
                text: AppStringManager.saveEdit,
                width: 1.0.sw,
                elevation: 2.0,
                onTap: () => context.read<UpdateProfileCubit>().updateProfile(
                      context,
                      request: request,
                    ),
              ),
            );
          },
        ),
        body: Column(
          children: [
            const TopTitleWidget(
              safeArea: true,
              text: AppStringManager.profile,
              icon: Assets.iconsHistory,
            ),
            10.0.verticalSpace,
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
              child: Column(
                children: [
                  ///image
                  StatefulBuilder(builder: (context, setState) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final file = await PickImageHelper().pickImage();
                            if (file == null) return;

                            setState(() => request.file = file);
                          },
                          icon: Icon(Icons.edit,
                              color: AppColorManager.mainColor, size: 30.0.r),
                        ),
                        15.0.horizontalSpace,
                        CircleImageWidget(
                          url: request.initialImage,
                          margin: EdgeInsets.only(left: 75.0.r),
                        ),
                      ],
                    );
                  }),

                  10.0.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormNoLabelWidget(
                          label: 'الاسم',
                          initialValue: request.name,
                          onChanged: (val) => request.name = val,
                        ),
                      ),
                      15.0.horizontalSpace,
                      Expanded(
                        child: MyTextFormNoLabelWidget(
                          label: 'الكنية',
                          initialValue: request.surname,
                          onChanged: (val) => request.surname = val,
                        ),
                      ),
                    ],
                  ),
                  MyTextFormNoLabelWidget(
                    label: 'العنوان',
                    initialValue: request.address,
                    onChanged: (val) => request.address = val,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            DrawableText(
                              text: 'الجنس',
                              matchParent: true,
                              color: AppColorManager.mainColor,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                              size: 18.0.sp,
                            ),
                            3.0.verticalSpace,
                            SpinnerWidget(
                              width: 1.0.sw,
                              items: [
                                SpinnerItem(
                                    id: 0, isSelected: request.gender == 0, name: 'ذكر'),
                                SpinnerItem(
                                    id: 1, isSelected: request.gender == 1, name: 'أنثى'),
                              ],
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0.r),
                                border: Border.all(
                                    color: AppColorManager.gray.withOpacity(0.7)),
                              ),
                              onChanged: (item) => request.gender = item.id,
                            ),
                          ],
                        ),
                      ),
                      15.0.horizontalSpace,
                      Expanded(
                        child: Column(
                          children: [
                            DrawableText(
                              text: 'تاريخ الميلاد',
                              matchParent: true,
                              color: AppColorManager.mainColor,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                              size: 18.0.sp,
                            ),
                            3.0.verticalSpace,
                            StatefulBuilder(builder: (context, myState) {
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
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    border: Border.all(
                                        color: AppColorManager.gray.withOpacity(0.7)),
                                  ),
                                  child: Center(
                                    child: DrawableText(
                                      text: request.birthdate?.formatDate ?? '',
                                      color: AppColorManager.gray,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),

                  20.0.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
