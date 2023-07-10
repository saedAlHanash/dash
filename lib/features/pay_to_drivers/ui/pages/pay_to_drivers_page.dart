import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/drivers/bloc/all_drivers/all_drivers_cubit.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../accounts/bloc/account_amount_cubit/account_amount_cubit.dart';
import '../../../accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';

import '../../bloc/pay_to_cubit/pay_to_cubit.dart';

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
    context
        .read<AllDriversCubit>()
        .getAllDrivers(context, command: Command.noPagination());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () {
                var driverId = 0;
                var type = TransferPayType.driverToCompany;
                num amount = 0;
                NoteMessage.showCustomBottomSheet(
                  context,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<AllDriversCubit>()),
                      BlocProvider.value(value: context.read<PayToCubit>()),
                      BlocProvider.value(value: context.read<AccountAmountCubit>()),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(40.0).r,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          10.0.verticalSpace,
                          Row(
                            children: [
                              ItemInfoInLine(
                                title: 'نوع الدفعة',
                                widget: SpinnerWidget(
                                  items: [
                                    SpinnerItem(id: 0, name: 'من السائق للشركة'),
                                    SpinnerItem(id: 1, name: 'من الشركة للسائق'),
                                  ],
                                  onChanged: (spinnerItem) =>
                                      type = TransferPayType.values[spinnerItem.id],
                                ),
                              ),
                              20.0.horizontalSpace,
                              ItemInfoInLine(
                                title: 'السائق',
                                widget: BlocBuilder<AllDriversCubit, AllDriversInitial>(
                                  builder: (context, state) {
                                    if (state.statuses.loading) {
                                      return MyStyle.loadingWidget();
                                    }
                                    return SpinnerWidget(
                                      items: state.getSpinnerItem
                                        ..insert(
                                          0,
                                          SpinnerItem(
                                            id: -1,
                                            enable: false,
                                            name: 'اختر سائق',
                                          ),
                                        ),
                                      onChanged: (spinnerItem) {
                                        driverId = spinnerItem.id;
                                        context
                                            .read<AccountAmountCubit>()
                                            .getAccountAmount(
                                              context,
                                              driverId: driverId,
                                            );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<AccountAmountCubit, AccountAmountInitial>(
                            builder: (context, state) {
                              if (state.statuses == CubitStatuses.init) {
                                return 0.0.verticalSpace;
                              }
                              if (state.statuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ItemInfoInLine(
                                    title: 'رصيد السائق لدى الشركة',
                                    info: state.driverAmount.formatPrice,
                                  ),

                                  ItemInfoInLine(
                                    title: 'رصيد الشركة لدى السائق',
                                    info: state.companyAmount.formatPrice,
                                  ),
                                ],
                              );
                            },
                          ),
                          MyTextFormNoLabelWidget(
                            label: 'قيمة الدفعة',
                            onChanged: (p0) => amount = num.tryParse(p0) ?? 0,
                          ),
                          BlocConsumer<PayToCubit, PayToInitial>(
                            listenWhen: (p, c) => c.statuses.done,
                            listener: (context, state) => Navigator.pop(context, true),
                            builder: (context, state) {
                              if (state.statuses.loading) {
                                return MyStyle.loadingWidget();
                              }
                              return MyButton(
                                text: 'تسديد',
                                onTap: () {
                                  if (amount == 0) return;
                                  if (driverId == 0) return;
                                  context.read<PayToCubit>().payPayTo(
                                        context,
                                        amount: amount,
                                        driverId: driverId,
                                        type: type,
                                      );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  onCancel: (val) {
                    context.read<AllTransfersCubit>().getAllTransfers(context);
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
          return Column(
            children: [
              DrawableText(
                text: 'دفعات السائقين ',
                matchParent: true,
                size: 28.0.sp,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
              ),
              ItemInfoInLine(
                title: 'فلترة حسب النوع',
                widget: SpinnerWidget(
                    items: [
                      SpinnerItem(
                        id: 2,
                        name: 'من السائق للشركة',
                        enable: state.command.transferFilterRequest.type?.index != 2,
                        isSelected: state.command.transferFilterRequest.type?.index == 2,
                      ),
                      SpinnerItem(
                        id: 3,
                        name: 'من الشركة للسائق',
                        enable: state.command.transferFilterRequest.type?.index != 3,
                        isSelected: state.command.transferFilterRequest.type?.index == 3,
                      ),
                    ],
                    onChanged: (spinnerItem) {
                      state.command.transferFilterRequest.type =
                          TransferType.values[spinnerItem.id];
                      context
                          .read<AllTransfersCubit>()
                          .getAllTransfers(context, command: state.command);
                    }),
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
