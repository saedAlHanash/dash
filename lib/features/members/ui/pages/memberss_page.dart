import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/util/pair_class.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_dash/core/widgets/images/image_multi_type.dart';
import 'package:qareeb_dash/core/widgets/item_info.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_dash/core/widgets/saed_taple_widget.dart';
import 'package:qareeb_dash/features/members/ui/pages/create_subscreption_page.dart';
import 'package:qareeb_dash/router/go_route_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/file_util.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../home/bloc/home_cubit/home_cubit.dart';
import '../../../home/ui/screens/dashboard_page.dart';
import '../../bloc/all_member_cubit/all_member_cubit.dart';
import '../../bloc/create_subscreption_cubit/create_subscreption_cubit.dart';
import '../../bloc/delete_member_cubit/delete_member_cubit.dart';
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
  if (isAllowed(AppPermissions.members)) 'عمليات',
];

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> with SingleTickerProviderStateMixin {
  var loading = false;
  var loading1 = false;
  var loading2 = false;
  var loading3 = false;
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAllowed(AppPermissions.members)
          ? StatefulBuilder(builder: (context, mState) {
              return FloatingActionBubble(
                // Menu items
                items: [
                  Bubble(
                    title: "إضافة طالب",
                    iconColor: Colors.white,
                    bubbleColor: AppColorManager.mainColor,
                    icon: Icons.add,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      context.pushNamed(GoRouteName.createMember);
                    },
                  ),
                  Bubble(
                    title: loading1 ? 'جاري التحميل...' : "تحميل ملف بطاقات الطلاب",
                    iconColor: Colors.white,
                    bubbleColor: AppColorManager.mainColor,
                    icon: Icons.credit_card,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      mState(() => loading1 = true);
                      context.read<AllMembersCubit>().getMembersAsyncPdf(context).then(
                        (value) {
                          mState(() => loading1 = false);
                        },
                      );
                    },
                  ),
                  Bubble(
                    title:
                        loading2 ? 'جاري التحميل...' : " تحديد تحميل ملف بطاقات الطلاب",
                    iconColor: Colors.white,
                    bubbleColor: AppColorManager.mainColor,
                    icon: Icons.credit_card,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      mState(() => loading2 = true);
                      context
                          .read<AllMembersCubit>()
                          .getMembersAsyncPdf(context, all: false)
                          .then(
                        (value) {
                          mState(() => loading2 = false);
                        },
                      );
                    },
                  ),
                  Bubble(
                    title: loading3 ? 'جاري التحميل...' : "تحميل ملف الطلاب ضمن مجال",
                    iconColor: Colors.white,
                    bubbleColor: AppColorManager.mainColor,
                    icon: Icons.credit_card,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (_) => RangeInputDialog(
                          onDone: (val) {
                            mState(() => loading3 = true);
                            context
                                .read<AllMembersCubit>()
                                .getMembersAsyncPdf(context, range: val)
                                .then(
                              (value) {
                                mState(() => loading3 = false);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Bubble(
                    title: loading ? 'جاري التحميل...' : "تحميل ملف إكسل",
                    iconColor: Colors.white,
                    bubbleColor: AppColorManager.mainColor,
                    icon: Icons.file_copy_rounded,
                    titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
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
                  ),
                ],

                // animation controller
                animation: _animation,

                // On pressed change animation state
                onPress: () => _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward(),

                // Floating Action button Icon color
                iconColor: AppColorManager.whit,

                // Flaoting Action button Icon
                iconData: Icons.settings,
                backGroundColor: AppColorManager.mainColor,
              );
            })
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
                  fullHeight: 1.8.sh,
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
                                    icon: ImageMultiType(
                                      url: Assets.iconsKey,
                                      width: 40.0.r,
                                      height: 40.0.r,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      downloadImageMargin(e.id, e.fullName);
                                    },
                                    icon: ImageMultiType(
                                      url: Assets.iconsQrCode,
                                      color: Colors.black,
                                      width: 40.0.r,
                                      height: 40.0.r,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      createSingleCard(e);
                                    },
                                    icon: ImageMultiType(
                                      url: Assets.iconsCard,
                                      color: AppColorManager.mainColor,
                                      width: 40.0.r,
                                      height: 40.0.r,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (isAllowed(AppPermissions.members))
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BlocConsumer<DeleteMemberCubit,
                                        DeleteMemberInitial>(
                                      listener: (context, state) {
                                        context
                                            .read<AllMembersCubit>()
                                            .getMembers(context);
                                      },
                                      listenWhen: (p, c) => c.statuses.done,
                                      buildWhen: (p, c) => c.id == e.id,
                                      builder: (context, state) {
                                        if (state.statuses.loading) {
                                          return MyStyle.loadingWidget();
                                        }
                                        return InkWell(
                                          onTap: () {
                                            context
                                                .read<DeleteMemberCubit>()
                                                .deleteMember(context, id: e.id);
                                          },
                                          child: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  // Define the padding
  const double padding = 24.0;

  // Calculate the new canvas size with padding
  const double canvasSize = 600 + (2 * padding);

  // Create a new canvas with the desired background color and padding
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromPoints(Offset.zero, Offset.zero));

  // Draw the background color
  canvas.drawRect(
      const Rect.fromLTWH(0, 0, canvasSize, canvasSize), Paint()..color = Colors.white);

  // Calculate the position of the image with padding
  const  imageX = padding;
  const  imageY = padding;

  // Draw the image on top of the background with padding
  final imageCodec = await instantiateImageCodec(pngBytes!.buffer.asUint8List());
  final frame = await imageCodec.getNextFrame();
  final imagePaint = Paint();
  canvas.drawImage(frame.image, const Offset(imageX, imageY), imagePaint);

  // Finalize the canvas and obtain the resulting image
  final picture = recorder.endRecording();
  final resultingImage = await picture.toImage(canvasSize.toInt(), canvasSize.toInt());


  // Use the resultingPngBytes as needed (e.g., save to a file, send over the network, etc.)
  final resultingPngByte = await resultingImage.toByteData(format: ImageByteFormat.png);

  saveImageFile(name: name, pngBytes: resultingPngByte!.buffer.asUint8List());

  // final blob = Blob([], 'image/png');
  // final url = Url.createObjectUrlFromBlob(blob);
  // final anchor = AnchorElement(href: url)
  //   ..setAttribute('download', '$name.png')
  //   ..click();
}

Future<void> downloadImageMargin(int id, String name) async {
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

  // Define the margin
  const double margin = 35.0;

  // Calculate the new canvas size with margin
  const double canvasSize = 600 + (2 * margin);

  // Create a new canvas with the desired background color and margin
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromPoints(Offset.zero, Offset.zero));

  // Draw the background color
  canvas.drawRect(
      const Rect.fromLTWH(0, 0, canvasSize, canvasSize), Paint()..color = Colors.white);

  // Calculate the position of the image with margin
  const double imageX = margin;
  const double imageY = margin;

  // Draw the image on top of the background with margin
  final imageCodec = await instantiateImageCodec(pngBytes!.buffer.asUint8List());
  final frame = await imageCodec.getNextFrame();
  final imagePaint = Paint();
  canvas.drawImage(frame.image, Offset(imageX, imageY), imagePaint);

  // Finalize the canvas and obtain the resulting image
  final picture = recorder.endRecording();
  final resultingImage = await picture.toImage(canvasSize.toInt(), canvasSize.toInt());


  // Use the resultingPngBytes as needed (e.g., save to a file, send over the network, etc.)
  final resultingPngByte = await resultingImage.toByteData(format: ImageByteFormat.png);

  saveImageFile(name: name, pngBytes: resultingPngByte!.buffer.asUint8List());

  // final blob = Blob([], 'image/png');
  // final url = Url.createObjectUrlFromBlob(blob);
  // final anchor = AnchorElement(href: url)
  //   ..setAttribute('download', '$name.png')
  //   ..click();
}

class RangeInputDialog extends StatefulWidget {
  const RangeInputDialog({super.key, required this.onDone});

  final Function(Pair<int, int> val) onDone;

  @override
  _RangeInputDialogState createState() => _RangeInputDialogState();
}

class _RangeInputDialogState extends State<RangeInputDialog> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('أدخل مجال'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: fromController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'من'),
          ),
          10.0.verticalSpace,
          TextField(
            controller: toController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'إلى'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('إلغاء'),
        ),
        TextButton(
          onPressed: () {
            int? from = int.tryParse(fromController.text);
            int? to = int.tryParse(toController.text);

            if (from != null && to != null && from <= to) {
              widget.onDone.call(Pair(from, to));
              Navigator.of(context).pop();
            } else {
              // Invalid range, show an error dialog
              showPlatformDialog(
                context: context,
                builder: (_) => BasicDialogAlert(
                  title: const Text('خطأ في المجال'),
                  content: const Text('يرجى إدخال مجال صالح'),
                  actions: [
                    BasicDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: const Text('تم'),
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text('تم'),
        ),
      ],
    );
  }
}
