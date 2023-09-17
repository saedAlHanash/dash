import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/util/note_message.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';
import 'package:qareeb_dash/core/widgets/not_found_widget.dart';
import 'package:qareeb_models/extensions.dart';

import '../../../../core/util/checker_helper.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../bloc/areas_cubit/areas_cubit.dart';
import '../../bloc/create_area_cubit/create_area_cubit.dart';
import '../../bloc/delete_area_cubit/delete_area_cubit.dart';
import '../../data/response/area_response.dart';

class AreasPage extends StatefulWidget {
  const AreasPage({super.key, required this.governorateId});

  final int governorateId;

  @override
  State<AreasPage> createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> {
  void showCreateDialog({AreaModel? request}) {
    request ??= AreaModel.fromJson({'governorateId': widget.governorateId});
    NoteMessage.showMyDialog(
      context,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<CreateAreaCubit>(),
          ),
          BlocProvider.value(
            value: context.read<AreasCubit>(),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(40.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.0.verticalSpace,
              MyTextFormNoLabelWidget(
                label: 'اسم المنطقة',
                initialValue: request.name,
                onChanged: (p0) => request!.name = p0,
              ),
              BlocConsumer<CreateAreaCubit, CreateAreaInitial>(
                listener: (context, state) {
                  context.read<AreasCubit>().getArea(
                        context,
                        id: widget.governorateId,
                      );
                  Navigator.pop(context, true);
                },
                listenWhen: (p, c) => c.statuses.done,
                builder: (context, state) {
                  if (state.statuses.isLoading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    onTap: () {
                      if (request!.name.isEmpty) return;
                      context
                          .read<CreateAreaCubit>()
                          .createArea(context, request: request);
                    },
                    text: request?.id != 0 ? 'تعديل' : 'إنشاء',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      floatingActionButton: isAllowed(AppPermissions.CREATION)
          ? FloatingActionButton(
              onPressed: () => showCreateDialog(),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      body: BlocBuilder<AreasCubit, AreasInitial>(
        builder: (context, state) {
          if (state.statuses.isLoading) {
            return MyStyle.loadingWidget();
          }
          final list = state.result;
          if (list.isEmpty) return const NotFoundWidget(text: 'لا يوجد مناطق');
          return Column(
            children: [
              DrawableText(
                text: 'مناطق محافظة ${state.result.firstOrNull?.governorate.name??''}',
                matchParent: true,
                size: 28.0.sp,
                textAlign: TextAlign.center,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final item = list[i];
                    return MyCardWidget(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
                      child: Row(
                        children: [
                          Expanded(
                            child: DrawableText(
                              text: item.name,
                              color: Colors.black,
                              fontFamily: FontManager.cairoBold,
                            ),
                          ),
                          BlocConsumer<DeleteAreaCubit, DeleteAreaInitial>(
                            listener: (context, state) {
                              context.read<AreasCubit>().getArea(
                                    context,
                                    id: widget.governorateId,
                                  );
                            },
                            listenWhen: (p, c) => c.statuses.done,
                            buildWhen: (p, c) => c.id == item.id,
                            builder: (context, state) {
                              if (state.statuses.isLoading) {
                                return MyStyle.loadingWidget();
                              }
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<DeleteAreaCubit>()
                                          .deleteArea(context, id: item.id);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showCreateDialog(request: item);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
