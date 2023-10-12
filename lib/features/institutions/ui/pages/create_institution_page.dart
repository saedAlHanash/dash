import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../drivers/ui/widget/item_image_create.dart';
import '../../bloc/all_institutions_cubit/all_institutions_cubit.dart';
import '../../bloc/create_institution_cubit/create_institution_cubit.dart';
import '../../data/request/create_institution_request.dart';
import '../../data/response/institutions_response.dart';

class CreateInstitutionPage extends StatefulWidget {
  const CreateInstitutionPage({super.key, this.institution});

  final InstitutionModel? institution;

  @override
  State<CreateInstitutionPage> createState() => _CreateInstitutionPageState();
}

class _CreateInstitutionPageState extends State<CreateInstitutionPage> {
  var request = CreateInstitutionRequest();

  @override
  void initState() {
    if (widget.institution != null) {
      request = CreateInstitutionRequest().fromInstitution(widget.institution!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateInstitutionCubit, CreateInstitutionInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllInstitutionsCubit>().getInstitutions(context);
       context.pop();
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'المؤسسات',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.0.verticalSpace,
              Center(
                child: ItemImageCreate(
                  onLoad: (bytes) {
                    setState(() {
                      request.file = UploadFile(
                        fileBytes: bytes,
                        nameField: 'File',
                      );
                    });
                  },
                  image: request.file?.initialImage != null
                      ? request.file!.initialImage!
                      : Assets.iconsCarPlaceHolder,
                  text: 'الصورة',
                  fileBytes: request.file?.fileBytes,
                ),
              ),
              MyCardWidget(
                cardColor: AppColorManager.f1,
                margin: const EdgeInsets.symmetric(vertical: 30.0).h,
                child: Column(
                  children: [
                    MyTextFormNoLabelWidget(
                      label: 'اسم المؤسسة',
                      initialValue: request.name,
                      onChanged: (p0) => request.name = p0,
                    ),
                    const Divider(),
                    if (request.id == null)
                      Column(
                        children: [
                          DrawableText(
                            text: 'المدير',
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
                                  initialValue: request.adminFirstName,
                                  onChanged: (p0) {
                                    request.adminFirstName = p0;
                                  },
                                ),
                              ),
                              15.0.horizontalSpace,
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'كنية المدير',
                                  initialValue: request.adminSurname,
                                  onChanged: (p0) {
                                    request.adminSurname = p0;
                                  },
                                ),
                              ),
                              15.0.horizontalSpace,
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'عنوان المدير',
                                  initialValue: request.address,
                                  onChanged: (p0) {
                                    request.address = p0;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'بريد المدير',
                                  initialValue: request.emailAddress,
                                  onChanged: (p0) => request.emailAddress = p0,
                                ),
                              ),
                              15.0.horizontalSpace,
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'رقم الهاتف',
                                  initialValue: request.phoneNumber,
                                  onChanged: (p0) => request.phoneNumber = p0,
                                ),
                              ),
                              15.0.horizontalSpace,
                              Expanded(
                                child: MyTextFormNoLabelWidget(
                                  label: 'كلمة المرور',
                                  obscureText: true,
                                  initialValue: request.password,
                                  onChanged: (p0) {
                                    request.password = p0;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    DrawableText(
                      text: 'ملحقات المؤسسة',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SpinnerOutlineTitle(
                            label: 'المحافظة',
                            items: Governorate.values.spinnerItems(
                              selected: request.government,
                            ),
                            onChanged: (p0) => request.government = p0.item,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: SpinnerOutlineTitle(
                            label: 'نوع المؤسسة',
                            items: InstitutionType.values.spinnerItems(
                              selected: request.type,
                            ),
                            onChanged: (p0) => request.type = p0.item,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'مفتاح أثر',
                            initialValue: request.atharKey,
                            onChanged: (p0) => request.atharKey = p0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateInstitutionCubit, CreateInstitutionInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.institution != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateInstitutionCubit>()
                            .createInstitution(context, request: request);
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
