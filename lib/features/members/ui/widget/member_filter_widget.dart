import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/command.dart';
import 'package:qareeb_dash/core/strings/app_color_manager.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/features/members/data/request/member_filter_request.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';

class MemberFilterWidget extends StatefulWidget {
  const MemberFilterWidget({super.key, this.onApply, this.command});

  final Function(MemberFilterRequest request)? onApply;

  final Command? command;

  @override
  State<MemberFilterWidget> createState() => _MemberFilterWidgetState();
}

class _MemberFilterWidgetState extends State<MemberFilterWidget> {
  late MemberFilterRequest request;

  late final TextEditingController collegeIdNumberC;
  late final TextEditingController addressC;
  late final TextEditingController facilityC;
  late final TextEditingController phoneNoC;
  late final TextEditingController nameC;
  late final TextEditingController idNumberC;

  @override
  void initState() {
    request = widget.command?.memberFilterRequest ?? MemberFilterRequest();
    collegeIdNumberC = TextEditingController(text: request.collegeIdNumber);
    addressC = TextEditingController(text: request.address);
    facilityC = TextEditingController(text: request.facility);
    phoneNoC = TextEditingController(text: request.phoneNo);
    nameC = TextEditingController(text: request.name);
    idNumberC = TextEditingController(text: request.idNumber);
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
                  label: 'الرقم الجامعي',
                  // initialValue: request.collegeIdNumber,
                  controller: collegeIdNumberC,
                  onChanged: (p0) => request.collegeIdNumber = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'عنوان الطالب',
                  // initialValue: request.address,
                  controller: addressC,
                  onChanged: (p0) => request.address = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'الكلية',
                  // initialValue: request.facility,
                  controller: facilityC,
                  onChanged: (p0) => request.facility = p0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'رقم الهاتف',
                  // initialValue: request.phoneNo,
                  controller: phoneNoC,
                  onChanged: (p0) => request.phoneNo = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'الاسم',
                  // initialValue: request.name,
                  controller: nameC,
                  onChanged: (p0) => request.name = p0,
                ),
              ),
              15.0.horizontalSpace,
              Expanded(
                child: MyTextFormNoLabelWidget(
                  label: 'ID',
                  // initialValue: request.idNumber,
                  controller: idNumberC,
                  onChanged: (p0) => request.idNumber = p0,
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
                  onTap: () => setState(() {
                    request.clearFilter();
                    collegeIdNumberC.text = request.collegeIdNumber ?? '';
                    addressC.text = request.address ?? '';
                    facilityC.text = request.facility ?? '';
                    phoneNoC.text = request.phoneNo ?? '';
                    nameC.text = request.name ?? '';
                    idNumberC.text = request.idNumber ?? '';
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
