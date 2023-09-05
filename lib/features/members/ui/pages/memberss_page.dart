import 'dart:html';
import 'dart:ui';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/members/ui/pages/create_subscreption_page.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../home/bloc/home1_cubit/home1_cubit.dart';
import '../../../home/bloc/home_cubit/home_cubit.dart';
import '../../../home/ui/screens/dashboard_page.dart';
import '../../bloc/all_member_cubit/all_member_cubit.dart';
import '../../bloc/create_subscreption_cubit/create_subscreption_cubit.dart';
import '../../bloc/member_by_id_cubit/member_by_id_cubit.dart';
import '../widget/member_filter_widget.dart';

final _super_userList = [
  'ID',
  'اسم الطالب',
  'الرقم الجامعي',
  'الكلية',
  'حالة الاشتراك في النقل',
  'عمليات الاشتراكات',
  if (isAllowed(AppPermissions.members)) 'عمليات',
];

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.members)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () => context.pushNamed(GoRouteName.createMember),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                10.0.verticalSpace,
                StatefulBuilder(
                  builder: (context, mState) {
                    return FloatingActionButton(
                      onPressed: () {
                        mState(() => loading = true);
                        context.read<AllMembersCubit>().getMembersAsync(context).then(
                          (value) {
                            if (value == null) return;
                            saveXls(
                              header: value.first,
                              data: value.second,
                              fileName: 'تقرير الطلاب ${DateTime.now().formatDate}',
                            );
                            mState(() => loading = false);
                          },
                        );
                      },
                      child: loading
                          ? const CircularProgressIndicator.adaptive()
                          : const Icon(Icons.file_download, color: Colors.white),
                    );
                  },
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100.0).r,
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return Column(
                  children: [
                    TotalWidget(
                      text: 'عدد الطلاب المشتركين في النقل',
                      icon: Assets.iconsCheckCircle,
                      number: state.result.membersWithSubscription,
                    ),
                    TotalWidget(
                      text: 'عدد الطلاب الغير مشتركين في النقل',
                      icon: Assets.iconsReject,
                      number: state.result.membersWithoutSubscription,
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<AllMembersCubit, AllMembersInitial>(
              builder: (context, state) {
                return MemberFilterWidget(
                  onApply: (request) {
                    context.read<AllMembersCubit>().getMembers(
                          context,
                          command: context.read<AllMembersCubit>().state.command.copyWith(
                                memberFilterRequest: request,
                                skipCount: 0,
                                totalCount: 0,
                              ),
                        );
                  },
                  command: state.command,
                );
              },
            ),
            10.0.verticalSpace,
            BlocBuilder<AllMembersCubit, AllMembersInitial>(
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                final list = state.result;
                if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد تصنيفات');
                return SaedTableWidget(
                  fullHeight: 0.5.sh,
                  command: state.command,
                  title: _super_userList,
                  data: list
                      .mapIndexed(
                        (index, e) => [
                          e.id.toString(),
                          e.fullName,
                          e.collegeIdNumber,
                          e.facility,
                          (e.subscriptions.isEmpty || !e.subscriptions.last.isActive)
                              ? 'غير مشترك'
                              : (e.subscriptions.last.isNotExpired)
                                  ? 'مشترك'
                                  : 'اشتراك منتهي',
                          InkWell(
                            onTap: () => dialogSubscription(context, e.id),
                            child: const Icon(
                              Icons.edit_calendar,
                              color: Colors.green,
                            ),
                          ),
                          if (isAllowed(AppPermissions.members))
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
                                  IconButton(
                                    onPressed: () {
                                      downloadImage(e.id, e.collegeIdNumber);
                                    },
                                    icon: const Icon(Icons.qr_code, color: Colors.black),
                                  ),
                                  InkWell(
                                    onTap: () {
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void dialogSubscription(BuildContext context, int memberId) {
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

Future<void> downloadImage(int id, String name) async {
  final painter = QrPainter(
    data: id.toString(),
    version: QrVersions.auto,
    eyeStyle: const QrEyeStyle(
      color: AppColorManager.black,
      eyeShape: QrEyeShape.square,
    ),
    dataModuleStyle: const QrDataModuleStyle(
      color: AppColorManager.black,
      dataModuleShape: QrDataModuleShape.square,
    ),
  );
  final image = await painter.toImage(600);
  final pngBytes = await image.toByteData(format: ImageByteFormat.png);
  final blob = Blob([pngBytes!.buffer.asUint8List()], 'image/png');
  final url = Url.createObjectUrlFromBlob(blob);
  final anchor = AnchorElement(href: url)
    ..setAttribute('download', '$name.png')
    ..click();
}
