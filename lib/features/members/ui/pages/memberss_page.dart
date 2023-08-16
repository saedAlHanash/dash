import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/images/round_image_widget.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/members/ui/pages/create_subscreption_page.dart';

import 'package:qareeb_dash/router/go_route_pages.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../subscriptions/bloc/create_subscriptions_cubit/create_subscriptions_cubit.dart';
import '../../bloc/all_member_cubit/all_member_cubit.dart';
import '../../bloc/create_subscreption_cubit/create_subscreption_cubit.dart';
import '../../bloc/member_by_id_cubit/member_by_id_cubit.dart';
import '../../data/response/member_response.dart';

final _super_userList = [
  'ID',
  'اسم الطالب',
  'الرقم الجامعي',
  'الكلية',
  'حالة الاشتراك في النقل',
  'عمليات الاشتراكات',
  'عمليات',
];

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => context.pushNamed(GoRouteName.createMember),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AllMembersCubit, AllMembersInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
          return Column(
            children: [
              DrawableText(
                text: 'الطلاب',
                matchParent: true,
                size: 28.0.sp,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
              ),
              SaedTableWidget(
                command: state.command,
                title: _super_userList,
                data: list
                    .mapIndexed(
                      (index, e) => [
                        e.id.toString(),
                        e.fullName,
                        e.collegeIdNumber,
                        e.facility,
                        // e.userName,
                        // MyTextFormWidget(
                        //   initialValue: e.password,
                        //   obscureText: true,
                        // ),
                        (e.subscriptions.isEmpty || !e.subscriptions.last.isActive)
                            ? 'غير مشترك'
                            : (e.subscriptions.last.isNotExpired)
                                ? 'مشترك'
                                : 'اشتراك منتهي',
                        InkWell(
                          onTap: !isAllowed(AppPermissions.UPDATE)
                              ? null
                              : () => dialogSubscription(context,e.id),
                          child: const Icon(
                            Icons.edit_calendar,
                            color: Colors.green,
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  NoteMessage.showMyDialog(
                                    context,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0).r,
                                      child: Column(
                                        children: [
                                          ItemInfoInLine(
                                            title: 'UserName',
                                            info: e.userName,
                                          ),
                                          ItemInfoInLine(
                                            title: 'Password',
                                            info: e.password,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.key),
                              ),
                              InkWell(
                                onTap: !isAllowed(AppPermissions.UPDATE)
                                    ? null
                                    : () {
                                        context.pushNamed(GoRouteName.createMember,
                                            queryParams: {'id': e.id.toString()});
                                      },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                    .toList(),
                onChangePage: (command) {
                  context.read<AllMembersCubit>().getMembers(context, command: command);
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (context, i) {
              //       final item = list[i];
              //       return ItemMember(item: item);
              //     },
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}

  void dialogSubscription(BuildContext context,int memberId) {
    NoteMessage.showMyDialog(
      context,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CreateSubscriptionCubit1()),
          BlocProvider(
            create: (context) => MemberBuIdCubit()..getMemberBuId(context, id: memberId),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20.0).r,
          child: const CreateSubscriptionPage1(),
        ),
      ),
    );
  }
