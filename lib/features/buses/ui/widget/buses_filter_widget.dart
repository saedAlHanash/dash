import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../data/request/buses_filter_request.dart';

class BusesFilterWidget extends StatefulWidget {
  const BusesFilterWidget({super.key, this.onApply, this.command});

  final Function(BusesFilterRequest request)? onApply;

  final Command? command;

  @override
  State<BusesFilterWidget> createState() => _BusesFilterWidgetState();
}

class _BusesFilterWidgetState extends State<BusesFilterWidget> {
  late BusesFilterRequest request;

  late final TextEditingController imeiC;
  late final TextEditingController addressC;
  late final TextEditingController facilityC;
  late final TextEditingController phoneNoC;
  late final TextEditingController nameC;
  late final TextEditingController idNumberC;

  @override
  void initState() {
    request = widget.command?.busesFilterRequest ?? BusesFilterRequest();
    imeiC = TextEditingController(text: request.imei);
    nameC = TextEditingController(text: request.name);
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
                  label: 'IMEI',
                  // initialValue: request.imei,
                  controller: imeiC,
                  onChanged: (p0) => request.imei = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'اسم',
                  // initialValue: request.name,
                  controller: nameC,
                  onChanged: (p0) => request.name = p0,
                ),
              ),
            ],
          ),
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
                    imeiC.text = request.imei ?? '';
                    nameC.text = request.name ?? '';
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
