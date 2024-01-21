import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../../core/api_manager/command.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../core/widgets/my_text_form_widget.dart';
import '../../../../../core/widgets/select_date.dart';

import '../../data/request/syrian_filter_request.dart';

class SyrianFilterWidget extends StatefulWidget {
  const SyrianFilterWidget({super.key, this.onApply, this.command});

  final Function(SyrianFilterRequest request)? onApply;

  final Command? command;

  @override
  State<SyrianFilterWidget> createState() => _SyrianFilterWidgetState();
}

class _SyrianFilterWidgetState extends State<SyrianFilterWidget> {
  late SyrianFilterRequest request;

  late final TextEditingController startDateC;
  late final TextEditingController endDateC;
  late final TextEditingController userNameC;

  final key1 = GlobalKey<SpinnerWidgetState>();
  final key2 = GlobalKey<SpinnerWidgetState>();

  @override
  void initState() {
    request = widget.command?.syrianFilterRequest ?? SyrianFilterRequest();
    startDateC = TextEditingController(text: request.startTime?.formatDate);
    endDateC = TextEditingController(text: request.endTime?.formatDate);
    userNameC = TextEditingController(text: request.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0).r,
      margin: const EdgeInsets.all(30.0).r,
      decoration: MyStyle.outlineBorder,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'تاريخ بداية',
                  controller: startDateC,
                  disableAndKeepIcon: true,
                  textDirection: TextDirection.ltr,
                  iconWidget: SelectSingeDateWidget(
                    initial: request.startTime,
                    onSelect: (selected) {
                      startDateC.text = selected?.formatDate ?? '';
                      request.startTime = selected;
                    },
                  ),
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'تاريخ نهاية',
                  controller: endDateC,
                  disableAndKeepIcon: true,
                  textDirection: TextDirection.ltr,
                  iconWidget: SelectSingeDateWidget(
                    initial: request.endTime,
                    onSelect: (selected) {
                      endDateC.text = selected?.formatDate ?? '';
                      request.endTime = selected;
                    },
                  ),
                ),
              ),
            ],
          ),
          20.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MyButton(
                  width: 1.0.sw,
                  color: AppColorManager.mainColorDark,
                  text: 'فلترة',
                  onTap: () => widget.onApply?.call(request),
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyButton(
                  width: 1.0.sw,
                  color: AppColorManager.black,
                  text: 'مسح الفلاتر',
                  onTap: () {
                    setState(() {
                      request.clearFilter();
                      startDateC.text = '';
                      endDateC.text = '';
                      userNameC.text = '';
                      key1.currentState?.clearSelect();
                      key2.currentState?.clearSelect();
                    });
                    widget.onApply?.call(request);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
