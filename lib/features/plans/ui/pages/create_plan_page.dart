import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/plans/data/response/plans_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../drivers/ui/widget/item_image_create.dart';
import '../../bloc/create_plan_cubit/create_plan_cubit.dart';
import '../../bloc/plans_cubit/plans_cubit.dart';
import '../../data/request/create_plan_request.dart';
import '../../data/response/plans_response.dart';

class CreatePlanPage extends StatefulWidget {
  const CreatePlanPage({super.key, this.plan});

  final PlanModel? plan;

  @override
  State<CreatePlanPage> createState() => _CreatePlanPageState();
}

class _CreatePlanPageState extends State<CreatePlanPage> {
  var request = CreatePlanRequest();

  @override
  void initState() {
    if (widget.plan != null) {
      request = CreatePlanRequest().fromPlan(widget.plan!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePlanCubit, CreatePlanInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllPlansCubit>().getPlans(context);
        window.history.back();
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'الخطط',
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'اسم الخطة',
                            initialValue: request.name,
                            onChanged: (p0) => request.name = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: SpinnerWidget(
                            expanded: true,
                            items: PlanType.values.spinnerItems(selected: request.type),
                            onChanged: (p0) => request.type = p0.item,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'وصف مختصر',
                            initialValue: request.description,
                            onChanged: (p0) => request.description = p0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'سعر الخطة',
                            initialValue: request.price?.toString(),
                            onChanged: (p0) => request.price = num.tryParse(p0),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: ' أقصى طول للمسارات - بالمتر',
                            initialValue: request.maxPathMeters?.toString(),
                            onChanged: (p0) => request.maxPathMeters = num.tryParse(p0),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد أيام الخطة',
                            initialValue: request.activationDayNumber?.toString(),
                            onChanged: (p0) =>
                                request.activationDayNumber = num.tryParse(p0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد مرات الركوب الشهري',
                            initialValue: request.maxMonthlyUsage?.toString(),
                            onChanged: (p0) => request.maxMonthlyUsage = num.tryParse(p0),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد مرات الركوب خلال اليوم',
                            initialValue: request.maxDailyUsage?.toString(),
                            onChanged: (p0) => request.maxDailyUsage = num.tryParse(p0),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'رصيد الكيلومترات    * بالمتر',
                            initialValue: request.maxMeters?.toString(),
                            onChanged: (p0) => request.maxMeters = num.tryParse(p0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreatePlanCubit, CreatePlanInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.plan != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreatePlanCubit>()
                            .createPlan(context, request: request);
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
