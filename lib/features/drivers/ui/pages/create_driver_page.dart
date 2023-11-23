import "package:universal_html/html.dart";

import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/features/drivers/data/request/cretae_driver_request.dart';
import 'package:qareeb_dash/features/drivers/data/response/drivers_response.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../agencies/bloc/agencies_cubit/agencies_cubit.dart';
import '../../../car_catigory/bloc/all_car_categories_cubit/all_car_categories_cubit.dart';
import '../../bloc/all_drivers/all_drivers_cubit.dart';
import '../../bloc/create_driver_cubit/create_driver_cubit.dart';
import '../widget/item_image_create.dart';

class CreateDriverPage extends StatefulWidget {
  const CreateDriverPage({super.key, this.driver});

  final DriverModel? driver;

  @override
  State<CreateDriverPage> createState() => _CreateDriverPageState();
}

class _CreateDriverPageState extends State<CreateDriverPage> {
  var request = CreateDriverRequest();

  @override
  void initState() {
    if (widget.driver != null) request = CreateDriverRequest.fromDriver(widget.driver!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateDriverCubit, CreateDriverInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        window.history.back();
        context.read<AllDriversCubit>().getAllDrivers(context);
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'إنشاء سائق',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.0.verticalSpace,
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemImageCreate(
                      onLoad: (bytes) {
                        setState(() {
                          request.imageFile = UploadFile(
                            fileBytes: bytes,
                            nameField: 'ImageFile',
                          );
                        });
                      },
                      image: request.imageFile?.initialImage != null
                          ? request.imageFile!.initialImage!
                          : Assets.iconsUser,
                      text: 'الصورة الشخصية',
                      fileBytes: request.imageFile?.fileBytes,
                    ),
                    ItemImageCreate(
                      onLoad: (bytes) {
                        setState(() {
                          request.identityFile = UploadFile(
                            fileBytes: bytes,
                            nameField: 'IdentityFile',
                          );
                        });
                      },
                      image: request.identityFile?.initialImage != null
                          ? request.identityFile!.initialImage!
                          : Assets.iconsIdentity,
                      text: 'صورة الهوية',
                      fileBytes: request.identityFile?.fileBytes,
                    ),
                    ItemImageCreate(
                      onLoad: (bytes) {
                        setState(() {
                          request.contractFile = UploadFile(
                            fileBytes: bytes,
                            nameField: 'ContractFile',
                          );
                        });
                      },
                      image: request.contractFile?.initialImage != null
                          ? request.contractFile!.initialImage!
                          : Assets.iconsContract,
                      text: 'صورة العقد',
                      fileBytes: request.contractFile?.fileBytes,
                    ),
                    ItemImageCreate(
                      onLoad: (bytes) {
                        setState(() {
                          request.drivingLicenceFile = UploadFile(
                            fileBytes: bytes,
                            nameField: 'DrivingLicenceFile',
                          );
                        });
                      },
                      image: request.drivingLicenceFile?.initialImage != null
                          ? request.drivingLicenceFile!.initialImage!
                          : Assets.iconsDrivingLicence,
                      text: 'رخصة القيادة',
                      fileBytes: request.drivingLicenceFile?.fileBytes,
                    ),
                    ItemImageCreate(
                      onLoad: (bytes) {
                        setState(() {
                          request.carMechanicFile = UploadFile(
                            fileBytes: bytes,
                            nameField: 'CarMechanicFile',
                          );
                        });
                      },
                      image: request.carMechanicFile?.initialImage != null
                          ? request.carMechanicFile!.initialImage!
                          : Assets.iconsDrivingLicence,
                      text: 'ميكانيك السيارة',
                      fileBytes: request.carMechanicFile?.fileBytes,
                    ),
                    ItemImageCreate(
                      onLoad: (bytes) {
                        setState(() {
                          request.examinationFile = UploadFile(
                            fileBytes: bytes,
                            nameField: 'ExaminationFile',
                          );
                        });
                      },
                      image: request.examinationFile?.initialImage != null
                          ? request.examinationFile!.initialImage!
                          : Assets.iconsExamination,
                      text: 'فحص السيارة',
                      fileBytes: request.examinationFile?.fileBytes,
                    ),
                  ],
                ),
              ),
              MyCardWidget(
                cardColor: AppColorManager.f1,
                margin: const EdgeInsets.symmetric(vertical: 30.0).h,
                child: Column(
                  children: [
                    DrawableText(
                      text: 'معلومات السائق',
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
                            label: 'اسم السائق',
                            initialValue: request.name,
                            onChanged: (p0) {
                              request.name = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'كنية السائق',
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
                        Expanded(
                          child: SpinnerWidget(
                            items: [
                              SpinnerItem(
                                  name: 'ذكر',
                                  id: 0,
                                  isSelected: request.gender.index == 0),
                              SpinnerItem(
                                  name: 'أنثى',
                                  id: 1,
                                  isSelected: request.gender.index == 1),
                            ],
                            width: 1.0.sw,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0.spMin, color: AppColorManager.gray),
                              borderRadius: BorderRadius.circular(12.0.r),
                            ),
                            onChanged: (spinnerItem) {
                              request.gender = Gender.values[spinnerItem.id];
                            },
                          ),
                        ),
                        if (!isAgency) 15.0.horizontalSpace,
                        if (!isAgency)
                          Expanded(
                            child: BlocBuilder<AgenciesCubit, AgenciesInitial>(
                              builder: (context, state) {
                                if (state.statuses.isLoading) {
                                  return MyStyle.loadingWidget();
                                }
                                return SpinnerWidget(
                                  items:
                                      state.getSpinnerItems(selectedId: request.agencyId)
                                        ..insert(
                                          0,
                                          SpinnerItem(
                                              name: 'الوكيل',
                                              item: null,
                                              id: -1,
                                              isSelected: request.agencyId == null),
                                        ),
                                  width: 1.0.sw,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0.spMin, color: AppColorManager.gray),
                                    borderRadius: BorderRadius.circular(12.0.r),
                                  ),
                                  onChanged: (spinnerItem) {
                                    request.agencyId = spinnerItem.id;
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                    const Divider(),
                    DrawableText(
                      text: 'معلومات السيارة',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold,
                    ),
                    StatefulBuilder(
                      builder: (context, mState) {
                        return CheckboxListTile(
                          title: const DrawableText(
                            text: 'هل تم فحص السيارة؟',
                            selectable: false,
                            color: Colors.black,
                          ),
                          value: request.isExamined ?? false,
                          onChanged: (value) {
                            mState(() => request.isExamined = value);
                          },
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'ماركة السيارة',
                            initialValue: request.carBrand,
                            onChanged: (p0) {
                              request.carBrand = p0;
                              request.carModel = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'لون السيارة',
                            initialValue: request.carColor,
                            onChanged: (p0) {
                              request.carColor = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد مقاعد السيارة',
                            initialValue: request.seatsNumber?.toString(),
                            onChanged: (p0) {
                              request.seatsNumber = num.tryParse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'محافظة السيارة',
                            initialValue: request.carGovernorate,
                            onChanged: (p0) {
                              request.carGovernorate = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'سنة الصنع',
                            initialValue: request.manufacturingYear,
                            onChanged: (p0) {
                              request.manufacturingYear = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'التصنيف الحكومي',
                            initialValue: request.type,
                            onChanged: (p0) {
                              request.type = p0;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'رقم السيارة',
                            initialValue: request.carNumber,
                            onChanged: (p0) {
                              request.carNumber = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'IMEI',
                            initialValue: request.imei,
                            onChanged: (p0) {
                              request.imei = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child:
                              BlocBuilder<AllCarCategoriesCubit, AllCarCategoriesInitial>(
                            builder: (context, state) {
                              if (state.statuses.isLoading) {
                                return MyStyle.loadingWidget();
                              }
                              final list = state.result.mapIndexed(
                                (i, e) {
                                  return SpinnerItem(
                                    id: e.id,
                                    name: e.name,
                                    item: e,
                                    isSelected: e.id == request.carCategoryID,
                                  );
                                },
                              ).toList()
                                ..insert(0, SpinnerItem(name: 'تصنيف السيارة', id: -1));
                              return SpinnerWidget(
                                items: list,
                                width: 1.0.sw,
                                onChanged: (spinnerItem) {
                                  request.carCategoryID = spinnerItem.id;
                                },
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0.spMin, color: AppColorManager.gray),
                                  borderRadius: BorderRadius.circular(12.0.r),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateDriverCubit, CreateDriverInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.driver != null ? 'تعديل' : 'إنشاء السائق',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateDriverCubit>()
                            .createDriver(context, request: request);
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
