import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
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
      body: BlocBuilder<AllMessagesCubit, AllMessagesInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }

          if (state.result.isEmpty) {
            return const NotFoundWidget(text: 'لا يوجد رسائل');
          }
          return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (_, i) {
              final item = state.result[i];
              return MyCardWidget(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                child: Column(
                  children: [
                    DrawableText(
                      size: 18.0.sp,
                      matchParent: true,
                      drawablePadding: 10.0.w,
                      drawableAlin: DrawableAlin.withText,
                      text: 'المرسل',
                      color: Colors.black,
                      fontFamily: FontManager.cairoBold,
                      drawableEnd: DrawableText(
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: '${item.senderName} - (${item.senderType})',
                        color: Colors.black,
                      ),
                    ),
                    const Divider(),
                    DrawableText(
                      size: 18.0.sp,
                      matchParent: true,
                      drawablePadding: 10.0.w,
                      drawableAlin: DrawableAlin.withText,
                      text: 'العنوان',
                      color: Colors.black,
                      fontFamily: FontManager.cairoBold,
                      drawableEnd: DrawableText(
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.tilte,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(),
                    DrawableText(
                      size: 18.0.sp,
                      matchParent: true,
                      drawablePadding: 10.0.w,
                      drawableAlin: DrawableAlin.withText,
                      text: 'المحتوى',
                      color: Colors.black,
                      fontFamily: FontManager.cairoBold,
                      drawableEnd: DrawableText(
                        size: 18.0.sp,
                        textAlign: TextAlign.center,
                        text: item.body,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
