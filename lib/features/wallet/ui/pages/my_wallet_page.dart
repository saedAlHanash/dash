import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/features/wallet/ui/widget/courses_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../router/app_router.dart';
import '../../bloc/my_wallet_cubit/my_wallet_cubit.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({Key? key}) : super(key: key);

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  late MyWalletCubit myWalletCubit;

  @override
  void initState() {
    myWalletCubit = context.read<MyWalletCubit>()..getMyWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyWalletCubit, MyWalletInitial>(
      listenWhen: (previous, current) => current.statuses == CubitStatuses.error,
      listener: (context, state) {
        NoteMessage.showSnakeBar(message: state.error, context: context);
      },
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: BlocBuilder<MyWalletCubit, MyWalletInitial>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ItemInfoInLine(
                      title: 'رصيدي',
                      info: state.result.totalMoney.toString(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.debts);
                      },
                      child: DrawableText(
                        text: 'السجل',
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
                Expanded(
                  child: WalletScreen(wallet: state.result),
                ),
                MyButton(
                  text: 'شحن رصيد للزبائن',
                  onTap: () async {
                    await Navigator.pushNamed(context, RouteNames.chargeWallet);
                    myWalletCubit.getMyWallet();
                  },
                ),
                10.0.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}
