import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_models/extensions.dart';  import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/auto_complete_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/accounts/ui/widget/filters/transfers_filter_widget.dart';

import 'package:qareeb_models/global.dart'; import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_transfers_cubit/all_transfers_cubit.dart';

const transfersHeaderTable = [
  'ID',
  'النوع',
  'المرسل',
  'المستقبل',
  'المبلغ',
  'الحالة',
  'التاريخ',
  'عمليات',
];

class TransfersPage extends StatelessWidget {
  const TransfersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DrawableText(
            text: 'المعاملات ',
            matchParent: true,
            size: 28.0.sp,
            textAlign: TextAlign.center,
            padding: const EdgeInsets.symmetric(vertical: 15.0).h,
          ),
          TransfersFilterWidget(
            onApply: (request) {
              context.read<AllTransfersCubit>().getAllTransfers(
                    context,
                    command: context.read<AllTransfersCubit>().state.command
                      ..transferFilterRequest = request,
                  );
            },
          ),
          Expanded(
            child: BlocBuilder<AllTransfersCubit, AllTransfersInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
                return SaedTableWidget(
                    title: transfersHeaderTable,
                    data: state.result.mapIndexed((index, e) {
                      return [
                        e.id.toString(),
                        e.type?.arabicName,
                        e.sourceName,
                        e.destinationName,
                        e.amount.formatPrice,
                        e.status == TransferStatus.closed ? 'تمت' : 'معلقة',
                        e.transferDate?.formatDateTime ?? '',
                        if (e.type != TransferType.payoff && e.type != TransferType.debit)
                          TextButton(
                            onPressed: () {
                              if (e.tripId != 0) {
                                context.pushNamed(GoRouteName.tripInfo,
                                    queryParams: {'id': e.tripId.toString()});
                              } else {
                                context.pushNamed(GoRouteName.sharedTripInfo,
                                    queryParams: {'requestId': e.sharedRequestId.toString()});
                              }
                            },
                            child: const DrawableText(
                              text: 'عرض الرحلة',
                              color: AppColorManager.mainColor,
                            ),
                          ),
                        if (e.type == TransferType.payoff || e.type == TransferType.debit)
                          0.0.verticalSpace,
                      ];
                    }).toList());
              },
            ),
          ),
        ],
      ),
    );
  }
}
