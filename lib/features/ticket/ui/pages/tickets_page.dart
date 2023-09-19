import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_card_widget.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/all_ticket_cubit/all_ticket_cubit.dart';
import '../../bloc/replay_ticket_cubit/replay_ticket_cubit.dart';
import '../../data/response/tickets_response.dart';

final _super_userList = [
  'ID',
  'اسم المستخدم',
  'تاريخ الإرسال',
  'عدد الردود',
  'المحتوى',
];

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<AllTicketsCubit, AllTicketsInitial>(
            builder: (context, state) {
              if (state.statuses.loading) {
                return MyStyle.loadingWidget();
              }
              final list = state.result;
              if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد شكاوى');
              return SaedTableWidget(
                command: state.command,
                title: _super_userList,
                data: list
                    .mapIndexed(
                      (i, e) => [
                        e.id.toString(),
                        e.user.fullName,
                        e.date?.formatDateTime,
                        e.replies.length.toString(),
                        IconButton(
                          onPressed: () {
                            var s = TextEditingController();
                            var send = false;
                            NoteMessage.showMyDialog(
                              context,
                              onCancel: (val) {
                                if (send) {
                                  context.read<AllTicketsCubit>().getTickets(context);
                                }
                              },
                              child: BlocProvider.value(
                                value: context.read<ReplayTicketCubit>(),
                                child: StatefulBuilder(builder: (context, myState) {
                                  return Container(
                                    width: 0.8.sw,
                                    padding: const EdgeInsets.all(20.0).r,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const DrawableText(text: 'الردود السابقة'),
                                        const Divider(),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: MyCardWidget(
                                            cardColor: Colors.orange,
                                            margin: const EdgeInsets.all(10.0).r,
                                            child: DrawableText(
                                                matchParent: true,
                                                text: e.description,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 300.0.h,
                                          child: ListView.builder(
                                            itemCount: e.replies.length,
                                            itemBuilder: (context, index) {
                                              return MyCardWidget(
                                                margin: const EdgeInsets.all(10.0).r,
                                                child: DrawableText(
                                                  text: e.replies[index].reply,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        10.0.verticalSpace,
                                        MyEditTextWidget(
                                          hint: 'اكتب الرد',
                                          controller: s,
                                        ),
                                        10.0.verticalSpace,
                                        Center(
                                          child: BlocConsumer<ReplayTicketCubit,
                                              ReplayTicketInitial>(
                                            listenWhen: (p, c) => c.statuses.done,
                                            listener: (_, state) {
                                              send = true;
                                              myState(
                                                () {
                                                  s.text = '';
                                                  e.replies.add(
                                                    Reply.fromJson(
                                                        {'reply': state.result}),
                                                  );
                                                },
                                              );
                                            },
                                            builder: (context, state) {
                                              if (state.statuses.loading) {
                                                return MyStyle.loadingWidget();
                                              }

                                              return MyButton(
                                                text: 'رد',
                                                onTap: () {
                                                  context
                                                      .read<ReplayTicketCubit>()
                                                      .replayTicket(context,
                                                          s: s.text, id: e.id);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.list_alt_rounded,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    )
                    .toList(),
                onChangePage: (command) {
                  context.read<AllTicketsCubit>().getTickets(context, command: command);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
