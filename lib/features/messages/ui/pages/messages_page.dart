import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../router/go_route_pages.dart';
import '../../bloc/all_messages/all_messages_cubit.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    context.read<AllMessagesCubit>().getAllMessages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100.0).h,
        child: Column(
          children: [
            BlocBuilder<AllMessagesCubit, AllMessagesInitial>(
              builder: (context, state) {
                if (state.statuses.isLoading) {
                  return MyStyle.loadingWidget();
                }
                //institution

                if (state.result.isEmpty) {
                  return const NotFoundWidget(text: 'لا يوجد رسائل');
                }
                return SaedTableWidget(
                  command: state.command,
                  fullHeight: 1.8.sh,
                  onChangePage: (command) {
                    context
                        .read<AllMessagesCubit>()
                        .getAllMessages(context, command: command);
                  },
                  title: const [
                    'ID',
                    'اسم المرسل',
                    'رقم الهاتف',
                    'نوع المرسل',
                    'عنوان الرسالة',
                    'المحتوى',
                  ],
                  data: state.result
                      .map(
                        (e) => [
                          InkWell(
                            onTap: () {
                              context.pushNamed(
                                  e.reciverType == 'driver'
                                      ? GoRouteName.driverInfo
                                      : GoRouteName.clientInfo,
                                  queryParams: {'id': e.senderId.toString()});
                            },
                            child: DrawableText(
                              selectable: false,
                              size: 16.0.sp,
                              matchParent: true,
                              textAlign: TextAlign.center,
                              underLine: true,
                              text: e.senderId.toString(),
                              color: Colors.blue,
                            ),
                          ),
                          e.senderName,
                          e.senderPhone,
                          e.senderType,
                          e.tilte,
                          IconButton(
                            onPressed: () {
                              NoteMessage.showMyDialog(
                                context,
                                child: Container(
                                  padding: const EdgeInsets.all(20.0).r,
                                  child: DrawableText(text: e.body),
                                ),
                              );
                            },
                            icon: const Icon(Icons.message),
                          ),
                        ],
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
