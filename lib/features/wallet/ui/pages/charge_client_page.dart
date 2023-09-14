import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/app_bar_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/charge_client_cubit/charge_client_cubit.dart';
import '../../data/request/charge_client_request.dart';

class ChargeClientPage extends StatefulWidget {
  const ChargeClientPage({Key? key, this.phone}) : super(key: key);

  final String? phone;

  @override
  State<ChargeClientPage> createState() => _ChargeClientPageState();
}

class _ChargeClientPageState extends State<ChargeClientPage> {
  String otp = '';
  var request = ChargeClientRequest.fromJson({});

  @override
  void initState() {
    request.phoneNumber = widget.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChargeClientCubit, ChargeClientInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            NoteMessage.showSuccessSnackBar(message: 'تم الشحن بنجاح', context: context);
            Navigator.pop(context, true);
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: MyCardWidget(
          margin: const EdgeInsets.all(20.0).r,
          elevation: 15.0.r,
          cardColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawableText(
                text: 'يرجى إدخال رقم الزبون وقيمة الشحن',
                size: 18.0.sp,
                fontFamily: FontManager.cairoBold,
                color: AppColorManager.mainColor,
              ),
              10.0.verticalSpace,
              MyTextFormNoLabelWidget(
                maxLength: 10,
                icon: Assets.icons963,
                keyBordType: TextInputType.phone,
                label: AppStringManager.enterPhone,
                textAlign: TextAlign.right,
                initialValue: request.phoneNumber,
                onChanged: (val) => request.phoneNumber = val,
              ),
              10.0.verticalSpace,
              MyTextFormNoLabelWidget(
                maxLength: 10,
                keyBordType: TextInputType.number,
                label: 'قيمة الشحن',
                textAlign: TextAlign.right,
                onChanged: (val) => request.amount = num.parse(val),
              ),
              10.0.verticalSpace,
              BlocBuilder<ChargeClientCubit, ChargeClientInitial>(
                builder: (_, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: 'شحن رصيد',
                    onTap: () {
                      if (request.amount == 0) return;

                      request.phoneNumber =
                          checkPhoneNumber(context, request.phoneNumber ?? '');

                      context
                          .read<ChargeClientCubit>()
                          .chargeClient(context, request: request);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
