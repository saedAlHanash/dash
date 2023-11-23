import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/companies/data/response/companies_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../drivers/ui/widget/item_image_create.dart';
import '../../bloc/companies_cubit/companies_cubit.dart';
import '../../bloc/create_company_cubit/create_company_cubit.dart';
import '../../data/request/create_company_request.dart';
import '../../data/response/companies_response.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({super.key, this.company});

  final CompanyModel? company;

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  var request = CreateCompanyRequest();

  @override
  void initState() {
    if (widget.company != null) {
      request = CreateCompanyRequest().fromCompany(widget.company!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCompanyCubit, CreateCompanyInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllCompaniesCubit>().getCompanies(context);
        window.history.back();
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
                        nameField: 'ImageFile',
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
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextFormNoLabelWidget(
                        label: 'اسم الشركة',
                        initialValue: request.name,
                        onChanged: (p0) => request.name = p0,
                      ),
                    ),
                    15.0.horizontalSpace,
                    Expanded(
                      child: SpinnerOutlineTitle(
                        label: 'نوع المؤسسة',
                        items: CompanyType.values.spinnerItems(
                          selected: request.type,
                        ),
                        onChanged: (p0) => request.type = p0.item,
                      ),
                    ),
                    15.0.horizontalSpace,
                    Expanded(
                      child: MyTextFormNoLabelWidget(
                        label: 'رقم هاتف',
                        initialValue: request.managerPhone,
                        onChanged: (p0) => request.managerPhone = p0,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateCompanyCubit, CreateCompanyInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.company != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateCompanyCubit>()
                            .createCompany(context, request: request);
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
