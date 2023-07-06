import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/features/wallet/ui/widget/courses_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../router/app_router.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/my_wallet_cubit/my_wallet_cubit.dart';
import '../widget/charging_list_widget.dart';
import '../widget/payed_list_widget.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletInitial>(
      listenWhen: (previous, current) => current.statuses == CubitStatuses.error,
      listener: (context, state) {
        NoteMessage.showSnakeBar(message: state.error, context: context);
      },
      child: BlocBuilder<WalletCubit, WalletInitial>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemInfoInLine(
                    title: 'رصيد السائق لدى الشركة',
                    info: state.result.totalMoney.toString(),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(
                        GoRouteName.debts,
                        queryParams: {'id': widget.id.toString()},
                      );
                      // Navigator.pushNamed(context, RouteNames.debts);
                    },
                    child: DrawableText(
                      text: 'عائدات الرحلات',
                      underLine: true,
                      color: Colors.grey,
                      drawablePadding: 5.0.w,
                      drawableEnd: const Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              10.0.verticalSpace,
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const GradientContainer(
                            elevation: 0.0,
                            child: DrawableText(
                              text: 'شحنات السائق',
                              color: Colors.white,
                            ),
                          ),
                          ChargingListWidget(wallet: state.result),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const GradientContainer(
                            elevation: 0.0,
                            child: DrawableText(
                              text: 'دفعات الشركة للسائق',
                              color: Colors.white,
                            ),
                          ),
                          PayedListWidget(wallet: state.result),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
