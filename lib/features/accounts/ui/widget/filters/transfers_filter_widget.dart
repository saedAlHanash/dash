import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../core/strings/enum_manager.dart';
import '../../../data/request/transfer_filter_request.dart';

class TransfersFilterWidget extends StatefulWidget {
  const TransfersFilterWidget({super.key, this.onApply});

  final Function(TransferFilterRequest request)? onApply;

  @override
  State<TransfersFilterWidget> createState() => _TransfersFilterWidgetState();
}

class _TransfersFilterWidgetState extends State<TransfersFilterWidget> {
  var request = TransferFilterRequest();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Builder(
          builder: (context) {
            final list = <SpinnerItem>[
              SpinnerItem(
                item: TransferStatus.closed,
                name: 'تمت',
                id: TransferStatus.closed.index,
              ),
              SpinnerItem(
                item: TransferStatus.pending,
                name: 'غير مكتملة',
                id: TransferStatus.pending.index,
              ),
            ];
            list.insert(0, SpinnerItem(name: 'اختر الحالة', id: -1));

            for (var e in list) {
              if (e.id == request.status?.index) {
                e.isSelected = true;
                break;
              }
            }
            return SpinnerWidget(
              items: list,
              onChanged: (spinnerItem) => request.status = spinnerItem.item,
            );
          },
        ),
        Builder(
          builder: (context) {
            final list = TransferType.values
                .map(
                  (e) => SpinnerItem(name: e.arabicName, id: e.index, item: e),
                )
                .toList();
            list.insert(0, SpinnerItem(name: 'اختر النوع', id: -1));

            for (var e in list) {
              if (e.id == request.type?.index) {
                e.isSelected = true;
                break;
              }
            }
            return SpinnerWidget(
              items: list,
              onChanged: (spinnerItem) => request.type = spinnerItem.item,
            );
          },
        ),
        FilterItem(
          title: 'حسب مجال من التاريخ',
          child: PopupMenuButton(
            constraints: BoxConstraints(maxHeight: 1.0.sh, maxWidth: 1.0.sw),
            splashRadius: 0.001,
            color: Colors.white,
            padding: const EdgeInsets.all(5.0).r,
            elevation: 2.0,
            iconSize: 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                enabled: false,
                // row with 2 children
                child: SizedBox(
                  height: 400.0.spMin,
                  width: 300.0.spMin,
                  child: Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: SfDateRangePicker(
                        initialSelectedRange:
                            PickerDateRange(request.fromDateTime, request.toDateTime),
                        maxDate: DateTime.now(),
                        viewSpacing: 0,
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs range) {
                          if (range.value is DateTime) {
                            request.fromDateTime = range.value;
                            request.toDateTime = DateTime.now();
                          } else if (range.value is PickerDateRange) {
                            var val = range.value as PickerDateRange;
                            request.fromDateTime = val.startDate;
                            request.toDateTime = val.endDate;
                          }
                        },
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.all(15.0).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
                color: AppColorManager.offWhit.withOpacity(0.5),
              ),
              child: Row(
                children: [
                  const DrawableText(
                    text: 'اختر التاريخ',
                    color: Colors.black,
                  ),
                  10.0.horizontalSpace,
                  Icon(
                    Icons.date_range,
                    size: 40.0.r,
                  ),
                ],
              ),
            ),
          ),
        ),
        MyButton(
          width: 70.0.w,
          color: AppColorManager.mainColorDark,
          text: 'فلترة',
          onTap: () => widget.onApply?.call(request),
        ),
        20.0.horizontalSpace,
      ],
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
