import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/spinner_widget.dart';
import 'package:qareeb_dash/features/map/ui/widget/map_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/note_message.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../drivers/ui/widget/item_image_create.dart';
import '../../../map/bloc/map_controller_cubit/map_controller_cubit.dart';
import '../../../map/bloc/search_location/search_location_cubit.dart';
import '../../../map/ui/widget/search_location_widget.dart';
import '../../../map/ui/widget/search_widget.dart';
import '../../bloc/all_member_cubit/all_member_cubit.dart';
import '../../bloc/create_member_cubit/create_member_cubit.dart';
import '../../bloc/member_by_id_cubit/member_by_id_cubit.dart';
import '../../data/request/create_member_request.dart';
import '../../data/request/create_subcription_request.dart';

class CreateMemberPage extends StatefulWidget {
  const CreateMemberPage({super.key});

  @override
  State<CreateMemberPage> createState() => _CreateMemberPageState();
}

class _CreateMemberPageState extends State<CreateMemberPage> {
  var request = CreateMemberRequest();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateMemberCubit, CreateMemberInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<AllMembersCubit>().getMembers(context);
            window.history.back();
          },
        ),
        BlocListener<MemberBuIdCubit, MemberBuIdInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            request.fromMember(state.result);
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(
          text: 'الطلاب',
        ),
        body: BlocBuilder<MemberBuIdCubit, MemberBuIdInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 20.0).r,
              child: MyCardWidget(
                cardColor: AppColorManager.f1,
                margin: const EdgeInsets.only(top: 30.0, bottom: 130.0).h,
                child: Column(
                  children: [
                    ItemImageCreate(
                      onLoad: (bytes) {
                        setState(() {
                          request.file = UploadFile(
                            fileBytes: bytes,
                            nameField: 'ImageFile',
                          );
                        });
                      },
                      image: request.file?.initialImage != null
                          ? request.file!.initialImage!
                          : Assets.iconsUser,
                      text: 'الصورة الشخصية',
                      fileBytes: request.file?.fileBytes,
                    ),
                    10.0.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'اسم الطالب',
                            initialValue: request.fullName,
                            onChanged: (p0) => request.fullName = p0,
                          ),
                        ),
                        15.0.horizontalSpace,
                        Expanded(
                          child: MyTextFormNoLabelWidget(
                            label: 'عنوان الطالب التفصيلي',
                            initialValue: request.address,
                            onChanged: (p0) => request.address = p0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(20.0).r,
                      height: 500.0.h,
                      child: MapWidget(
                        onMapClick: (latLng) => request.latLng = latLng,
                        search: () async {
                          NoteMessage.showCustomBottomSheet(
                            context,
                            child: BlocProvider.value(
                              value: context.read<SearchLocationCubit>(),
                              child: SearchWidget(
                                onTap: (SearchLocationItem location) {
                                  Navigator.pop(context);
                                  context
                                      .read<MapControllerCubit>()
                                      .movingCamera(point: location.point, zoom: 15.0);
                                },
                              ),
                            ),
                          );
                        },
                        initialPoint: request.latLng,
                      ),
                    ),
                    const Divider(),
                    BlocBuilder<CreateMemberCubit, CreateMemberInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButton(
                          text: request.id != null ? 'تعديل' : 'إنشاء الطالب',
                          onTap: () {
                            if (request.validateRequest(context)) {
                              context
                                  .read<CreateMemberCubit>()
                                  .createMember(context, request: request);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SelectSingeDateWidget extends StatelessWidget {
  const SelectSingeDateWidget({
    super.key,
    this.onSelect,
    this.initial,
    this.maxDate,
    this.minDate,
  });

  final DateTime? initial;
  final DateTime? maxDate;
  final DateTime? minDate;
  final Function(DateTime? selected)? onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
                  initialSelectedDate: initial,
                  maxDate: maxDate,
                  minDate: minDate,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs range) {
                    loggerObject.w(range.value);
                    if (range.value is DateTime) {
                      onSelect?.call(range.value);
                      Navigator.pop(context);
                    } else if (range.value is PickerDateRange) {}
                  },
                  selectionMode: DateRangePickerSelectionMode.single,
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
        child: Icon(
          Icons.date_range,
          size: 40.0.r,
        ),
      ),
    );
  }
}
