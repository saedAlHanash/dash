import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';
import 'package:qareeb_dash/features/drivers/ui/pages/driver_wallet_page.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/item_info.dart';
import '../../../../router/go_route_pages.dart';
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
          if (state.statuses.isLoading) {
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
                    'تاريخ ميلاد': client.birthdate?.formatDate ?? '-',
                    'الجنس': client.gender == 0 ? 'ذكر' : 'أنثى',
                  },
                  title: 'معلومات الزبون',
                ),
                const Divider(),
                30.0.verticalSpace,
                WalletPage(id: client.id, isClient: true),
                const Divider(),
                ItemInfoInLine(
                  title: 'رحلات الزبون',
                  widget: Row(
                    children: [
                      MyButton(
                        text: 'الرحلات العادية',
                        onTap: () {
                          context.pushNamed(
                            GoRouteName.tripsPae,
                            queryParams: {
                              'clientId': state.result.id.toString(),
                              'clientName': state.result.fullName,
                            },
                          );
                        },
                      ),
                      20.horizontalSpace,
                      MyButton(
                        text: 'الرحلات التشاركية',
                        onTap: () {
                          context.pushNamed(
                            GoRouteName.sharedTripsPae,
                            queryParams: {
                              'clientId': state.result.id.toString(),
                              'clientName': state.result.fullName,
                            },
                          );
                        },
                      ),
                    ],
                  ),
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
