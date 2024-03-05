import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/features/accounts/data/request/transfer_filter_request.dart';
import 'package:qareeb_dash/generated/assets.dart';
import 'package:qareeb_models/agencies/data/response/agencies_financial_response.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';
import 'package:qareeb_models/trip_process/data/response/trip_response.dart';
import 'package:qareeb_models/wallet/data/response/debt_response.dart';
import 'package:qareeb_models/wallet/data/response/driver_financial_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../../accounts/bloc/all_charging_cubit/all_charging_cubit.dart';
import '../../../accounts/bloc/all_transfers_cubit/all_transfers_cubit.dart';
import '../../../accounts/bloc/driver_financial_cubit/driver_financial_cubit.dart';
import '../../../accounts/bloc/reverse_charging_cubit/reverse_charging_cubit.dart';
import '../../../accounts/ui/pages/transfers_page.dart';
import '../../data/response/drivers_response.dart';

class DriverChargingWidget extends StatefulWidget {
  const DriverChargingWidget({super.key, required this.driver});

  final DriverModel driver;
  @override
  State<DriverChargingWidget> createState() => _DriverChargingWidgetState();
}

class _DriverChargingWidgetState extends State<DriverChargingWidget> {
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(
        builder: (context, mState) {
          return FloatingActionButton(
            onPressed: () {
              mState(() => loading = true);
              context.read<AllChargingCubit>().getDataAsync(context).then(
                    (value) {
                  if (value == null) return;
                  saveXls(
                    header: value.first,
                    data: value.second,
                    fileName:
                    'تقرير شحنات السائق  ${widget.driver.fullName} ${DateTime.now().formatDate}',
                  );
                  mState(
                        () => loading = false,
                  );
                },
              );
            },
            child: loading
                ? const CircularProgressIndicator.adaptive(backgroundColor: Colors.white)
                : const Icon(Icons.file_download, color: Colors.white),
          );
        },
      ),
      body: BlocBuilder<AllChargingCubit, AllChargingInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          return SingleChildScrollView(
            child: SaedTableWidget(
              filters: const DrawableText(
                text: 'شحنات السائق\n',
              ),
              title: const [
                'المرسل',
                'المستقبل',
                'القيمة',
                'الحالة',
                'التاريخ',
              ],
              data: state.result.mapIndexed((i, e) {
                return [
                  e.chargerName.isEmpty ? e.providerName : e.chargerName,
                  e.userName,
                  e.amount == 0 ? 'عملية استرجاع' : e.amount.formatPrice,
                  e.status.arabicName,
                  e.date?.formatDateTime,
                ];
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
