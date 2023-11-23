import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/features/car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import 'package:qareeb_dash/features/car_catigory/data/response/car_categories_response.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/car_catigory/data/response/car_categories_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../drivers/ui/widget/item_image_create.dart';
import '../../bloc/create_car_category_cubit/create_car_category_cubit.dart';
import '../../data/request/create_car_category_request.dart';

class CreateCarCategoryPage extends StatefulWidget {
  const CreateCarCategoryPage({super.key, this.carCat});

  final CarCategory? carCat;

  @override
  State<CreateCarCategoryPage> createState() => _CreateCarCategoryPageState();
}

class _CreateCarCategoryPageState extends State<CreateCarCategoryPage> {
  var request = CreateCarCatRequest();

  @override
  void initState() {
    if (widget.carCat != null) {
      request = CreateCarCatRequest().fromCarCategory(widget.carCat!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCarCategoryCubit, CreateCarCategoryInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<AllCarCategoriesCubit>().getCarCategories(context);
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'تصنيف السيارات ',
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
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'اسم التصنيف',
                            initialValue: request.name,
                            onChanged: (p0) {
                              request.name = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد المقاعد الافتراضي',
                            initialValue: request.seatNumber?.toString(),
                            onChanged: (p0) {
                              request.seatNumber = int.tryParse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    DrawableText(
                      text: 'الرحلات التشاركية',
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
                            label: 'سعر الكيلو متر (عدد صحيح بدون فاصلة)',
                            initialValue: request.sharedKMOverCost?.toString(),
                            onChanged: (p0) {
                              request.sharedKMOverCost = int.tryParse(p0);
                              request.nightSharedKMOverCost = int.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة السائق من الرحلات (1 -> 100) %',
                            initialValue: request.sharedDriverRatio?.toString(),
                            onChanged: (p0) {
                              request.sharedDriverRatio = double.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'أقل مسافة مسار للرحلة التشاركية (متر)',
                            initialValue:
                                request.sharedMinimumDistanceInMeters?.toString(),
                            onChanged: (p0) {
                              request.sharedMinimumDistanceInMeters = double.tryParse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء الزيت ',
                            initialValue: request.sharedOilRatio?.toString(),
                            onChanged: (p0) {
                              request.sharedOilRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء الذهب',
                            initialValue: request.sharedGoldRatio?.toString(),
                            onChanged: (p0) {
                              request.sharedGoldRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء الإطارات',
                            initialValue: request.sharedTiresRatio?.toString(),
                            onChanged: (p0) {
                              request.sharedTiresRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء البنزين',
                            initialValue: request.sharedGasRatio?.toString(),
                            onChanged: (p0) {
                              request.sharedGasRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                    DrawableText(
                      text: 'الرحلات العادية',
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
                            label: 'سعر الكيلو متر (عدد صحيح بدون فاصلة)',
                            initialValue: request.dayKMOverCost?.toString(),
                            onChanged: (p0) {
                              request.dayKMOverCost = int.tryParse(p0);
                              request.nightKMOverCost = int.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'أقل كلفة للرحلة (عدد صحيح بدون فاصلة)',
                            initialValue: request.minimumDayPrice?.toString(),
                            onChanged: (p0) {
                              request.minimumDayPrice = double.tryParse(p0);
                              request.minimumNightPrice = double.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة السائق من الرحلات (1 -> 100) %',
                            initialValue: request.driverRatio?.toString(),
                            onChanged: (p0) {
                              request.driverRatio = double.tryParse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء الزيت ',
                            initialValue: request.normalOilRatio?.toString(),
                            onChanged: (p0) {
                              request.normalOilRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء الذهب',
                            initialValue: request.normalGoldRatio?.toString(),
                            onChanged: (p0) {
                              request.normalGoldRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء الإطارات',
                            initialValue: request.normalTiresRatio?.toString(),
                            onChanged: (p0) {
                              request.normalTiresRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة ولاء البنزين',
                            initialValue: request.normalGasRatio?.toString(),
                            onChanged: (p0) {
                              request.normalGasRatio = num.tryParse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                    DrawableText(
                      text: 'الاشتراكات',
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
                            label: 'سعر الكيلو متر (عدد صحيح بدون فاصلة)',
                            initialValue: request.planKmCost?.toString(),
                            onChanged: (p0) {
                              request.planKmCost = int.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'أقل كلفة للرحلة (عدد صحيح بدون فاصلة)',
                            initialValue: request.planMinimumCost?.toString(),
                            onChanged: (p0) {
                              request.planMinimumCost = double.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'نسبة السائق من الرحلات (1 -> 100) %',
                            initialValue: request.planDriverRation?.toString(),
                            onChanged: (p0) {
                              request.planDriverRation = double.tryParse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                    MyTextFormNoLabelWidget(
                      label: 'متغير السعر',
                      initialValue: request.priceVariant?.toString(),
                      onChanged: (p0) {
                        request.priceVariant = num.tryParse(p0);
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateCarCategoryCubit, CreateCarCategoryInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.carCat != null ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateCarCategoryCubit>()
                            .createCarCategory(context, request: request);
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
