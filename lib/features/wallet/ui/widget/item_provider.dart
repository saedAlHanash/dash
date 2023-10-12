import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qareeb_models/e_pay/data/response/epay_response.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../bloc/change_provider_state_cubit/change_provider_state_cubit.dart';

class ItemProvider extends StatelessWidget {
  const ItemProvider({super.key, required this.item});

  final EpayItem item;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: Row(
        children: [
          RoundImageWidget(
            url: item.imageUrl,
            height: 70.0.r,
            width: 70.0.r,
          ),
          10.0.horizontalSpace,
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'ID',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'الاسم',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'النوع',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'الحالة',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        size: 18.0.sp,
                        matchParent: true,
                        textAlign: TextAlign.center,
                        text: 'العمليات',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.id.toString(),
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.name,
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.isWebView ? 'صفحة ويب' : 'OTP',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        matchParent: true,
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.isActive ? 'فعال' : 'متوقف',
                        color: Colors.black,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<ChangeProviderStateCubit,
                          ChangeProviderStateInitial>(
                        buildWhen: (p, c) => c.id == item.id,
                        builder: (context, state) {
                          if (state.statuses.isLoading) {
                            return MyStyle.loadingWidget();
                          }
                          if (state.statuses.isDone) item.isActive = !item.isActive;

                          return InkWell(
                            onTap: () {
                              context
                                  .read<ChangeProviderStateCubit>()
                                  .changeProviderState(context,
                                      id: item.id, providerState: !item.isActive);
                            },
                            child: CircleButton(
                              color: item.isActive ? Colors.red : Colors.green,
                              icon: item.isActive
                                  ? Icons.cancel_outlined
                                  : Icons.check_circle_outline,
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
        ],
      ),
    );
  }
}
