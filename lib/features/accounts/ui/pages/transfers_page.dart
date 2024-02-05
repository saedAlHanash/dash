import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/accounts/ui/widget/filters/transfers_filter_widget.dart';
import 'package:qareeb_dash/features/accounts/ui/widget/re_pay_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../bloc/pay_to_cubit/pay_to_cubit.dart';

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

class _TransfersPageState extends State<TransfersPage>
    with SingleTickerProviderStateMixin {
  var loading = false;
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(builder: (context, mState) {
        return FloatingActionBubble(
          // Menu items
          items: [
            Bubble(
              title: "شحن تعويضي",
              iconColor: Colors.white,
              bubbleColor: AppColorManager.mainColor,
              icon: Icons.payments_outlined,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                NoteMessage.showMyDialog(
                  context,
                  child: BlocProvider.value(
                    value: context.read<PayToCubit>(),
                    child: const RePayWidget(),
                  ),
                );
                _animationController.reverse();
              },
            ),
            // Floating action menu item
            Bubble(
              title: loading ? 'جاري التحميل...' : "تحميل ملف إكسل",
              iconColor: Colors.white,
              bubbleColor: AppColorManager.mainColor,
              icon: Icons.file_copy_rounded,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
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
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: AppColorManager.whit,

          // Flaoting Action button Icon
          iconData: Icons.settings,
          backGroundColor: AppColorManager.mainColor,
        );
      }),
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
                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد عمليات');
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
