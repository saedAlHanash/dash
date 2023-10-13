import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../wallet/bloc/my_wallet_cubit/my_wallet_cubit.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);



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
              ItemInfoInLine(
                title: 'رصيد محفظة الزبون',
                info: state.result.totalMoney.toString(),
              ),
              10.0.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SaedTableWidget(
                      filters: const DrawableText(text: 'مشحونات الزبون'),
                      title: const ['المرسل', 'المستقبل', 'القيمة', 'الحالة', 'التاريخ'],
                      data: state.result.chargings.mapIndexed((i, e) {
                        return [
                          e.chargerName.isEmpty ? e.providerName : e.chargerName,
                          e.userName,
                          e.amount.formatPrice,
                          e.status.arabicName,
                          e.date?.formatDate,
                        ];
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: SaedTableWidget(
                      filters: const DrawableText(text: 'دفعات الزبون'),
                      title: const ['المرسل', 'المستقبل', 'القيمة', 'التاريخ'],
                      data: state.result.transactions.mapIndexed((i, e) {
                        return [
                          e.sourceName,
                          e.destinationName,
                          e.amount.formatPrice,
                          e.transferDate?.formatDate,
                        ];
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
