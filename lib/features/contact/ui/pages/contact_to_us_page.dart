import 'dart:html';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/util/shared_preferences.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/features/contact/bloc/send_note_cubit/send_note_cubit.dart';
import 'package:qareeb_dash/features/contact/data/request/note_request.dart';
import 'package:qareeb_models/extensions.dart';
import 'package:qareeb_models/global.dart';

import '../../../../core/app/bloc/loading_cubit.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/app_string_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/map_background_widget.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../core/widgets/top_title_widget.dart';
import '../../../../generated/assets.dart';
class ContactToUs extends StatelessWidget {
  const ContactToUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteC = TextEditingController();
    final bodyC = TextEditingController();

    void onSendNote() {
      var t = noteC.text;
      var b = bodyC.text;
      if (t.isEmpty) {
        NoteMessage.showSnakeBar(
            message: AppStringManager.emptyNoteTitle, context: context);
        return;
      }
      if (b.isEmpty) {
        NoteMessage.showSnakeBar(
            message: AppStringManager.emptyNoteBody, context: context);
        return;
      }
      final request = NoteRequest(body: b, title: t, userId: AppSharedPreference.getMyId);

      context.read<SendNoteCubit>().sendNote(context, request: request);
    }

    void initListener(BuildContext context, NoteInitial state) {
      if (state.statuses == CubitStatuses.done) {
        window.history.back();
        NoteMessage.showDoneDialog(context, text: AppStringManager.doneSendNote);
      }
    }

    return WillPopScope(
      onWillPop: () async => context.read<LoadingCubit>().isLoadingForPop(),
      child: BlocListener<SendNoteCubit, NoteInitial>(
        listener: initListener,
        child: Scaffold(
          appBar: const AppBarWidget(),
          body: Stack(
            alignment: Alignment.center,
            children: [
              const MapBackgroundWidget(color: Colors.transparent),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const TopTitleWidget(
                      text: AppStringManager.contactToUs,
                      icon: Assets.iconsQuastion,
                    ),
                    10.0.verticalSpace,
                    SizedBox(
                      width: 1.0.sw,
                      child: MyCardWidget(
                        elevation: 10.0,
                        cardColor: AppColorManager.lightGray,
                        margin:
                            EdgeInsets.symmetric(vertical: 25.0.h, horizontal: 30.0.w),
                        child: Column(
                          children: [
                            DrawableText.title(text: AppStringManager.leavingNiceMessage),
                            10.0.verticalSpace,
                            MyEditTextWidget(
                              controller: noteC,
                              hint: AppStringManager.messageTitle,
                              backgroundColor: Colors.white,
                            ),
                            15.0.verticalSpace,
                            MyEditTextWidget(
                              controller: bodyC,
                              hint: AppStringManager.yourNotes,
                              backgroundColor: Colors.white,
                              maxLines: 7,
                            ),
                            15.0.verticalSpace,
                            BlocBuilder<SendNoteCubit, NoteInitial>(
                              builder: (context, state) {
                                if (state.statuses.isLoading) {
                                  return MyStyle.loadingWidget();
                                }
                                return MyButton(
                                  text: AppStringManager.add,
                                  onTap: onSendNote,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
