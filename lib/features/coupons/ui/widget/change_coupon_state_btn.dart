import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/util/checker_helper.dart';
import 'package:qareeb_dash/features/coupons/data/response/coupons_response.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../bloc/change_coupon_state_cubit/change_coupon_state_cubit.dart';

class ChangeCouponStateBtn extends StatelessWidget {
  const ChangeCouponStateBtn({super.key, required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    if (!isAllowed(AppPermissions.UPDATE)) return 0.0.verticalSpace;
    return BlocBuilder<ChangeCouponStateCubit, ChangeCouponStateInitial>(
      buildWhen: (p, c) => c.id == coupon.id,
      builder: (context, state) {
        if (state.statuses.isLoading) {
          return MyStyle.loadingWidget();
        }

        if (state.statuses.isDone) coupon.isActive = !coupon.isActive;

        return InkWell(
          onTap: () {
            context
                .read<ChangeCouponStateCubit>()
                .changeCouponState(context, id: coupon.id);
          },
          child: CircleButton(
            color: coupon.isActive ? Colors.red : Colors.green,
            icon: coupon.isActive ? Icons.cancel_outlined : Icons.check_circle_outline,
          ),
        );
      },
    );
  }
}
