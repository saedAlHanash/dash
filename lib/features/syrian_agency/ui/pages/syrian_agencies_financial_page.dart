import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/drivers/bloc/all_drivers/all_drivers_cubit.dart';
import 'package:qareeb_dash/features/syrian_agency/bloc/pay_to_syrian_cubit/pay_to_syrian_cubit.dart';
import 'package:qareeb_dash/features/syrian_agency/ui/widget/pay_to_syrian_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/wallet/data/response/single_driver_financial.dart';

import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/financial_report_cubit/financial_report_cubit.dart';
import '../../../accounts/bloc/pay_to_cubit/pay_to_cubit.dart';
import '../../../pay_to_drivers/ui/widget/financial_filter_widget.dart';
import '../../../pay_to_drivers/ui/widget/pay_to_driver_widget.dart';
import '../../bloc/syrian_agencies_financial_report_cubit/syrian_agencies_financial_report_cubit.dart';
import '../../data/response/syrian_agency_financial_report_response.dart';

final transfersHeaderTable = [
  'ID',
  'تاريخ',
  'قيمة الدفعة',
  'نوع الدفعة',
  'ملاحظات',
];

class SyrianAgencyFinancialPage extends StatefulWidget {
  const SyrianAgencyFinancialPage({super.key});

  @override
  State<SyrianAgencyFinancialPage> createState() => _SyrianAgencyFinancialPageState();
}

class _SyrianAgencyFinancialPageState extends State<SyrianAgencyFinancialPage>
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
    return BlocListener<PayToSyrianCubit, PayToSyrianInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) =>
          context.read<SyrianAgenciesFinancialReportCubit>().getReport(context),
      child: Scaffold(
        floatingActionButton: StatefulBuilder(builder: (context, mState) {
          return FloatingActionBubble(
            // Menu items
            items: [
              Bubble(
                title: "محاسبة الهيئة",
                iconColor: Colors.white,
                bubbleColor: AppColorManager.mainColor,
                icon: Icons.payments_outlined,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  NoteMessage.showMyDialog(
                    context,
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: context.read<PayToSyrianCubit>()),
                      ],
                      child: PayToSyrianSyrianWidget(
                        result: context
                            .read<SyrianAgenciesFinancialReportCubit>()
                            .state
                            .result,
                      ),
                    ),
                    onCancel: (val) {},
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
                  context
                      .read<SyrianAgenciesFinancialReportCubit>()
                      .getReportAsync(context)
                      .then(
                    (value) {
                      mState(() => loading = false);
                      _animationController.reverse();
                      if (value == null) return;
                      saveXls(
                        header: value.first,
                        data: value.second,
                        fileName: 'تقرير محاسبة الهيئة ${DateTime.now().formatDate}',
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
              BlocBuilder<SyrianAgenciesFinancialReportCubit,
                  SyrianAgenciesFinancialReportInitial>(
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return Column(
                    children: [
                      SummaryFinancialWidget(result: state.result),
                      10.0.verticalSpace,
                      SaedTableWidget(
                          command: state.command,
                          fullHeight: 1.8.sh,
                          onChangePage: (command) {
                            context
                                .read<FinancialReportCubit>()
                                .getReport(context, command: command);
                          },
                          title: transfersHeaderTable,
                          data: state.result.transactions.mapIndexed(
                            (i, e) {
                              return [
                                e.id.toString(),
                                e.transferDate?.formatDateTime,
                                e.amount.formatPrice,
                                e.type.arabicName,
                                e.note,
                              ];
                            },
                          ).toList()),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryFinancialWidget extends StatelessWidget {
  const SummaryFinancialWidget({super.key, required this.result});

  final SyrianAgencyFinancialReport result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCardWidget(
          elevation: 0.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
          child: Row(
            children: [
              ImageMultiType(
                url: Assets.iconsDriver,
                width: 55.0.r,
                height: 55.0.r,
              ),
              15.0.horizontalSpace,
              DrawableText(
                text: 'مستحقات الهيئة لدى الشركة',
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
              ),
              const Spacer(),
              DrawableText(
                text: result.requiredAmountFromCompany.formatPrice,
                color: Colors.black,
                fontFamily: FontManager.cairoBold.name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
