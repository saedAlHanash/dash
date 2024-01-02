import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_models/extensions.dart';
import "package:universal_html/html.dart";

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../bloc/all_coupons_vubit/all_coupons_cubit.dart';
import '../../bloc/create_coupon_cubit/create_coupon_cubit.dart';
import '../../data/response/coupons_response.dart';

class CreateCouponPage extends StatefulWidget {
  const CreateCouponPage({super.key, this.coupon});

  final Coupon? coupon;

  @override
  State<CreateCouponPage> createState() => _CreateCouponPageState();
}

class _CreateCouponPageState extends State<CreateCouponPage> {
  var request = Coupon.fromJson({'isActive':true});

  @override
  void initState() {
    if (widget.coupon != null) request = widget.coupon!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCouponCubit, CreateCouponInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        window.history.back();
        context.read<AllCouponsCubit>().getAllCoupons(context);
      },
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'إنشاء قسيمة حسم ',
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
                      text: 'معلومات قسيمة الحسم',
                      size: 25.0.sp,
                      padding: const EdgeInsets.symmetric(vertical: 30.0).h,
                      matchParent: true,
                      textAlign: TextAlign.center,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                    10.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: StatefulBuilder(builder: (context, myState) {
                            return InkWell(
                              onTap: () async {
                                final pick = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().addFromNow(month: 2),
                                );
                                myState(() => request.expireDate = pick);
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
                                    text: request.expireDate == null
                                        ? 'تاريخ الانتهاء'
                                        : request.expireDate?.formatDate ?? '',
                                    color: AppColorManager.gray,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'قيمة الحسم',
                            initialValue: request.discountValue?.toString(),
                            onChanged: (p0) {
                              request.discountValue = num.tryParse(p0);
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'كود القسيمة',
                            initialValue: request.couponCode,
                            onChanged: (p0) {
                              request.couponCode = p0;
                            },
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عدد مرات التفعيل',
                            initialValue: request.couponCode,
                            onChanged: (p0) {
                              request.maxActivation = int.parse(p0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<CreateCouponCubit, CreateCouponInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: widget.coupon?.id != 0 ? 'تعديل' : 'إنشاء',
                    onTap: () {
                      if (request.validateRequest(context)) {
                        context
                            .read<CreateCouponCubit>()
                            .createCoupon(context, request: request);
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
