import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/accounts/ui/widget/filters/transfers_filter_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/file_util.dart';
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

class TransfersPage extends StatefulWidget {
  const TransfersPage({super.key});

  @override
  State<TransfersPage> createState() => _TransfersPageState();
}

class _TransfersPageState extends State<TransfersPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(
        builder: (context, mState) {
          return FloatingActionButton(
            onPressed: () {
              mState(() => loading = true);
              context.read<AllTransfersCubit>().getDataAsync(context).then(
                (value) {
                  if (value == null) return;
                  saveXls(
                    header: value.first,
                    data: value.second,
                    fileName: 'تقرير التحويلات المالية${DateTime.now().formatDate}',
                  );

                  mState(
                    () => loading = false,
                  );
                },
              );
            },
            child: loading
                ? const CircularProgressIndicator.adaptive()
                : const Icon(Icons.file_download, color: Colors.white),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 200.0).h,
        child: Column(
          children: [
            TransfersFilterWidget(
              onApply: (request) {
                context.read<AllTransfersCubit>().getAllTransfers(
                      context,
                      command: context.read<AllTransfersCubit>().state.command.copyWith(
                            transferFilterRequest: request,
                            skipCount: 0,
                            totalCount: 0,
                          ),
                    );
              },
            ),
            BlocBuilder<AllTransfersCubit, AllTransfersInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
                return SaedTableWidget(
                    command: state.command,
                    fullHeight: 1.5.sh,
                    onChangePage: (command) {
                      context
                          .read<AllTransfersCubit>()
                          .getAllTransfers(context, command: command);
                    },
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
                        if (e.type == TransferType.sharedPay ||
                            e.type == TransferType.tripPay)
                          TextButton(
                            onPressed: () {
                              if (e.tripId != 0) {
                                context.pushNamed(GoRouteName.tripInfo,
                                    queryParams: {'id': e.tripId.toString()});
                              } else {
                                context.pushNamed(GoRouteName.sharedTripInfo,
                                    queryParams: {
                                      'requestId': e.sharedRequestId.toString()
                                    });
                              }
                            },
                            child: const DrawableText(
                              selectable: false,
                              text: 'عرض الرحلة',
                              color: AppColorManager.mainColor,
                            ),
                          )
                        else
                          e.note.isEmpty ? 0.0.verticalSpace : e.note,
                      ];
                    }).toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
