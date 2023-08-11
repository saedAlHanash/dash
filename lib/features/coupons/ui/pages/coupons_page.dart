import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/change_user_state_btn.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_coupons_vubit/all_coupons_cubit.dart';


final adminsEableHeader = [
  "ID",
  "اسم القسيمة",
  "كود القسية",
  "قيمة الحسم",
  "تاريخ الانتهاء",
  "الحالة",
];

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () {
                context.pushNamed(GoRouteName.createCoupon);
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllCouponsCubit, AllCouponsInitial>(
        builder: (_, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          if (state.result.isEmpty) {
            return const NotFoundWidget(text: 'لا يوجد قسائم');
          }
          final list = state.result;
          return SaedTableWidget(
            command: state.command,
            title: adminsEableHeader,
            data: list
                .mapIndexed(
                  (index, e) => [
                    e.id.toString(),
                    e.couponName,
                    e.couponCode,
                    e.discountValue.toString(),
                    e.expireDate?.formatDate ?? '-',
                    e.isActive ? 'مفعل' : 'غير مفعل',
                  ],
                )
                .toList(),
            onChangePage: (command) {
              context.read<AllCouponsCubit>().getAllCoupons(context, command: command);
            },
          );
        },
      ),
    );
  }
}
