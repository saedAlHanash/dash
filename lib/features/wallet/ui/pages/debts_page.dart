import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../bloc/debt_cubit/debts_cubit.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'سجل عائدات السائق من الرحلات',
      ),
      body: BlocBuilder<DebtsCubit, DebtsInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) {
            return const NotFoundWidget(text: 'السجل فارغ');
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final item = list[i];
              return MyCardWidget(
                elevation: 0.0,
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: DrawableText(
                        text: item.sharedRequestId != 0
                            ? 'رحلة تشاركية (id ${item.sharedRequestId})'
                            : 'رحلة عادية (id  ${item.tripId})',
                        color: Colors.black,
                        matchParent: true,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        text: 'الإجمالي: ${item.totalCost.formatPrice}',
                        color: Colors.black,
                        matchParent: true,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    Expanded(
                      child: DrawableText(
                        text: 'للسائق: ${item.driverShare.formatPrice}',
                        color: Colors.black,
                        matchParent: true,
                        fontFamily: FontManager.cairoBold,
                      ),
                    ),
                    if (item.companyLoyaltyShare != 0)
                      Expanded(
                        child: DrawableText(
                          text: 'للولاء: ${item.companyLoyaltyShare.formatPrice}',
                          color: Colors.black,
                          matchParent: true,
                          fontFamily: FontManager.cairoBold,
                        ),
                      ),
                    Expanded(
                      child: DrawableText(
                        text: item.date?.formatDateTime ?? '',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
