import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/wallet/ui/pages/my_wallet_page.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../drivers/ui/pages/driver_info_page.dart';
import '../../bloc/clients_by_id_cubit/clients_by_id_cubit.dart';

class ClientInfoPage extends StatelessWidget {
  const ClientInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'معلومات الزبون',
      ),
      body: BlocBuilder<ClientByIdCubit, ClientByIdInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final client = state.result;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 120.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.0.verticalSpace,
                Center(
                  child: ItemImage(image: client.avatar, text: 'الصورة الشخصية'),
                ),
                30.0.verticalSpace,
                MyTableWidget(
                  children: {
                    'اسم ': client.fullName,
                    'العنوان ': client.address,
                    'رقم هاتف  ': client.phoneNumber,
                    'تاريخ ميلاد': client.birthdate?.formatDate??'-',
                    'الجنس': client.gender == 0 ? 'ذكر' : 'أنثى',
                  },
                  title: 'معلومات الزبون',
                ),
                const Divider(),
                30.0.verticalSpace,
                SizedBox(
                  height: 300.0.h,
                  child: WalletPage(id: client.id,isClient: true),
                ),
                150.0.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}
