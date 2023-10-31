import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/agencies/data/response/agency_response.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../drivers/ui/widget/item_image_create.dart';
import '../../bloc/agencies_cubit/agencies_cubit.dart';
import '../../bloc/create_agency_cubit/create_agency_cubit.dart';
import '../../bloc/delete_agency_cubit/delete_agency_cubit.dart';
import '../../data/request/agency_request.dart';

class AgenciesPage extends StatefulWidget {
  const AgenciesPage({super.key});

  @override
  State<AgenciesPage> createState() => _AgenciesPageState();
}

class _AgenciesPageState extends State<AgenciesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () {
                NoteMessage.showMyDialog(
                  context,
                  child: BlocProvider.value(
                    value: context.read<CreateAgencyCubit>(),
                    child: const CreateAgencyDialog(),
                  ),
                  onCancel: (val) {
                    if (val) context.read<AgenciesCubit>().getAgencies(context);
                  },
                );
              },
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AgenciesCubit, AgenciesInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد وكلاء');
          return SaedTableWidget(
            title: const [
              'ID',
              'صورة',
              'اسم',
              'نسبة',
            ],
            data: state.result
                .map(
                  (e) => [
                    e.id.toString(),
                    Center(
                      child: RoundImageWidget(
                        url: e.imageUrl,
                        height: 70.0.r,
                        width: 70.0.r,
                      ),
                    ),
                    e.name,
                    '${e.agencyRatio}%'
                  ],
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class CreateAgencyDialog extends StatefulWidget {
  const CreateAgencyDialog({super.key, this.agency});

  final Agency? agency;

  @override
  State<CreateAgencyDialog> createState() => _CreateAgencyDialogState();
}

class _CreateAgencyDialogState extends State<CreateAgencyDialog> {
  late final CreateAgencyCubit createAgencyCubit;
  late final AgencyRequest request;

  @override
  void initState() {
    createAgencyCubit = context.read<CreateAgencyCubit>();
    request = createAgencyCubit.state.request..initFromAgency(widget.agency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAgencyCubit, CreateAgencyInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        Navigator.pop(context);
        context.read<AgenciesCubit>().getAgencies(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          30.0.verticalSpace,
          Center(
            child: ItemImageCreate(
              onLoad: (bytes) {
                setState(() {
                  request.file = UploadFile(
                    fileBytes: bytes,
                    nameField: 'File',
                  );
                });
              },
              image: request.file?.initialImage != null
                  ? request.file!.initialImage!
                  : Assets.iconsCarPlaceHolder,
              text: 'الصورة',
              fileBytes: request.file?.fileBytes,
            ),
          ),
          MyCardWidget(
            cardColor: AppColorManager.f1,
            margin: const EdgeInsets.symmetric(vertical: 30.0).h,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormNoLabelWidget(
                        label: 'اسم الوكيل',
                        initialValue: request.name,
                        onChanged: (p0) {
                          request.adminFirstName = p0;
                          request.name = p0;
                        },
                      ),
                    ),
                    15.0.horizontalSpace,
                    Expanded(
                      child: MyTextFormNoLabelWidget(
                        label: 'نسبة الوكيل (نسبة مئوية)',
                        maxLength: 2,
                        initialValue: (request.agencyRatio ?? 0).toString(),
                        onChanged: (p0) {
                          request.agencyRatio = num.tryParse(p0);
                        },
                      ),
                    ),
                  ],
                ),
                if (request.id == null)
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormNoLabelWidget(
                          label: 'اسم المستخدم (User Name)',
                          initialValue: request.emailAddress,
                          onChanged: (p0) => request.emailAddress = p0,
                        ),
                      ),
                      15.0.horizontalSpace,
                      Expanded(
                        child: MyTextFormNoLabelWidget(
                          label: 'رقم الهاتف',
                          initialValue: request.phoneNumber,
                          onChanged: (p0) => request.phoneNumber = p0,
                        ),
                      ),
                      15.0.horizontalSpace,
                      Expanded(
                        child: MyTextFormNoLabelWidget(
                          label: 'كلمة المرور',
                          obscureText: true,
                          initialValue: request.password,
                          onChanged: (p0) {
                            request.password = p0;
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          BlocBuilder<CreateAgencyCubit, CreateAgencyInitial>(
            builder: (context, state) {
              if (state.statuses.isLoading) {
                return MyStyle.loadingWidget();
              }
              return MyButton(
                text: request.id != null ? 'تعديل' : 'إنشاء',
                onTap: () {
                  if (request.validateRequest(context)) {
                    createAgencyCubit.createAgency(context);
                  }
                },
              );
            },
          ),
          20.0.verticalSpace,
        ],
      ),
    );
  }
}
