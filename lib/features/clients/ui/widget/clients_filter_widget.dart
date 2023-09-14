import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../data/request/clients_filter_request.dart';

class ClientsFilterWidget extends StatefulWidget {
  const ClientsFilterWidget({super.key, this.onApply, this.command});

  final Function(ClientsFilterRequest request)? onApply;

  final Command? command;

  @override
  State<ClientsFilterWidget> createState() => _ClientsFilterWidgetState();
}

class _ClientsFilterWidgetState extends State<ClientsFilterWidget> {
  late ClientsFilterRequest request;

  late final TextEditingController phoneNoC;
  late final TextEditingController nameC;

  @override
  void initState() {
    request = widget.command?.memberFilterRequest ?? ClientsFilterRequest();

    phoneNoC = TextEditingController(text: request.phoneNo);
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
                  label: 'الاسم',
                  // initialValue: request.collegeIdNumber,
                  controller: nameC,
                  onChanged: (p0) => request.name = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'رقم الهاتف',
                  // initialValue: request.address,
                  controller: phoneNoC,
                  onChanged: (p0) => request.phoneNo = p0,
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
                      phoneNoC.text = request.phoneNo ?? '';
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
