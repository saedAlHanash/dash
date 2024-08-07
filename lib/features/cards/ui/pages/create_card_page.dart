import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../drivers/ui/widget/item_image_create.dart';
import '../../bloc/cards_cubit/cards_cubit.dart';
import '../../bloc/create_card_cubit/create_card_cubit.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({super.key});

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  CreateCardCubit get cubit => context.read<CreateCardCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCardCubit, CreateCardInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        context.read<CardsCubit>().getCards(newData: true);
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
                      cubit.state.mRequest.file = UploadFile(
                        fileBytes: bytes,
                        nameField: 'Image',
                      );
                    });
                  },
                  image: cubit.state.mRequest.file?.initialImage != null
                      ? cubit.state.mRequest.file!.initialImage!
                      : Assets.iconsCarPlaceHolder,
                  text: 'الصورة',
                  fileBytes: cubit.state.mRequest.file?.fileBytes,
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
                            label: 'اسم البطاقة',
                            initialValue: cubit.state.mRequest.name,
                            onChanged: (p0) => cubit.state.mRequest.name = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'الرصف',
                            initialValue: cubit.state.mRequest.description,
                            onChanged: (p0) => cubit.state.mRequest.description = p0,
                          ),
                        ),
                      ],
                    ),
                    10.0.verticalSpace,
                    MyTextFormNoLabelWidget(
                      label: 'العنوان',
                      initialValue: cubit.state.mRequest.adress,
                      onChanged: (p0) => cubit.state.mRequest.adress = p0,
                      maxLines: 3,
                    ),
                    10.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد البطاقات المتوفرة',
                            initialValue:
                                cubit.state.mRequest.maxActivationCount.toString(),
                            onChanged: (p0) => cubit.state.mRequest.maxActivationCount =
                                num.tryParse(p0),
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'السعر',
                            initialValue: cubit.state.mRequest.price?.formatPrice,
                            onChanged: (p0) =>
                                cubit.state.mRequest.price = num.tryParse(p0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateCardCubit, CreateCardInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: cubit.updateMode ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (cubit.state.mRequest.validateRequest()) {
                        context.read<CreateCardCubit>().createCard();
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
