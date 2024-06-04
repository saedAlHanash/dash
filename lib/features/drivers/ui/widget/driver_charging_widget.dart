import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../accounts/bloc/all_charging_cubit/all_charging_cubit.dart';
import '../../data/response/drivers_response.dart';

class DriverChargingWidget extends StatefulWidget {
  const DriverChargingWidget({super.key, required this.driver});

  final Driver driver;
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
