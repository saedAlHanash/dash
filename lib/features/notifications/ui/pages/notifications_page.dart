import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/features/shared_trip/ui/widget/filters/shared_trips_filter_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/notification_cubit/notification_cubit.dart';
import '../widget/notifications_filter_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CreateNotificationCubit, CreateNotificationInitial>(
        listenWhen: (p, c) => c.statuses.done,
        listener: (context, state) {
          NoteMessage.showDoneDialog(
            context,
            text: 'تم ارسال الاشعار',
            onCancel: () => window.history.back(),
          );
        },
        child: BlocBuilder<CreateNotificationCubit, CreateNotificationInitial>(
          builder: (_, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NotificationsFilterWidget(
                  request: state.request,
                  onApply: (request) {
                    state.request.userType = request.userType;
                    state.request.areaIds = request.areaIds;
                  },
                ),
                MyEditTextWidget(
                  onChanged: (p0) => state.request.title = p0,
                  hint: 'اكتب عنوان الإشعار',
                  innerPadding: const EdgeInsets.all(20.0).r,
                ),
                5.0.verticalSpace,
                SizedBox(
                  height: 300.h,
                  child: MyEditTextWidget(
                    onChanged: (p0) => state.request.body = p0,
                    maxLines: 20000,
                    maxLength: 1.0.maxInt,
                    hint: 'اكتب نص الإشعار',
                    innerPadding: const EdgeInsets.all(20.0).r,
                  ),
                ),
                BlocBuilder<CreateNotificationCubit, CreateNotificationInitial>(
                  builder: (context, mState) {
                    if (mState.statuses.isLoading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      onTap: () async {
                        context
                            .read<CreateNotificationCubit>()
                            .createNotification(context, request: state.request);
                      },
                      text: 'إرسال',
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
