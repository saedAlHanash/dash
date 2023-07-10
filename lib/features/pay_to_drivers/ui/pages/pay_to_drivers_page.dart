import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/drivers/bloc/all_drivers/all_drivers_cubit.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';

const transfersHeaderTable = [
  'ID',
  'النوع',
  'المرسل',
  'المستقبل',
  'المبلغ',
  'الحالة',
  'التاريخ',
];

class PayToDriversPage extends StatefulWidget {
  const PayToDriversPage({super.key});

  @override
  State<PayToDriversPage> createState() => _PayToDriversPageState();
}

class _PayToDriversPageState extends State<PayToDriversPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () {
                var driverId = 0;
                num amount = 0;
                NoteMessage.showCustomBottomSheet(
                  context,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<AllDriversCubit>(),
                      ),
                    ],
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        30.0.verticalSpace,
                        BlocBuilder<AllDriversCubit, AllDriversInitial>(
                          builder: (context, state) {
                            if (state.statuses.loading) {
                              return MyStyle.loadingWidget();
                            }
                            return SpinnerWidget(
                              items: state.getSpinnerItem,
                              onChanged: (spinnerItem) {
                                driverId = spinnerItem.id;
                              },
                            );
                          },
                        ),
                        MyTextFormNoLabelWidget(
                          label: '',
                          onChanged: (p0) => amount = num.tryParse(p0) ?? 0,
                        ),
                      ],
                    ),
                  ),
                  onCancel: (val) {
                    if (val) context.read<GetReasonsCubit>().getReasons(context);
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllTransfersCubit, AllTransfersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تحويلات');
          return Column(
            children: [
              DrawableText(
                text: 'دفعات السائقين ',
                matchParent: true,
                size: 28.0.sp,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
              ),
              SaedTableWidget(
                  title: transfersHeaderTable,
                  data: state.result.mapIndexed((index, e) {
                    return [
                      e.id.toString(),
                      e.type?.getArName ?? '-',
                      e.sourceName,
                      e.destinationName,
                      e.amount.formatPrice,
                      e.status?.name ?? '-',
                      e.transferDate?.formatDateTime ?? '',
                    ];
                  }).toList()),
            ],
          );
        },
      ),
    );
  }
}
