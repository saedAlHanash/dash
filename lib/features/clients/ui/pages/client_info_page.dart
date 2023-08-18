import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/table_widget.dart';


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
                    'تاريخ ميلاد': client.birthdate?.formatDate ?? '-',
                    'الجنس': client.gender == 0 ? 'ذكر' : 'أنثى',
                  },
                  title: 'معلومات الزبون',
                ),
                const Divider(),
                30.0.verticalSpace,

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
                              'name': state.result.fullName,
                            },
                          );
                        },
                      ),
                      20.horizontalSpace,
                      MyButton(
                        text: 'الرحلات التشاركية',
                        onTap: () {

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