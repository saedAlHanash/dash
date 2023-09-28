import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../data/request/clients_filter_request.dart';

class ClientsFilterWidget extends StatefulWidget {
  const ClientsFilterWidget(
      {super.key, this.onApply, this.command, this.isDriver = false});

  final Function(ClientsFilterRequest request)? onApply;

  final Command? command;

  final bool isDriver;

  @override
  State<ClientsFilterWidget> createState() => _ClientsFilterWidgetState();
}

class _ClientsFilterWidgetState extends State<ClientsFilterWidget> {
  late ClientsFilterRequest request;

  late final TextEditingController phoneNoC;
  late final TextEditingController nameC;
  final key1 = GlobalKey<SpinnerWidgetState>();

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
              if (widget.isDriver) ...[
                15.0.horizontalSpace,
                Expanded(
                  child: SpinnerWidget(
                    key: key1,
                    width: 1.0.sw,
                    items: [
                      SpinnerItem(
                          name: 'متاح ',
                          id: 1,
                          item: true,
                          isSelected: request.isAvailable == true),
                      SpinnerItem(
                          name: 'غير متاح',
                          id: 2,
                          item: false,
                          isSelected: request.isAvailable == false),
                    ]..insert(
                        0,
                        SpinnerItem(
                          name: 'حالة السائق',
                          id: -1,
                          isSelected: request.isAvailable == null,
                        )),
                    onChanged: (item) => request.isAvailable = item.item,
                  ),
                ),
              ],
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
                    if (widget.isDriver) key1.currentState?.clearSelect();
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
